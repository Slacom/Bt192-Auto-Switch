#!/usr/bin/env python3
"""Execute unchanged actual015 smali under declared SDK/View/Prefs stubs.
Not ART/native/physical gesture proof. All unsupported instructions/calls fail.
"""
import re,json,struct,unittest
from pathlib import Path
from collections import OrderedDict
import test_device_icons as C
H=Path(__file__).resolve().parent
M={n:C.methods((H/(n+'.smali')).read_text()) for n in ('V3DeviceOrder','V3DeviceScroll')}
class Obj:
 def __init__(self,cls='View',**p):self.cls=cls;self.p=p
class Fault(Exception):pass
class VM:
 def __init__(self,commit='ok'):
  self.static={};self.memory={};self.disk={};self.commit=commit;self.clock=10000;self.calls=[];self.pending=None;self.ctx=Obj('Context')
 def run(self,cls,name,*args):
  k=[k for k in M[cls] if k.split('(')[0]==name];assert len(k)==1,(cls,name);return self.call(cls,k[0],list(args))
 def call(self,cls,sig,args):
  lines=M[cls][sig]['lines'];labels={s:i for i,s in enumerate(lines) if s.startswith(':')};handlers=[]
  for s in lines:
   h=re.match(r'\.catchall \{(:\w+) \.\. (:\w+)\} (:\w+)',s)
   if h:handlers.append(tuple(labels[x] for x in h.groups()))
  r={'p'+str(i):v for i,v in enumerate(args)};ret=exc=None;pc=steps=0
  def get(x):return r[x.strip()]
  def f(x):return float(x) if isinstance(x,float) else struct.unpack('<f',struct.pack('<I',int(x)&0xffffffff))[0]
  def null(x):return x is None or x==0
  while pc<len(lines):
   steps+=1;assert steps<15000,(cls,sig,'loop');s=lines[pc];op,_,tail=s.partition(' ');a=[x.strip() for x in tail.split(',')];nxt=pc+1
   try:
    if op.startswith(('.',':')):pass
    elif op=='return-void':return None
    elif op.startswith('return'):return get(tail)
    elif op=='const-string':r[a[0]]=json.loads(tail.split(',',1)[1])
    elif op.startswith('const'):r[a[0]]=int(a[1],0)
    elif op=='new-instance':
     kind=a[1];r[a[0]]=OrderedDict() if 'LinkedHashMap' in kind else [] if any(n in kind for n in ('ArrayList','LinkedHashSet')) else Obj(kind)
    elif op.startswith('move-result'):r[tail]=ret
    elif op=='move-exception':r[tail]=exc
    elif op.startswith('move'):r[a[0]]=get(a[1])
    elif op.startswith('sget'):r[a[0]]=self.static.get(a[1],0)
    elif op.startswith('sput'):self.static[a[1]]=get(a[0])
    elif op.startswith('iget'):r[a[0]]=get(a[1]).p.get(a[2].split('->')[1].split(':')[0],0)
    elif op.startswith('iput'):get(a[1]).p[a[2].split('->')[1].split(':')[0]]=get(a[0])
    elif op=='check-cast':pass
    elif op=='instance-of':r[a[0]]=int(isinstance(get(a[1]),str) if 'String;' in a[2] else isinstance(get(a[1]),Obj) and ('LinearLayout' in get(a[1]).cls))
    elif op=='array-length':r[a[0]]=len(get(a[1]))
    elif op.startswith('aget'):r[a[0]]=get(a[1])[get(a[2])]
    elif op=='goto':nxt=labels[tail]
    elif op.startswith('if-'):
     code=op[3:];x=get(a[0]);y=0 if code.endswith('z') else get(a[1]);code=code.removesuffix('z');x=0 if null(x) else x;y=0 if null(y) else y
     choose={'eq':lambda:x==y,'ne':lambda:x!=y,'lt':lambda:x<y,'le':lambda:x<=y,'gt':lambda:x>y,'ge':lambda:x>=y}[code]()
     if choose:nxt=labels[a[-1]]
    elif op.startswith('cmp'):
     x,y=get(a[1]),get(a[2]);r[a[0]]=(x>y)-(x<y)
    elif op in ('int-to-float','long-to-float'):r[a[0]]=float(get(a[1]))
    elif op in ('float-to-int','long-to-int','int-to-long'):r[a[0]]=int(get(a[1]))
    elif op in ('neg-int','neg-float'):r[a[0]]=-get(a[1])
    elif any(op.startswith(p) for p in ('add-','sub-','mul-','div-')):
     base=op.split('-')[0];two='/2addr' in op;lit='/lit' in op;x=get(a[0] if two else a[1]);y=get(a[1] if two else a[2]) if not lit else int(a[2],0)
     if '-float' in op:x,y=f(x),f(y)
     r[a[0]]={'add':lambda:x+y,'sub':lambda:x-y,'mul':lambda:x*y,'div':lambda:x/y if '-float' in op else int(x/y)}[base]()
    elif op.startswith('invoke-'):
     regs,target=re.match(r'\{(.*?)\}, (.*)',tail).groups()
     names=[x.strip() for x in regs.split(',')] if '..' not in regs else [regs.split('..')[0].strip()[0]+str(i) for i in range(int(re.search(r'\d+',regs.split('..')[0])[0]),int(re.search(r'\d+',regs.split('..')[1])[0])+1)]
     tokens=re.findall(r'\[*L[^;]+;|\[*[ZBSCIFJD]',target.split('(')[1].split(')')[0]);offset=0;vals=[]
     if not op.startswith('invoke-static'):vals=[get(names[0])];offset=1
     for t in tokens:vals.append(f(get(names[offset])) if t=='F' else get(names[offset]));offset+=2 if t in ('J','D') else 1
     c,method=target.split('->');own=c.split('/')[-1].rstrip(';')
     if own in M and not op.startswith('invoke-super'):ret=self.call(own,method,vals)
     else:ret=self.sdk(op,target,vals)
    else:raise AssertionError(('unsupported opcode',s))
   except Exception as err:
    if isinstance(err,AssertionError):raise
    hit=[c for start,end,c in handlers if start<=pc<end]
    if not hit:raise
    exc=err;nxt=hit[0]
   pc=nxt
  raise AssertionError(('fell through',sig))
 def sdk(self,op,t,v):
  self.calls.append((t,v));cls,method=t.split('->');name=method.split('(')[0]
  o=None if op.startswith('invoke-static') else v[0];a=v if o is None else v[1:]
  if op.startswith('invoke-super'):return True
  if cls=='Lbt192/auto/V3Ui;' and name=='dp':return a[1]
  if cls=='Landroid/os/SystemClock;':return self.clock
  if cls=='Landroid/view/ViewConfiguration;':return Obj('Config') if name=='get' else 500 if name=='getLongPressTimeout' else 8
  if name=='getScaledTouchSlop':return 8
  if cls=='Ljava/lang/Math;':return max(a) if name=='max' else min(a) if name=='min' else abs(a[0])
  if name=='<init>':return None
  if cls=='Ljava/lang/String;':
   return o.split(a[0]) if name=='split' else o.startswith(a[0]) if name=='startsWith' else o[a[0]:] if name=='substring' else len(o) if name=='length' else o+a[0] if name=='concat' else (_ for _ in ()).throw(AssertionError(t))
  if 'StringBuilder' in cls:
   if name=='append':o.p['text']=o.p.get('text','')+a[0];return o
   if name=='length':return len(o.p.get('text',''))
   if name=='toString':return o.p.get('text','')
  if 'SharedPreferences' in cls:
   if name=='getString':return self.memory.get(a[0],a[1])
   if name=='edit':self.pending={};return Obj('Editor')
   if name=='putString':self.pending[a[0]]=a[1];return o
   if name=='commit':
    self.memory.update(self.pending)
    if self.commit=='throw':raise Fault('after memory publish')
    if self.commit=='false':return False
    self.disk=dict(self.memory);return True
  if name=='getSharedPreferences':return Obj('Prefs')
  if 'Iterator' in cls:
   if name=='hasNext':return o.p['i']<len(o.p['items'])
   if name=='next':i=o.p['i'];o.p['i']+=1;return o.p['items'][i]
  if any(x in cls for x in ('Map;','List;','Set;')):
   if name=='iterator':return Obj('Iterator',items=list(o),i=0)
   if name=='add':
    if 'Set;' not in cls or a[0] not in o:o.append(a[0])
    return True
   if name=='addAll':o.extend(list(a[0]));return True
   if name=='put':o[a[0]]=a[1];return None
   if name=='remove':return o.pop(a[0],None)
   if name=='values':return list(o.values())
  if cls=='Landroid/view/MotionEvent;':
   if name=='obtain':return Obj('Event',action=3 if len(a)>1 else a[0].p['action'],x=100.0,y=20.0)
   if name=='getActionMasked':return o.p['action']
   if name=='getX':return o.p['x']
   if name=='getY':return o.p['y']
   if name=='setAction':o.p['action']=a[0];return None
   if name=='recycle':return None
  if name=='getMeasuredHeight':return o.p.get('measuredHeight',o.p.get('height',0))
  if name=='getPaddingTop':return o.p.get('paddingTop',0)
  if name in ('getHeight','getWidth','getTop','getBottom','getScrollY'):return o.p.get({'getHeight':'height','getWidth':'width','getTop':'top','getBottom':'bottom','getScrollY':'scroll'}[name],0)
  if name=='getTag':return o.p.get('tag',0)
  if name=='getContext':return self.ctx
  if name=='getParent':return o.p.get('parent',0)
  if name=='getChildCount':return len(o.p.get('children',[]))
  if name=='getChildAt':return o.p['children'][a[0]]
  if name=='indexOfChild':return o.p['children'].index(a[0]) if a[0] in o.p['children'] else -1
  if name=='removeView':o.p['children'].remove(a[0]);self.layout(o);return None
  if name=='removeAllViews':o.p['children']=[];return None
  if name=='addView':o.p['children'].insert(a[1] if len(a)>1 else len(o.p['children']),a[0]);self.layout(o);return None
  if name=='scrollTo':o.p['scroll']=a[1];return None
  if name=='scrollBy':o.p['scroll']=max(0,min(o.p.get('scroll',0)+a[1],o.p['children'][0].p['height']-o.p['height']));return None
  if name=='postDelayed':o.p['callback']=a[0];return True
  if name=='removeCallbacks':o.p.pop('callback',None);return True
  if name in ('setTranslationZ','setColor','setAlpha','setPadding','setVerticalScrollBarEnabled','requestDisallowInterceptTouchEvent','invalidate','postInvalidateOnAnimation','performHapticFeedback','setBackgroundColor'):return None
  if cls=='Landroid/widget/Toast;':return Obj('Toast') if name=='makeText' else None
  raise AssertionError(('unsupported SDK',t))
 def layout(self,o):
  for i,x in enumerate(o.p['children']):x.p.update(top=i*60,bottom=(i+1)*60)
  o.p['height']=60*len(o.p['children'])
 def make(self,n=6):
  rows=Obj('LinearLayout',children=[Obj(tag='order:'+f'02:00:00:00:00:{i+1:02X}',height=60) for i in range(n)])
  self.layout(rows);scroll=Obj('Lbt192/auto/V3DeviceScroll;',children=[rows],width=358,height=180,rail=20,slop=8,scroll=0)
  return scroll,rows
 def event(self,action,x=100.,y=20.):return Obj('Event',action=action,x=x,y=y)
class Tests(unittest.TestCase):
 def test_sort_persistence_and_new_devices_append(self):
  v=VM();v.memory['device_order_v1']='B,A,B,Z';rows=[['A','same'],['B','same'],['C','new']];self.assertEqual([r[0] for r in v.run('V3DeviceOrder','rows',v.ctx,rows)],['B','A','C']);self.assertEqual(rows[0][0],'A')
 def test_save_restart_model(self):
  v=VM();s,r=v.make();r.p['children'].reverse();self.assertTrue(v.run('V3DeviceOrder','save',v.ctx,r));w=VM();w.memory=dict(v.disk);rows=[[f'02:00:00:00:00:{i+1:02X}'] for i in range(6)];self.assertEqual(w.run('V3DeviceOrder','rows',w.ctx,rows)[0][0],'02:00:00:00:00:06')
 def test_commit_false_throw_pins_old_read(self):
  for mode in ('false','throw'):
   v=VM(mode);v.memory['device_order_v1']='OLD';s,r=v.make();self.assertFalse(v.run('V3DeviceOrder','save',v.ctx,r));self.assertEqual(v.run('V3DeviceOrder','read',v.ctx),'OLD');self.assertNotEqual(v.memory['device_order_v1'],'OLD')
 def test_drag_disabled_row_save_no_runtime_invokes(self):
  v=VM();s,r=v.make();r.p['children'][0].p['enabled']=False;first=r.p['children'][0]
  v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(0));self.assertEqual(s.p['mode'],1);v.run('V3DeviceScroll','run',s);self.assertEqual(s.p['mode'],2)
  v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(2,y=160.));v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(1,y=160.));self.assertIs(r.p['children'][2],first);self.assertFalse(s.p['touching']);self.assertNotIn('callback',s.p)
  self.assertFalse(any('bt192/auto' in t and 'V3Ui' not in t for t,a in v.calls))
 def test_cancel_rolls_back_without_write(self):
  v=VM();s,r=v.make();original=list(r.p['children']);v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(0));v.run('V3DeviceScroll','run',s);v.run('V3DeviceScroll','dragMove',s,160.);v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(3));self.assertEqual(r.p['children'],original);self.assertEqual(v.memory,{})
 def test_failed_drop_rolls_back(self):
  v=VM('false');s,r=v.make();original=list(r.p['children']);v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(0));v.run('V3DeviceScroll','run',s);v.run('V3DeviceScroll','dragMove',s,160.);v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(1,y=160.));self.assertEqual(r.p['children'],original)
 def test_movement_before_longpress_is_normal_scroll(self):
  v=VM();s,r=v.make();v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(0));v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(2,y=50.));self.assertEqual(s.p['mode'],0);self.assertNotIn('callback',s.p)
 def test_controls_and_icon_never_arm(self):
  for x in (20.,300.):
   v=VM();s,r=v.make();v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(0,x=x));self.assertEqual(s.p.get('mode',0),0)
 def test_multi_cancel_no_drop(self):
  v=VM();s,r=v.make();orig=list(r.p['children']);v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(0));v.run('V3DeviceScroll','run',s);v.run('V3DeviceScroll','dragMove',s,160.);v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(5));v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(1));self.assertEqual(r.p['children'],orig);self.assertFalse(s.p['touching']);self.assertEqual(v.memory,{})
 def test_thumb_lengths_and_progress_endpoints(self):
  sizes=[]
  for count in (6,12,30):
   v=VM();s,r=v.make(count);sizes.append(v.run('V3DeviceScroll','thumbHeight',s));v.run('V3DeviceScroll','thumbMove',s,180.);self.assertEqual(s.p['scroll'],count*60-180);v.run('V3DeviceScroll','thumbMove',s,0.);self.assertEqual(s.p['scroll'],0)
  self.assertGreater(sizes[0],sizes[1]);self.assertGreater(sizes[1],sizes[2])
 def test_no_scroll_for_three_or_less(self):
  for n in (0,1,3):
   v=VM();s,r=v.make(n);self.assertEqual(v.run('V3DeviceScroll','range',s),0)
 def test_fade_initial_active_delay_and_end(self):
  v=VM();s,r=v.make();self.assertEqual(v.run('V3DeviceScroll','railAlpha',s),0);s.p['fadeAt']=10000
  for elapsed,expected in ((0,255),(250,255),(450,127),(650,0)):
   v.clock=10000+elapsed;self.assertEqual(v.run('V3DeviceScroll','railAlpha',s),expected)
  s.p['mode']=3;self.assertEqual(v.run('V3DeviceScroll','railAlpha',s),255)
 def test_grab_existing_thumb_no_jump(self):
  v=VM();s,r=v.make();s.p['scroll']=90;v.run('V3DeviceScroll','thumbStart',s,55.);v.run('V3DeviceScroll','thumbMove',s,55.);self.assertEqual(s.p['scroll'],90)
 def test_edge_scroll_and_detach_cancels_callback(self):
  v=VM();s,r=v.make();v.run('V3DeviceScroll','dispatchTouchEvent',s,v.event(0));v.run('V3DeviceScroll','run',s);s.p['lastY']=179.;v.run('V3DeviceScroll','run',s);self.assertGreater(s.p['scroll'],0);v.run('V3DeviceScroll','onDetachedFromWindow',s);self.assertNotIn('callback',s.p);self.assertFalse(s.p['touching'])
 def test_hidden_identity_retained_but_not_invented(self):
  v=VM();s,r=v.make(1);v.memory['device_order_v1']='02:00:00:00:00:09';self.assertTrue(v.run('V3DeviceOrder','save',v.ctx,r));self.assertIn('02:00:00:00:00:09',v.disk['device_order_v1']);out=v.run('V3DeviceOrder','rows',v.ctx,[['02:00:00:00:00:01']]);self.assertEqual(len(out),1)
 def test_static_scope_and_terminal_guards(self):
  text=(H/'V3DeviceScroll.smali').read_text()+(H/'V3DeviceOrder.smali').read_text();self.assertNotRegex(text,r'(Bluetooth|V3Targets;|Worker;|V3Codec;|CdmTrigger;|V3StatusSampler;)')
  setup=(H/'V3Setup.smali').read_text();self.assertIn('->busy()Z',setup);self.assertIn('.method protected onPause()V\n    .locals 1',setup)
if __name__=='__main__':unittest.main(verbosity=2)
