#!/usr/bin/env python3
"""Independent minimal smali APK build. Requires Python3 + manually enabled MT MCP.
Does not read the old APK, install, alter settings, or overwrite a candidate.
Usage: python build.py --out /absolute/new/output prepare|compile|unsigned|signed
"""
import argparse,hashlib,json,re,runpy,sys,urllib.error
from pathlib import Path
from build_resources import make_seed
HERE=Path(__file__).resolve().parent
MT=runpy.run_path(str(HERE/'build_support/mt_rpc.py'));call=MT['call']
PACK=runpy.run_path(str(HERE/'build_support/apk_packaging.py'));check_packaging=PACK['check_resources_arsc']
CERT='a40da80a59d170caa950cf15c18c454d47a39b26989d8b640ecd745ba71bf5dc'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
p=argparse.ArgumentParser();p.add_argument('--out',required=True);p.add_argument('mode',choices=['prepare','compile','unsigned','signed']);a=p.parse_args();OUT=Path(a.out)
if not OUT.is_absolute():raise SystemExit('Use an explicit absolute output directory')
OUT=OUT.resolve()
if OUT==HERE or HERE in OUT.parents:raise SystemExit('Keep generated output separate from the immutable source tree')

def save(name,value):
    dest=OUT/name
    with dest.open('x',encoding='utf-8') as f:json.dump(value,f,ensure_ascii=False,indent=2)
def inputs():
    files=[*HERE.glob('smali/**/*.smali'),*HERE.glob('res/**/*.xml'),*HERE.glob('res/**/*.png'),*HERE.glob('artwork/*'),*HERE.glob('licenses/*'),*HERE.glob('build_support/*'),HERE/'Manifest.xml',HERE/'accessibility_service_config.xml',HERE/'build.py',HERE/'build_resources.py',HERE/'selection_identity.json']
    return {str(p.relative_to(HERE)):sha(p) for p in sorted(files) if p.is_file() and p.suffix!='.pyc'}
def state():return json.loads((OUT/'session.json').read_text())
def check_inputs():
    j=json.loads((OUT/'build_input.json').read_text());assert inputs()==j['sourceSHA256'],'Source changed after prepare; preserve output and use a new directory';return j

def new_text(s,locator,text,checkpoint):
    if (OUT/checkpoint).exists():return
    # Existing targets after a lost acknowledgement are not blindly overwritten.
    try:
        d=call('mt_apk_read_text',dict(**s,locator=locator,limit=2000,maxChars=131072,startLine=0,startColumn=0))
    except RuntimeError as e:
        if not any(code in str(e) for code in ('TARGET_NOT_FOUND','CLASS_NOT_FOUND','ENTRY_NOT_FOUND')):raise
    else:
        if not d['truncated'] and d['textWindow']['text'].replace('\r\n','\n')==text.replace('\r\n','\n'):
            save(checkpoint,dict(recoveredIdenticalTarget=True,targetVersion=d['targetVersion']));return
        raise RuntimeError('Target exists without saved receipt; inspect rather than retry: '+locator)
    result=call('mt_apk_edit_text',dict(**s,locator=locator,targetVersion='missing',edits=[dict(mode='write_target',matchText='',writeText=text)]));save(checkpoint,result)

try:
    if a.mode=='prepare':
        if OUT.exists() and any(OUT.iterdir()):raise RuntimeError('Nonempty output is protected; do not re-prepare')
        OUT.mkdir(parents=True,exist_ok=True);mapping=inputs();selected=json.loads((HERE/'selection_identity.json').read_text());smali=sorted(HERE.glob('smali/**/*.smali'));assert len(smali)==41
        for rel,h in selected['sourceSHA256'].items():assert sha(HERE/rel)==h
        seed=make_seed(HERE,OUT/'seed.apk');seed['installerResourcePackaging']=check_packaging(OUT/'seed.apk');save('seed_identity.json',seed);save('build_input.json',dict(buildId='v3_026',sourceSHA256=mapping,classCount=41,oldAPKRequiredForBuild=False,signatureRequired=CERT,scope='Internal slim candidate, not installed or released; must be reviewed'))
        w=call('mt_apk_workspace_open',dict(path=str(OUT/'seed.apk'),temporary=False));save('workspace.json',w);e=call('mt_apk_session_create',dict(workspaceId=w['workspaceId']));save('session.json',dict(workspaceId=w['workspaceId'],editSessionId=e['editSessionId']));print('Prepared independent minimal source/seed',seed)
    elif a.mode=='compile':
        check_inputs();s=state()
        if not (OUT/'manifest_edit.json').exists():
            d=call('mt_apk_read_text',dict(**s,locator='axml:AndroidManifest.xml',limit=2000,maxChars=131072,startLine=0,startColumn=0));assert not d['truncated'];save('manifest_edit.json',call('mt_apk_edit_text',dict(**s,locator='axml:AndroidManifest.xml',targetVersion=d['targetVersion'],edits=[dict(mode='write_target',matchText='',writeText=(HERE/'Manifest.xml').read_text())])))
        for file in sorted(HERE.glob('res/**/*.xml')):
            rel=str(file.relative_to(HERE));new_text(s,'axml:'+rel,file.read_text(),'xml_'+rel.replace('/','_')+'.json')
        new_text(s,'axml:res/xml/accessibility_service_config.xml',(HERE/'accessibility_service_config.xml').read_text(),'service_xml_edit.json')
        for file in sorted(HERE.glob('smali/**/*.smali')):
            text=file.read_text();cl=re.search(r'^\.class[^\n]*\s(L[^;\s]+;)\s*$',text,re.M)[1];new_text(s,'dex_class:'+cl,text,'class_'+cl[1:-1].replace('/','_')+'.json');print('Imported',cl,flush=True)
        c=call('mt_apk_session_check',dict(**s,runBuildChecks=True));save('compile_check.json',c);assert c['buildCheckStatus']=='passed' and not c['failedCount'] and not c['pendingCompileCount'],c;check_inputs();print('Compiled41 selected classes and own resource XML')
    else:
        check_inputs();s=state();c=call('mt_apk_session_check',dict(**s,runBuildChecks=True));assert c['buildCheckStatus']=='passed' and not c['failedCount'] and not c['pendingCompileCount'],c
        signed=a.mode=='signed';filename='bt192_v3_026_candidate_signed.apk' if signed else 'TEST_ONLY_026_unsigned.apk';output=OUT/filename;assert not output.exists()
        b=call('mt_apk_build',dict(**s,outputName=str(output),overwrite=False,sign=signed));save('signed_build.json' if signed else 'unsigned_build.json',b);assert Path(b['outputPath']).resolve()==output
        save('packaging_signed.json' if signed else 'packaging_unsigned.json',check_packaging(output))
        if signed:
            sig=b['signatureSummary'];assert b['signingPerformed'] and not sig['hasDifferentCertificates'] and {x['sha256'] for x in sig['certificates']}=={CERT},'STOP: different certificate, never uninstall to bypass'
        check_inputs();save('candidate_identity.json' if signed else 'unsigned_identity.json',dict(path=str(output),sha256=sha(output),bytes=output.stat().st_size,certificateSha256=CERT if signed else None,versionName='3',versionCode=68,classCount=41,status='Slim internal candidate; review and user testing pending; not installed/published'));print(filename,output.stat().st_size,sha(output))
except urllib.error.URLError as e:
    raise SystemExit('STOP: MT MCP unavailable. Ask user to manually enable; do not auto-retry/bypass. '+repr(e))
