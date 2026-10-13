#!/usr/bin/env python3
"""Actual-smali source control flow + SDK-shaped fault stubs, NOT ART/device.

Standalone, stdlib-only, no file writes/log replacement, network, MT or APK build.
Run with python -B. Unsupported opcodes/invokes fail instead of being ignored.
"""
import hashlib
import json
import re
import sys
import threading
import unittest
from pathlib import Path

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
NAMES = ('V3Icon', 'V3DevicePrefs', 'V3IconChoice')
SOURCES = {n: (HERE / (n + '.smali')).read_text(encoding='utf-8') for n in NAMES}


def methods(text):
    out = {}
    for match in re.finditer(r'^\.method ([^\n]+)\n(.*?)^\.end method', text, re.M | re.S):
        head, body = match.groups()
        sig = head.split()[-1]
        params = re.search(r'\((.*?)\)', sig)[1]
        ins = len(re.findall(r'\[*L[^;]+;|\[*[ZBSCIFJD]', params))
        ins += 0 if 'static ' in head else 1
        lines = [s.split('#', 1)[0].strip() for s in body.splitlines()]
        out[sig] = dict(head=head, body=body, local=int(re.search(r'\.locals (\d+)', body)[1]),
                        ins=ins, lines=[s for s in lines if s])
    return out


METHODS = {n: methods(s) for n, s in SOURCES.items()}


class Fault(Exception):
    pass


class Obj:
    def __init__(self, cls, **props):
        self.cls, self.props, self.calls = cls, props, []


class Prefs:
    def __init__(self, initial=None, commits=(), faults=None):
        self.memory = dict(initial or {})
        self.disk = dict(self.memory)
        self.modes = list(commits)
        self.faults = {k: list(v) for k, v in (faults or {}).items()}
        self.commits = []

    def hit(self, method):
        modes = self.faults.get(method, [])
        if modes and modes.pop(0) == 'throw':
            raise Fault('poison ' + method)

    def getInt(self, key, default):
        self.hit('getInt')
        value = self.memory.get(key, default)
        if type(value) is not int:
            raise Fault('ClassCastException poisoned preference')
        return value

    def edit(self):
        self.hit('edit')
        return Editor(self)


class Editor:
    def __init__(self, prefs):
        self.prefs, self.pending = prefs, {}

    def putInt(self, key, value):
        self.prefs.hit('putInt')
        self.pending[key] = value
        return self

    def commit(self):
        p = self.prefs
        p.commits.append(dict(self.pending))
        p.memory.update(self.pending)  # Android memory publication precedes disk result.
        self.pending.clear()
        mode = p.modes.pop(0) if p.modes else 'ok'
        if mode == 'throw':
            raise Fault('commit threw AFTER memory publication')
        if mode == 'false':
            return False
        p.disk = dict(p.memory)
        return True


class VM:
    """Narrow actual source interpreter. Does not model ART verification/rendering."""
    def __init__(self, prefs=None, faults=None):
        self.prefs = prefs or Prefs()
        self.fields = {}
        self.faults = {k: list(v) for k, v in (faults or {}).items()}
        self.events = []
        self.shown = []
        self.cached_rows = []  # Declared SDK-shaped Store.devices cache, not Bluetooth.
        self.cache_reads = 0
        self.response_overrides = {}  # Explicit fault-injected facade responses only.
        self.app_calls = []
        # Acquisition happens ONLY when an actual monitor-enter opcode executes.
        # No declared-synchronized/header magic, nor a global VM-call lock.
        self.monitors = {'Lbt192/auto/V3DevicePrefs;': threading.RLock()}
        self.monitor_depth = threading.local()
        self.monitor_events = []
        self.monitor_hook = None
        self.ctx = Obj('Lbt192/auto/V3Setup;', finishing=False, destroyed=False, refresh=0)

    def hit(self, site):
        modes = self.faults.get(site, [])
        if modes and modes.pop(0) == 'throw':
            raise Fault('injected ' + site)

    def run(self, cls, name, *args):
        matches = [s for s in METHODS[cls] if s.split('(')[0] == name]
        assert len(matches) == 1, (cls, name)
        return self.call(cls, matches[0], list(args))

    def call(self, cls, sig, args):
        if cls == 'V3DevicePrefs' and sig.split('(')[0] not in ('kind', 'save'):
            assert getattr(self.monitor_depth, 'depth', 0) > 0, 'private prefs body lacks actual monitor'
        m = METHODS[cls][sig]
        lines = m['lines']
        labels, payload = {}, False
        for i, s in enumerate(lines):
            if s.startswith('.packed-switch'):
                payload = True
            elif s.startswith('.end packed-switch'):
                payload = False
            elif s.startswith(':') and not payload:
                labels[s] = i
        handlers = []
        for s in lines:
            h = re.match(r'\.catchall \{(:\w+) \.\. (:\w+)\} (:\w+)', s)
            if h:
                handlers.append(tuple(labels[x] for x in h.groups()))
        regs = {'p' + str(i): a for i, a in enumerate(args)}
        result = exc = None
        pc = steps = 0
        while pc < len(lines):
            steps += 1
            assert steps < 3000, 'infinite smali flow'
            s = lines[pc]
            nxt = pc + 1
            op, _, tail = s.partition(' ')
            a = [x.strip() for x in tail.split(',')]
            try:
                if s.startswith(('.', ':')):
                    pass
                elif op in ('return', 'return-object'):
                    value = regs[tail]
                    return None if op == 'return-object' and value == 0 else value
                elif op == 'return-void':
                    return None
                elif op == 'const-string':
                    reg, value = tail.split(',', 1)
                    regs[reg] = json.loads(value.strip())
                elif op == 'const-class':
                    self.hit('const-class')
                    regs[a[0]] = a[1]
                elif op == 'monitor-enter':
                    self.hit('monitor-enter')
                    token = regs[tail]
                    assert token == 'Lbt192/auto/V3DevicePrefs;', 'unexpected lock target'
                    thread = threading.current_thread().name
                    self.monitor_events.append(('attempt', thread))
                    if self.monitor_hook:
                        self.monitor_hook('attempt', thread)
                    self.monitors[token].acquire()
                    self.monitor_depth.depth = getattr(self.monitor_depth, 'depth', 0) + 1
                    self.monitor_events.append(('enter', thread))
                elif op == 'monitor-exit':
                    token = regs[tail]
                    assert getattr(self.monitor_depth, 'depth', 0) > 0, 'release without acquired monitor'
                    self.monitor_depth.depth -= 1
                    self.monitor_events.append(('exit', threading.current_thread().name))
                    self.monitors[token].release()
                elif op.startswith('const'):
                    regs[a[0]] = int(a[1], 0)
                elif op.startswith('move-result'):
                    regs[tail] = result
                elif op == 'move-exception':
                    regs[tail] = exc
                elif op in ('move', 'move-object'):
                    regs[a[0]] = regs[a[1]]
                elif op == 'new-instance':
                    self.hit('new:' + a[1])
                    regs[a[0]] = Obj(a[1])
                elif op.startswith('sget'):
                    if a[1].startswith('Lbt192/auto/'):
                        regs[a[0]] = self.fields.get(a[1], None if op == 'sget-object' else 0)
                    else:
                        regs[a[0]] = a[1]  # Locale.US / Paint enum tokens.
                elif op.startswith('sput'):
                    self.fields[a[1]] = regs[a[0]]
                elif op.startswith('iget'):
                    field = a[2].split('->')[1].split(':')[0]
                    regs[a[0]] = regs[a[1]].props.get(field)
                elif op.startswith('iput'):
                    field = a[2].split('->')[1].split(':')[0]
                    regs[a[1]].props[field] = regs[a[0]]
                elif op == 'int-to-float':
                    regs[a[0]] = float(regs[a[1]])
                elif op == 'array-length':
                    obj = regs[a[1]]
                    if not isinstance(obj, Obj) or 'values' not in obj.props:
                        raise Fault('NullPointerException array')
                    regs[a[0]] = len(obj.props['values'])
                elif op == 'aget-object':
                    obj, index = regs[a[1]], regs[a[2]]
                    if not isinstance(obj, Obj) or not 0 <= index < len(obj.props.get('values', [])):
                        raise Fault('ArrayIndexOutOfBoundsException')
                    regs[a[0]] = obj.props['values'][index]
                elif op == 'check-cast':
                    val = regs[a[0]]
                    if val and (not isinstance(val, Obj) or val.cls != a[1]):
                        raise Fault('ClassCastException')
                elif op == 'instance-of':
                    val = regs[a[1]]
                    regs[a[0]] = isinstance(val, Obj) and val.cls == a[2]
                elif op.startswith('if-'):
                    if op.endswith('z'):
                        x, y, label = regs[a[0]], 0, a[1]
                        x = 0 if x is None else x
                        cmp = op[3:-1]
                    else:
                        x, y, label = regs[a[0]], regs[a[1]], a[2]
                        cmp = op[3:]
                    condition = {'eq': lambda: x == y, 'ne': lambda: x != y, 'lt': lambda: x < y}[cmp]()
                    if condition:
                        nxt = labels[label]
                elif op.startswith('goto'):
                    nxt = labels[tail]
                elif op == 'packed-switch':
                    idx = labels[a[1]] + 1
                    base = int(lines[idx].split()[-1], 0)
                    idx += 1
                    targets = []
                    while not lines[idx].startswith('.end packed-switch'):
                        targets.append(lines[idx])
                        idx += 1
                    value = regs[a[0]]
                    if base <= value < base + len(targets):
                        nxt = labels[targets[value - base]]
                elif op.startswith('invoke-'):
                    mat = re.fullmatch(r'invoke-[\w/-]+ \{([^}]*)\}, (\S+)', s)
                    assert mat, s
                    rlist, ref = mat.groups()
                    argv = [regs[r.strip()] for r in rlist.split(',')] if rlist else []
                    result = self.invoke(op, ref, argv)
                else:
                    raise AssertionError('unsupported instruction ' + s)
            except Fault as err:
                handler = next((h for start, stop, h in handlers if start <= pc < stop), None)
                if handler is None:
                    raise
                exc, nxt = err, handler
            pc = nxt
        raise AssertionError('fell through ' + sig)

    def invoke(self, op, ref, a):
        owner, sig = ref.split('->')
        name = sig.split('(')[0]
        self.hit(owner + '->' + name)
        if not op.startswith('invoke-static') and (a[0] is None or a[0] == 0):
            raise Fault('NullPointerException receiver')
        if owner.startswith('Lbt192/auto/'):
            self.app_calls.append((owner, name))
            responses = self.response_overrides.get(ref, [])
            if responses:
                return responses.pop(0)
            if owner == 'Lbt192/auto/V3StatusStore;':
                assert sig == 'devices()Ljava/util/List;'
                self.cache_reads += 1
                return self.cached_rows
            cls = owner.split('/')[-1][:-1]
            if cls in METHODS and sig in METHODS[cls]:
                return self.call(cls, sig, a)
            if owner == 'Lbt192/auto/V3Setup;':
                if name in ('isFinishing', 'isDestroyed'):
                    return a[0].props['finishing' if name == 'isFinishing' else 'destroyed']
                if name == 'requireDeviceConnected':
                    return a[0].props.get('connected',True)  # current connectivity modeled, not real SDK
                if name == 'iconChanged':
                    a[0].props['refresh'] += 1
                    self.events.append(('refresh',))
                    return None
            if cls == 'V3Ui':
                self.hit('helper:' + name)
                modes = self.faults.get('null:' + name, [])
                if modes and modes.pop(0) == 'null':
                    return None
                if name == 'dp':
                    return a[1]
                if name == 'box':
                    return Obj('Landroid/widget/LinearLayout;', children=[], Orientation=a[1])
                if name == 'card':
                    background = Obj('Landroid/graphics/drawable/GradientDrawable;', Stroke=(1, -0x1c1811), Color=-1, CornerRadius=12.0)
                    return Obj('Landroid/widget/LinearLayout;', children=[], Orientation=1, Background=background)
                if name == 'label':
                    return Obj('Landroid/widget/TextView;', text=a[1], style=a[2])
                if name == 'icon':
                    self.run('V3Icon', 'pathFor', a[1])
                    return Obj('Landroid/widget/ImageView;', kind=a[1], ink=a[2], circle=a[3])
            raise AssertionError('unexpected app invoke ' + ref)
        if owner == 'Ljava/lang/String;':
            if name == 'trim':
                return a[0].strip(' \t\n\r\f\v')
            if name == 'toUpperCase':
                assert a[1] == 'Ljava/util/Locale;->US:Ljava/util/Locale;'
                return a[0].upper()
            if name == 'concat':
                return a[0] + a[1]
            if name == 'equalsIgnoreCase':
                return isinstance(a[1], str) and a[0].lower() == a[1].lower()
            if name == 'isEmpty':
                return len(a[0]) == 0
        if owner == 'Ljava/util/List;' and name == 'iterator':
            return Obj('Ljava/util/Iterator;', values=list(a[0]), index=0)
        if owner == 'Ljava/util/Iterator;':
            if name == 'hasNext':
                return a[0].props['index'] < len(a[0].props['values'])
            if name == 'next':
                index = a[0].props['index']
                if index >= len(a[0].props['values']):
                    raise Fault('NoSuchElementException')
                a[0].props['index'] += 1
                return a[0].props['values'][index]
        if owner == 'Landroid/bluetooth/BluetoothAdapter;':
            assert name == 'checkBluetoothAddress'
            return re.fullmatch(r'[0-9A-F]{2}(?::[0-9A-F]{2}){5}', a[0]) is not None
        if owner == 'Ljava/lang/Integer;':
            if name == 'valueOf':
                return Obj(owner, value=a[0])  # Boxed zero is NON-null, unlike int zero.
            if name == 'intValue':
                return a[0].props['value']
        if owner == 'Ljava/util/HashMap;':
            obj = a[0]
            if name == '<init>':
                obj.props['map'] = {}
                return None
            mapping = obj.props['map']
            if name == 'get':
                return mapping.get(a[1])
            if name == 'put':
                old = mapping.get(a[1]); mapping[a[1]] = a[2]
                return old
            if name == 'remove':
                return mapping.pop(a[1], None)
        if owner == 'Ljava/lang/ref/WeakReference;':
            if name == '<init>':
                a[0].props['referent'] = a[1]
                return None
            if name == 'get':
                return a[0].props.get('referent')
        if owner == 'Landroid/content/Context;':
            if name == 'getApplicationContext':
                return a[0].props.get('appContext', a[0])
            if name == 'getSharedPreferences':
                assert a[1:] == ['v3_ui_prefs', 0]
                return self.prefs
        if owner.startswith('Landroid/content/SharedPreferences'):
            assert name in ('getInt', 'edit', 'putInt', 'commit'), name
            return getattr(a[0], name)(*a[1:])
        if owner == 'Landroidx/core/graphics/PathParser;':
            assert name == 'createPathFromPathData'
            return Obj('Landroid/graphics/Path;', data=a[0])
        if owner == 'Landroid/widget/Toast;' and name == 'makeText':
            self.events.append(('toast', a[1]))
            return Obj(owner)
        if name == '<init>' and owner in ('Ljava/lang/Object;', 'Landroid/widget/LinearLayout$LayoutParams;',
                                          'Landroid/app/AlertDialog$Builder;', 'Landroid/graphics/drawable/GradientDrawable;'):
            a[0].props['constructor'] = a[1:]
            return None
        obj = a[0]
        assert isinstance(obj, Obj), ref
        obj.calls.append((name, a[1:]))
        if name.startswith('set'):
            obj.props[name[3:]] = a[1] if len(a) == 2 else tuple(a[1:])
            return obj
        if name == 'addView':
            obj.props['children'].append(a[1])
            return None
        if name == 'getTag':
            return obj.props['Tag']
        if name == 'create' and owner == 'Landroid/app/AlertDialog$Builder;':
            return Obj('Landroid/app/AlertDialog;', builder=obj)
        if name == 'show':
            if owner == 'Landroid/app/AlertDialog;':
                self.shown.append(obj)
            return None
        if name == 'dismiss':
            obj.props['dismissed'] = True
            return None
        raise AssertionError('unsupported SDK invoke ' + ref)


A = 'AA:BB:CC:DD:EE:01'
B = 'AA:BB:CC:DD:EE:02'
KEY = lambda mac: 'device_icon:' + mac


class Tests(unittest.TestCase):
    def test_public_contract_and_isolation(self):
        expected = {'kind(Landroid/content/Context;Ljava/lang/String;)I',
                    'save(Landroid/content/Context;Ljava/lang/String;I)Z'}
        self.assertEqual({s for s, m in METHODS['V3DevicePrefs'].items() if m['head'].startswith('public ')}, expected)
        for sig in expected:
            m = METHODS['V3DevicePrefs'][sig]
            self.assertTrue(m['head'].startswith('public static '))
            self.assertNotIn('synchronized', m['head'])
            self.assertIn('const-class v0, Lbt192/auto/V3DevicePrefs;', m['lines'])
            self.assertEqual(m['lines'].count('monitor-enter v0'), 1)
            self.assertEqual(m['lines'].count('monitor-exit v0'), 2)
            helper = sig.replace('(', 'Locked(', 1)
            self.assertTrue(METHODS['V3DevicePrefs'][helper]['head'].startswith('private static '))
            self.assertIn('Lbt192/auto/V3DevicePrefs;->' + helper, m['body'])
            self.assertLess(m['body'].index('monitor-enter'), m['body'].index('invoke-static'))
            self.assertLess(m['body'].index('invoke-static'), m['body'].index('monitor-exit'))
            self.assertIn('.catchall {:work_start .. :work_end} :locked_failure', m['lines'])
            self.assertIn('.catchall {:enter_start .. :enter_end} :unlocked_failure', m['lines'])
            unlocked = '\n'.join(m['lines'][m['lines'].index(':unlocked_failure') + 1:])
            self.assertNotRegex(unlocked, r'\bv0\b')
        self.assertIn('show(Lbt192/auto/V3Setup;Ljava/lang/String;)V', METHODS['V3IconChoice'])
        for text in (SOURCES['V3DevicePrefs'], SOURCES['V3IconChoice']):
            refs = re.findall(r'invoke-\S+ \{[^}]*\}, (L[^;]+;)->([^\(]+)', text)
            allowed = {'V3DevicePrefs', 'V3IconChoice', 'V3Icon', 'V3Ui', 'V3Setup', 'V3StatusStore'}
            for owner, method in refs:
                if owner.startswith('Lbt192/auto/'):
                    self.assertIn(owner.split('/')[-1][:-1], allowed)
                if owner == 'Landroid/bluetooth/BluetoothAdapter;':
                    self.assertEqual(method, 'checkBluetoothAddress')
                if owner == 'Lbt192/auto/V3StatusStore;':
                    self.assertEqual(method, 'devices')
                self.assertNotIn(method, ('activate', 'associate', 'requestAssociation', 'getDefaultAdapter', 'error'))
            self.assertNotIn('v3_settings', text)
            targets = re.findall(r'const-class \w+, (L[^;]+;)', text)
            self.assertTrue(all(target == 'Lbt192/auto/V3DevicePrefs;' for target in targets))
        self.assertNotIn('monitor-enter', SOURCES['V3IconChoice'])
        self.assertIn('.field private final mac:Ljava/lang/String;', SOURCES['V3IconChoice'])
        self.assertIn('owner:Ljava/lang/ref/WeakReference;', SOURCES['V3IconChoice'])

    def test_explicit_monitor_exception_paths_release_and_default(self):
        for method, helper, args in (('kind', 'kindLocked', (A,)), ('save', 'saveLocked', (A, 9))):
            for site in ('const-class', 'monitor-enter', 'Lbt192/auto/V3DevicePrefs;->' + helper):
                with self.subTest(method=method, site=site):
                    vm = VM(faults={site: ['throw']})
                    self.assertEqual(vm.run('V3DevicePrefs', method, vm.ctx, *args), 0)
                    self.assertEqual(getattr(vm.monitor_depth, 'depth', 0), 0)
                    exits = [e for e in vm.monitor_events if e[0] == 'exit']
                    enters = [e for e in vm.monitor_events if e[0] == 'enter']
                    self.assertEqual(len(exits), len(enters))
                    result, errors = [], []
                    def retry():
                        try:
                            result.append(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 9))
                        except BaseException as err:
                            errors.append(err)
                    thread = threading.Thread(target=retry, name='exception-retry', daemon=True)
                    thread.start(); thread.join(timeout=3)
                    self.assertFalse(thread.is_alive(), 'monitor leaked into next caller')
                    self.assertFalse(errors)
                    self.assertEqual(result, [True])

    def test_actual_monitor_serializes_commit_reader_and_other_mac_writer(self):
        # Pause AFTER failed commit memory publication, while a reader and another
        # MAC writer both attempt the actual class monitor. No implicit VM lock.
        class BlockingEditor(Editor):
            def commit(self):
                p = self.prefs
                p.commits.append(dict(self.pending))
                p.memory.update(self.pending)
                self.pending.clear()
                mode = p.modes.pop(0) if p.modes else 'ok'
                if p.block_next:
                    p.block_next = False
                    p.published.set()
                    if not p.release.wait(timeout=3):
                        raise AssertionError('test did not release paused commit')
                if mode == 'throw':
                    raise Fault('injected AFTER memory publication')
                if mode == 'false':
                    return False
                p.disk = dict(p.memory)
                return True
        class BlockingPrefs(Prefs):
            def __init__(self, old):
                super().__init__({KEY(A): old}, ['false', 'throw'])
                self.published, self.release = threading.Event(), threading.Event()
                self.block_next = True
            def edit(self):
                return BlockingEditor(self)
        for old, new in ((0, 9), (9, 0)):
            with self.subTest(old=old):
                p = BlockingPrefs(old)
                vm = VM(p)
                attempted = {name: threading.Event() for name in ('reader', 'other-writer')}
                done = {name: threading.Event() for name in ('first-writer', 'reader', 'other-writer')}
                def hook(op, name):
                    if name in attempted:
                        attempted[name].set()
                vm.monitor_hook = hook
                results, errors, threads = {}, [], []
                def operation(name, method, *args):
                    try:
                        results[name] = vm.run('V3DevicePrefs', method, vm.ctx, *args)
                    except BaseException as err:
                        errors.append(err)
                    finally:
                        done[name].set()
                def launch(name, method, *args):
                    thread = threading.Thread(target=operation, args=(name, method, *args), name=name, daemon=True)
                    threads.append(thread); thread.start()
                try:
                    launch('first-writer', 'save', A, new)
                    self.assertTrue(p.published.wait(timeout=3))
                    self.assertEqual(p.memory[KEY(A)], new)
                    launch('reader', 'kind', A)
                    launch('other-writer', 'save', B, 9)
                    for event in attempted.values():
                        self.assertTrue(event.wait(timeout=3))
                    self.assertFalse(done['reader'].is_set())
                    self.assertFalse(done['other-writer'].is_set())
                    self.assertEqual([e for e in vm.monitor_events if e[0] == 'enter'], [('enter', 'first-writer')])
                finally:
                    p.release.set()
                    for thread in threads:
                        thread.join(timeout=3)
                self.assertTrue(all(not thread.is_alive() for thread in threads))
                self.assertFalse(errors)
                self.assertEqual(results, {'first-writer': False, 'reader': old, 'other-writer': True})
                self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), old)
                self.assertTrue(vm.run('V3DevicePrefs', 'save', vm.ctx, A, new))
                self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), new)
                active = None
                for event, thread in vm.monitor_events:
                    if event == 'enter':
                        self.assertIsNone(active, 'two source bodies inside one monitor')
                        active = thread
                    elif event == 'exit':
                        self.assertEqual(active, thread)
                        active = None
                self.assertIsNone(active)

    def test_registers_labels_and_invokes(self):
        for cls, entries in METHODS.items():
            for sig, m in entries.items():
                labels = {s for s in m['lines'] if s.startswith(':')}
                for s in m['lines']:
                    if s.startswith(('.', ':')):
                        continue
                    op = s.split()[0]
                    operands = s.split(', L', 1)[0].split('"', 1)[0]
                    for r in re.findall(r'\b([vp]\d+)\b', operands):
                        n = int(r[1:]) + (m['local'] if r[0] == 'p' else 0)
                        self.assertLess(n, m['local'] + m['ins'], (cls, sig, s))
                        if op.startswith('invoke-') or op in ('const/4', 'move', 'move-object', 'iget-object',
                                                             'iput-object', 'if-eq', 'if-ne', 'instance-of'):
                            self.assertLess(n, 16, (cls, sig, s))
                    if op.startswith('invoke-'):
                        rlist, ref = re.fullmatch(r'invoke-[\w/-]+ \{([^}]*)\}, (\S+)', s).groups()
                        argv = [r for r in rlist.split(',') if r.strip()]
                        desc = re.search(r'\((.*?)\)', ref)[1]
                        expected = sum(2 if t in ('J', 'D') else 1 for t in re.findall(r'\[*L[^;]+;|\[*[ZBSCIFJD]', desc))
                        expected += 0 if op.startswith('invoke-static') else 1
                        self.assertEqual(len(argv), expected, (cls, sig, s))
                        self.assertLessEqual(len(argv), 5, s)
                    if op.startswith(('if-', 'goto', 'packed-switch')):
                        target = s.split()[-1]
                        self.assertIn(target, labels, s)
        # Handler safety invariant: UI NEW-failure catch blocks inspect no NEW registers.
        for sig in ('option(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;',
                    'show(Lbt192/auto/V3Setup;Ljava/lang/String;)V'):
            body = METHODS['V3IconChoice'][sig]['body']
            caught = body.split('    :caught\n')[1]
            self.assertNotRegex(caught, r'\b(invoke|iget|iput|check-cast|if-)[^\n]*\bv[0-8]\b')

    def test_ten_original_paths_and_legacy_nine_unchanged(self):
        vm = VM()
        paths = [vm.run('V3Icon', 'pathFor', n).props['data'] for n in range(10)]
        self.assertEqual(len(set(paths)), 10)
        self.assertIsNone(vm.run('V3Icon', 'pathFor', -1))
        self.assertIsNone(vm.run('V3Icon', 'pathFor', 10))
        self.assertGreaterEqual(paths[9].count('M'), 4)
        self.assertIn('V18.5', paths[9])  # Two deliberate stems.
        self.assertIn('S14', paths[9])
        for path in paths:
            self.assertRegex(path, r'^M')
            self.assertNotRegex(path, r'[^MCLHVSAQZTmlchvsaqzt0-9., +\-]')
            numbers = [float(x) for x in re.findall(r'-?\d+(?:\.\d+)?', path)]
            self.assertTrue(all(0 <= x <= 24 for x in numbers))
        old = (HERE.parent / 'v3_006' / 'V3Icon.smali').read_text(encoding='utf-8')
        old_paths = re.findall(r'const-string v0, "([^"]+)"', old)
        self.assertEqual(paths[:9], old_paths)
        # All original public API, paint/draw/getOpacity implementations retained.
        old_methods = methods(old)
        for sig, m in old_methods.items():
            if sig != 'pathFor(I)Landroid/graphics/Path;':
                self.assertEqual(METHODS['V3Icon'][sig], m)
        failing = VM(faults={'Landroidx/core/graphics/PathParser;->createPathFromPathData': ['throw']})
        self.assertIsNone(failing.run('V3Icon', 'pathFor', 9))

    def test_normalization_defaults_and_restart(self):
        vm = VM()
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 0)
        self.assertTrue(vm.run('V3DevicePrefs', 'save', vm.ctx, ' \taa:bb:cc:dd:ee:01\n', 9))
        self.assertEqual(vm.prefs.disk, {KEY(A): 9})
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A.lower()), 9)
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, B), 0)
        restarted = VM(Prefs(vm.prefs.disk))
        self.assertEqual(restarted.run('V3DevicePrefs', 'kind', restarted.ctx, A), 9)
        self.assertTrue(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 0))
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 0)
        for mac in (None, '', 'device name', 'AA-BB-CC-DD-EE-01', 'AA:BB:CC:DD:EE:0G', A + ':FF'):
            self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, mac), 0)
            self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, mac, 9))
        for kind in (-1, 1, 8, 10, 999):
            self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, kind))
        bad = VM(Prefs({KEY(A): 77}))
        self.assertEqual(bad.run('V3DevicePrefs', 'kind', bad.ctx, A), 0)

    def test_commit_false_throw_and_all_rollback_modes_preserve_old_ui(self):
        for old, new in ((0, 9), (9, 0)):
            for fault in ('false', 'throw'):
                for rollback in ('ok', 'false', 'throw'):
                    with self.subTest(old=old, fault=fault, rollback=rollback):
                        p = Prefs({KEY(A): old, KEY(B): 9}, [fault, rollback])
                        vm = VM(p)
                        self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, new))
                        self.assertEqual(p.commits, [{KEY(A): new}, {KEY(A): old}])
                        # Force external preference memory to the FAILED value: ledger wins.
                        p.memory[KEY(A)] = new
                        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), old)
                        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, B), 9)
                        self.assertTrue(vm.run('V3DevicePrefs', 'save', vm.ctx, A, new))
                        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), new)
                        ledger = vm.fields['Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;'].props['map']
                        self.assertNotIn(KEY(A), ledger)
                        self.assertEqual(VM(Prefs(p.disk)).run('V3DevicePrefs', 'kind', vm.ctx, A), new)

    def test_retry_clears_only_its_key(self):
        p = Prefs({KEY(A): 9, KEY(B): 0}, ['false', 'false', 'throw', 'throw'])
        vm = VM(p)
        self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 0))
        self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, B, 9))
        self.assertTrue(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 0))
        p.memory[KEY(B)] = 9
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 0)
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, B), 0)
        ledger = vm.fields['Lbt192/auto/V3DevicePrefs;->failed:Ljava/util/HashMap;'].props['map']
        self.assertEqual({k: v.props['value'] for k, v in ledger.items()}, {KEY(B): 0})

    def test_poison_read_prepare_write_and_rollback_editor(self):
        p = Prefs({KEY(A): 'poison'})
        vm = VM(p)
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 0)
        self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 9))
        self.assertFalse(p.commits)
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', None, A), 0)
        self.assertFalse(vm.run('V3DevicePrefs', 'save', None, A, 9))
        for site in ('Landroid/content/Context;->getApplicationContext',
                     'Landroid/content/Context;->getSharedPreferences'):
            vm = VM(faults={site: ['throw', 'throw']})
            self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 0)
            self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 9))
            self.assertFalse(vm.prefs.commits)
        vm = VM(); vm.ctx.props['appContext'] = None
        self.assertTrue(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 9))
        for method in ('getInt', 'edit', 'putInt'):
            p = Prefs({KEY(A): 9}, faults={method: ['throw']})
            vm = VM(p)
            self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 0))
            self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 9)
        p = Prefs({KEY(A): 9}, ['false'], {'edit': ['ok', 'throw']})
        vm = VM(p)
        self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 0))
        self.assertEqual(p.memory[KEY(A)], 0)  # Rollback editor never even exists.
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 9)
        for site in ('new:Ljava/util/HashMap;', 'Ljava/util/HashMap;->put'):
            vm = VM(Prefs(), {site: ['throw']})
            self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 9))
            self.assertFalse(vm.prefs.commits)  # Ledger pre-arms before edit/commit.
            self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 9))
            self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 0)
        vm = VM(Prefs({KEY(A): 9}), {'Ljava/util/HashMap;->remove': ['throw']})
        self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 0))
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 9)
        self.assertEqual(vm.prefs.disk[KEY(A)], 9)

    def show(self, vm):
        vm.run('V3IconChoice', 'show', vm.ctx, A.lower())
        self.assertEqual(len(vm.shown), 1)
        dialog = vm.shown[0]
        root = dialog.props['builder'].props['View']
        self.assertEqual(dialog.props['builder'].props['Title'], '选择设备图标')
        self.assertEqual(root.props['Orientation'], 1)
        identity, row, note = root.props['children']
        self.assertIn(A, identity.props['text'])
        self.assertEqual(row.props['Orientation'], 0)
        self.assertEqual(note.props['text'], '按设备保存，重启后保留；仅更换外观，不影响关联与切换。')
        return dialog, row.props['children']

    def pane(self, vm, mac=A):
        chooser = Obj('Lbt192/auto/V3IconChoice;')
        vm.run('V3IconChoice', '<init>', chooser, vm.ctx, mac)
        root = vm.run('V3IconChoice', 'content', chooser, vm.ctx)
        self.assertIsNotNone(root)
        self.assertEqual(root.props['Orientation'], 1)
        identity, row, note = root.props['children']
        self.assertEqual(identity.props['text'], chooser.props['identity'])
        self.assertIn(mac, identity.props['text'])
        self.assertEqual(row.props['Orientation'], 0)
        self.assertEqual(note.props['text'], '按设备保存，重启后保留；仅更换外观，不影响关联与切换。')
        self.assertEqual(len(row.props['children']), 2)
        return chooser, root, row.props['children']

    def assert_current(self, cards, kind):
        self.assertEqual([card.props['Tag'].props['value'] for card in cards], [9, 0])
        self.assertEqual(sum(bool(card.props['Selected']) for card in cards), 1)
        for card in cards:
            selected = card.props['Tag'].props['value'] == kind
            self.assertEqual(bool(card.props['Selected']), selected)
            # Actual source executes GradientDrawable.setStroke only on current.
            stroke = (2, -0xda9c15) if selected else (1, -0x1c1811)
            self.assertEqual(card.props['Background'].props['Stroke'], stroke)
            icon, title, check = card.props['children']
            self.assertEqual(check.props['text'], '✓ 已选择' if selected else ' ')
            self.assertEqual(check.props['style'], 4)  # V3Ui's blue label style.
            self.assertEqual(check.props['TextSize'], 0x41400000)  # F bits:12sp.
            self.assertEqual(icon.props['circle'], -0x120c01)
            self.assertEqual(card.props['MinimumHeight'], 144)
            self.assertGreaterEqual(card.props['MinimumWidth'], 44)
            self.assertEqual(card.props['ContentDescription'], title.props['text'] + ('，已选择' if selected else ''))

    def test_current_decoration_actual_source_both_kinds_immutable_snapshot(self):
        option = METHODS['V3IconChoice']['option(Landroid/content/Context;ILjava/lang/String;)Landroid/widget/LinearLayout;']
        self.assertIn('private ', option['head'])
        self.assertNotIn('static ', option['head'])
        self.assertEqual(option['ins'], 4)
        for field in ('currentKind:I', 'identity:Ljava/lang/String;', 'mac:Ljava/lang/String;'):
            self.assertIn('.field private final ' + field, SOURCES['V3IconChoice'])
        for kind in (0, 9):
            with self.subTest(kind=kind):
                vm = VM(Prefs({KEY(A): kind}))
                chooser, root, cards = self.pane(vm)
                self.assertEqual(chooser.props['currentKind'], kind)
                self.assert_current(cards, kind)
                self.assertFalse(vm.prefs.commits)
                self.assertFalse(vm.shown)  # Pure full pane, no Dialog.show.
                self.assertEqual(vm.events, [])
                vm.prefs.memory[KEY(A)] = 9 if kind == 0 else 0
                vm.ctx.props['selectedMac'] = B
                root_again = vm.run('V3IconChoice', 'content', chooser, vm.ctx)
                self.assert_current(root_again.props['children'][1].props['children'], kind)
                _, _, new_cards = self.pane(vm)
                self.assert_current(new_cards, 9 if kind == 0 else 0)
                self.assertFalse(any('V3IconChoice;->current' in key for key in vm.fields))

    def test_identity_cached_names_by_mac_not_name_and_fallback(self):
        def row(*values):
            return Obj('[Ljava/lang/String;', values=list(values))
        vm = VM(Prefs({KEY(A): 9, KEY(B): 0}))
        vm.cached_rows = [row(B, '同名耳机'), row(A.lower(), ' 同名耳机 ')]
        chooser_a, _, cards_a = self.pane(vm, A)
        chooser_b, _, cards_b = self.pane(vm, B)
        self.assertEqual(chooser_a.props['identity'], '同名耳机\n' + A)
        self.assertEqual(chooser_b.props['identity'], '同名耳机\n' + B)
        self.assert_current(cards_a, 9)
        self.assert_current(cards_b, 0)
        vm.cached_rows = [row(A, '后来变更的名称')]
        pane_again = vm.run('V3IconChoice', 'content', chooser_a, vm.ctx)
        self.assertEqual(pane_again.props['children'][0].props['text'], '同名耳机\n' + A)
        self.assertFalse(vm.prefs.commits)
        for rows in (None, [], [None, row(), row(A)], [row(B, '仅另一设备')],
                     [row(A, '')], [row(A, '  ')], [row(A, None)], [Obj('Ljava/lang/String;')]):
            with self.subTest(rows=rows):
                vm = VM(); vm.cached_rows = rows
                chooser, root, _ = self.pane(vm)
                self.assertEqual(chooser.props['identity'], A)
                self.assertEqual(root.props['children'][0].props['text'], A)
                self.assertFalse(vm.prefs.commits)
        for site in ('Lbt192/auto/V3StatusStore;->devices', 'Ljava/util/List;->iterator',
                     'Ljava/util/Iterator;->hasNext', 'Ljava/util/Iterator;->next'):
            vm = VM(faults={site: ['throw']}); vm.cached_rows = [row(A, '真实缓存名')]
            chooser, _, _ = self.pane(vm)
            self.assertEqual(chooser.props['identity'], A)
            self.assertFalse(vm.prefs.commits)

    def test_read_poison_or_facade_fault_decorates_default_not_fake_saved(self):
        for p, faults, overrides in (
            (Prefs({KEY(A): 9}, faults={'getInt': ['throw']}), {}, {}),
            (Prefs({KEY(A): 9}), {'Lbt192/auto/V3DevicePrefs;->kind': ['throw']}, {}),
            (Prefs({KEY(A): 9}), {}, {'Lbt192/auto/V3DevicePrefs;->kind(Landroid/content/Context;Ljava/lang/String;)I': [77]}),
        ):
            vm = VM(p, faults); vm.response_overrides = overrides
            chooser, _, cards = self.pane(vm)
            self.assertEqual(chooser.props['currentKind'], 0)
            self.assert_current(cards, 0)
            self.assertEqual(p.disk, {KEY(A): 9})
            self.assertFalse(p.commits)
            self.assertFalse(vm.events)

    def test_failed_save_reopen_retry_restart_current_visuals(self):
        for old, new in ((0, 9), (9, 0)):
            for fault in ('false', 'throw'):
                with self.subTest(old=old, fault=fault):
                    vm = VM(Prefs({KEY(A): old}, [fault, 'false']))
                    _, cards = self.show(vm)
                    self.assert_current(cards, old)
                    target = next(card for card in cards if card.props['Tag'].props['value'] == new)
                    vm.run('V3IconChoice', 'onClick', target.props['OnClickListener'], target)
                    self.assertIn(('toast', '图标未保存；读取异常时使用默认图标'), vm.events)
                    vm.prefs.memory[KEY(A)] = new  # Failed SP memory is not display authority.
                    chooser, _, reopened = self.pane(vm)
                    self.assertEqual(chooser.props['currentKind'], old)
                    self.assert_current(reopened, old)
                    target = next(card for card in reopened if card.props['Tag'].props['value'] == new)
                    vm.run('V3IconChoice', 'onClick', target.props['OnClickListener'], target)
                    self.assertIn(('toast', '图标已保存'), vm.events)
                    _, _, saved = self.pane(vm)
                    self.assert_current(saved, new)
                    restarted = VM(Prefs(vm.prefs.disk))
                    _, _, persisted = self.pane(restarted)
                    self.assert_current(persisted, new)

    def test_choice_two_cards_captured_mac_save_only_and_failure_toast(self):
        for index, kind in ((0, 9), (1, 0)):
            vm = VM(Prefs({KEY(A): 0 if kind == 9 else 9}))
            dialog, cards = self.show(vm)
            self.assertEqual([c.props['Tag'].props['value'] for c in cards], [9, 0])
            for card in cards:
                self.assertGreaterEqual(card.props['MinimumWidth'], 44)
                self.assertGreaterEqual(card.props['MinimumHeight'], 44)
                self.assertEqual(card.props['children'][0].props['circle'], -0x120c01)
            listener = cards[index].props['OnClickListener']
            self.assertEqual(listener.props['mac'], A)
            vm.ctx.props['selectedMac'] = B  # Selection changed while chooser was open.
            vm.run('V3IconChoice', 'onClick', listener, cards[index])
            self.assertEqual(vm.prefs.disk[KEY(A)], kind)
            self.assertNotIn(KEY(B), vm.prefs.disk)
            self.assertEqual(vm.ctx.props['refresh'], 1)
            self.assertIn(('toast', '图标已保存'), vm.events)
            self.assertTrue(dialog.props['dismissed'])
        vm = VM(Prefs({KEY(A): 9}, ['false', 'throw']))
        _, cards = self.show(vm)
        vm.run('V3IconChoice', 'onClick', cards[1].props['OnClickListener'], cards[1])
        self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 9)
        self.assertIn(('toast', '图标未保存；读取异常时使用默认图标'), vm.events)
        self.assertEqual(vm.ctx.props['refresh'], 1)

    def test_old_tws_ledger_poison_never_claims_old_icon_preserved(self):
        # Old9 may fall back to 0 when the pre-commit failure ledger itself is
        # poisoned. The stored value stays 9, but UI must not claim preservation.
        for site in ('new:Ljava/util/HashMap;', 'Ljava/util/HashMap;->put'):
            with self.subTest(site=site):
                vm = VM(Prefs({KEY(A): 9}), {site: ['throw']})
                self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 9)
                dialog, cards = self.show(vm)
                vm.run('V3IconChoice', 'onClick', cards[1].props['OnClickListener'], cards[1])
                self.assertFalse(vm.prefs.commits)
                self.assertEqual(vm.prefs.disk, {KEY(A): 9})
                self.assertEqual(vm.prefs.memory, {KEY(A): 9})
                self.assertEqual(vm.run('V3DevicePrefs', 'kind', vm.ctx, A), 0)
                self.assertEqual(vm.events, [('toast', '图标未保存；读取异常时使用默认图标'), ('refresh',)])
                self.assertNotIn(('toast', '图标已保存'), vm.events)
                self.assertFalse(any('保留原图标' in str(event) for event in vm.events))
                self.assertEqual(vm.ctx.props['refresh'], 1)
                self.assertTrue(dialog.props['dismissed'])
                self.assertFalse(vm.run('V3DevicePrefs', 'save', vm.ctx, A, 9))
                chooser, _, default_cards = self.pane(vm)
                self.assertEqual(chooser.props['currentKind'], 0)
                self.assert_current(default_cards, 0)
                self.assertEqual(vm.prefs.disk, {KEY(A): 9})
                self.assertNotIn(('toast', '图标已保存'), vm.events)

    def test_cancel_stale_destroyed_finishing_and_invalid_tag_no_save(self):
        vm = VM()
        dialog, _ = self.show(vm)
        # Native negative/cancel is deliberately null, not an action listener.
        self.assertEqual(dialog.props['builder'].props['NegativeButton'], ('取消', 0))
        self.assertFalse(vm.prefs.commits)
        for mode in ('finishing', 'destroyed', 'weak_gone', 'invalid_tag'):
            vm = VM()
            dialog, cards = self.show(vm)
            listener = cards[0].props['OnClickListener']
            if mode in ('finishing', 'destroyed'):
                vm.ctx.props[mode] = True
            elif mode == 'weak_gone':
                listener.props['owner'].props['referent'] = None
            else:
                cards[0].props['Tag'] = 'device name'
            vm.run('V3IconChoice', 'onClick', listener, cards[0])
            self.assertFalse(vm.prefs.commits)
            self.assertFalse(vm.events)
            self.assertTrue(dialog.props['dismissed'])
        for mode in ('finishing', 'destroyed'):
            vm = VM(); vm.ctx.props[mode] = True
            vm.run('V3IconChoice', 'show', vm.ctx, A)
            self.assertFalse(vm.shown)
            self.assertEqual(vm.cache_reads, 0)
            self.assertFalse(vm.prefs.commits)

    def test_partial_identity_check_note_and_blue_border_failures_no_dialog(self):
        # Execute actual option/content handlers at every label slot, including
        # visible check and below-cards note; never accept partially marked cards.
        for kind in (0, 9):
            for slot in range(1, 7):
                for fault in ('null', 'throw'):
                    with self.subTest(kind=kind, slot=slot, fault=fault):
                        site = ('null:' if fault == 'null' else 'helper:') + 'label'
                        vm = VM(Prefs({KEY(A): kind}), {site: ['ok'] * (slot - 1) + [fault]})
                        vm.run('V3IconChoice', 'show', vm.ctx, A)
                        self.assertFalse(vm.shown)
                        self.assertFalse(vm.prefs.commits)
                        self.assertFalse(vm.events)
            for method in ('setColor', 'setCornerRadius', 'setStroke'):
                vm = VM(Prefs({KEY(A): kind}), {'Landroid/graphics/drawable/GradientDrawable;->' + method: ['throw']})
                vm.run('V3IconChoice', 'show', vm.ctx, A)
                self.assertFalse(vm.shown)
                self.assertFalse(vm.prefs.commits)
            vm = VM(Prefs({KEY(A): kind}), {'null:box': ['ok', 'null']})
            vm.run('V3IconChoice', 'show', vm.ctx, A)
            self.assertFalse(vm.shown)
            self.assertFalse(vm.prefs.commits)

    def test_nullable_throwing_helpers_and_constructors(self):
        for helper in ('card', 'box', 'icon', 'label'):
            for fault in ('null', 'throw'):
                site = ('null:' if fault == 'null' else 'helper:') + helper
                vm = VM(faults={site: [fault]})
                vm.run('V3IconChoice', 'show', vm.ctx, A)
                self.assertFalse(vm.shown, (helper, fault))
                self.assertFalse(vm.prefs.commits)
        for cls in ('Lbt192/auto/V3IconChoice;', 'Ljava/lang/ref/WeakReference;',
                    'Landroid/widget/LinearLayout$LayoutParams;', 'Landroid/graphics/drawable/GradientDrawable;',
                    'Landroid/app/AlertDialog$Builder;'):
            for site in ('new:' + cls, cls + '-><init>'):
                vm = VM(faults={site: ['throw']})
                vm.run('V3IconChoice', 'show', vm.ctx, A)
                self.assertFalse(vm.shown)
                self.assertFalse(vm.prefs.commits)
        vm = VM(faults={'Landroid/widget/Toast;->makeText': ['throw']})
        _, cards = self.show(vm)
        vm.run('V3IconChoice', 'onClick', cards[0].props['OnClickListener'], cards[0])
        self.assertEqual(vm.ctx.props['refresh'], 1)
        self.assertEqual(vm.prefs.disk, {KEY(A): 9})


if __name__ == '__main__':
    print(json.dumps({'kind': 'actual smali source/static + SDK-shaped host fault simulation; NOT ART/APK/device/rendering',
                      'sourceSHA256': {n: hashlib.sha256(s.encode()).hexdigest() for n, s in SOURCES.items()}},
                     ensure_ascii=False, indent=2), flush=True)
    unittest.main(verbosity=2)
