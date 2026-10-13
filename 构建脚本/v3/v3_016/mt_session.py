#!/usr/bin/env python3
"""Isolated v3 MT session. Never installs, overwrites baselines or changes settings."""
import hashlib,json,runpy,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
OUT=ROOT/'构建产物/v3/v3_016'
BASE=ROOT/'构建产物/v3/v3_015/bt192_v3_015_candidate_signed.apk'
SHA='99dbbf93653dda51d39fa1f7f7aa620f5114fcbcef81170d6d439152555f5d81'
rpc=runpy.run_path(str(ROOT/'工具/mtmcp.py'))['rpc']
def call(name,args):
    raw=rpc('tools/call',{'name':name,'arguments':args},timeout=300)
    if raw.get('error'):raise RuntimeError(raw)
    res=raw['result']; data=res.get('structuredContent')
    if data is None:data=json.loads(res['content'][0]['text'])
    if res.get('isError') or not data['ok']:raise RuntimeError(data)
    return data['data']
def session():return json.loads((OUT/'session.json').read_text())
def save(path,obj):
    with path.open('x',encoding='utf-8') as f:json.dump(obj,f,ensure_ascii=False,indent=2)
def read_target(s,locator):
    d=call('mt_apk_read_text',dict(**s,locator=locator,limit=2000,maxChars=131072,startLine=0,startColumn=0))
    if d['truncated']:raise RuntimeError('Text truncated: '+locator)
    return d
mode=sys.argv[1]
if mode=='prepare':
    if hashlib.sha256(BASE.read_bytes()).hexdigest()!=SHA:raise RuntimeError('Baseline SHA mismatch')
    if OUT.exists():
        if not OUT.is_dir() or any(OUT.iterdir()):raise RuntimeError('Existing nonempty output directory; do not reuse')
    else:OUT.mkdir(parents=True,exist_ok=False)
    policy=call('mt_file_get_access_policy',{})
    save(OUT/'access_policy.json',policy)
    w=call('mt_apk_workspace_open',dict(path=str(BASE),temporary=False))
    save(OUT/'baseline_workspace.json',w)
    e=call('mt_apk_session_create',dict(workspaceId=w['workspaceId']))
    s=dict(workspaceId=w['workspaceId'],editSessionId=e['editSessionId'])
    save(OUT/'session.json',s)
    (HERE/'实际基线').mkdir(exist_ok=False)
    for cls in ['AutoApp','AutoEntry','Worker','A2dpRx','CdmTrigger','CdmService','CdmCb','Tick','WatchService2','Toaster']:
        d=read_target(s,'dex_class:Lbt192/auto/'+cls+';')
        save(OUT/(cls+'_read.json'),d)
        with (HERE/'实际基线'/(cls+'.smali')).open('x',encoding='utf-8') as f:f.write(d['textWindow']['text'])
    d=read_target(s,'axml:AndroidManifest.xml');save(OUT/'manifest_read.json',d)
    with (HERE/'实际基线/Manifest.xml').open('x',encoding='utf-8') as f:f.write(d['textWindow']['text'])
    print('Prepared immutable baseline and isolated v3 session',s)
elif mode=='push':
    s=session()
    for arg in sys.argv[2:]:
        p=(HERE/arg).resolve(); p.relative_to(HERE.resolve())
        text=p.read_text()
        if p.suffix=='.smali':
            import re
            cls=re.search(r'^\.class .* (L[^\s]+;)$',text,re.M).group(1)
            locator='dex_class:'+cls
        elif p.name=='Manifest.xml':locator='axml:AndroidManifest.xml'
        else:raise ValueError(arg)
        # Push needs only the optimistic target version; a one-line metadata
        # observation is not a claim that the large class text was fully read.
        try:d=call('mt_apk_read_text',dict(**s,locator=locator,limit=1,maxChars=4096,startLine=0,startColumn=0));version=d['targetVersion']
        except RuntimeError as err:
            if 'TARGET_NOT_FOUND' not in str(err) and 'CLASS_NOT_FOUND' not in str(err):raise
            version='missing'
        result=call('mt_apk_edit_text',dict(**s,locator=locator,targetVersion=version,edits=[dict(mode='write_target',matchText='',writeText=text)]))
        print(arg,json.dumps(result,ensure_ascii=False))
elif mode=='check':
    print(json.dumps(call('mt_apk_session_check',dict(**session(),runBuildChecks=True)),ensure_ascii=False,indent=2))
elif mode=='build':
    import zipfile
    if hashlib.sha256(BASE.read_bytes()).hexdigest()!=SHA:raise RuntimeError('Baseline SHA mismatch')
    candidate=(OUT/'bt192_v3_016_candidate_signed.apk').resolve()
    candidate.relative_to(ROOT.resolve())
    if candidate.exists():raise RuntimeError('Candidate already exists; never overwrite')
    s=session(); checks=call('mt_apk_session_check',dict(**s,runBuildChecks=True))
    if checks['buildCheckStatus']!='passed' or checks['failedCount'] or checks['pendingCompileCount']:raise RuntimeError(checks)
    sources={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in HERE.glob('*.smali')}
    sources['Manifest.xml']=hashlib.sha256((HERE/'Manifest.xml').read_bytes()).hexdigest()
    save(OUT/'build_input.json',dict(buildId='v3_016',plannedRelease='v3',status='internal candidate; not installed or approved',baselineSha256=SHA,sourceSha256=sources,session=s,checks=checks))
    built=call('mt_apk_build',dict(**s,outputName=str(candidate),overwrite=False,sign=True))
    save(OUT/'build_result.json',built)
    if Path(built['outputPath']).resolve()!=candidate:raise RuntimeError('Unexpected output path')
    cert='a40da80a59d170caa950cf15c18c454d47a39b26989d8b640ecd745ba71bf5dc'
    sig=built['signatureSummary']
    if not built['signingPerformed'] or sig['hasDifferentCertificates'] or {x['sha256'] for x in sig['certificates']}!={cert}:raise RuntimeError('STOP: certificate differs; do not uninstall to bypass')
    with zipfile.ZipFile(candidate) as z:
        if z.testzip() is not None:raise RuntimeError('APK ZIP corrupted')
    if hashlib.sha256(BASE.read_bytes()).hexdigest()!=SHA:raise RuntimeError('Baseline changed')
    save(OUT/'candidate_identity.json',dict(path=str(candidate.relative_to(ROOT)),sha256=hashlib.sha256(candidate.read_bytes()).hexdigest(),certificateSha256=cert,versionName='3',versionCode=68,status='internal candidate awaiting independent actual-APK review and user-confirmed installation'))
    print(json.dumps(built,ensure_ascii=False,indent=2))
else:raise ValueError(mode)
