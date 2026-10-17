#!/usr/bin/env python3
"""Minimal Android resource table and emptyDEX bootstrap, no original APK needed.
Resource ids intentionally stable; only eight explicitly declared resources exist.
"""
import struct,hashlib,zlib,zipfile,json
from pathlib import Path

def align(b):return b+b'\0'*((-len(b))%4)
def length8(n):
    assert 0<=n<32768
    return bytes([n]) if n<128 else bytes([(n>>8)|128,n&255])
def pool(strings):
    offsets=[];body=b''
    for s in strings:
        offsets.append(len(body));v=s.encode();body+=length8(len(s.encode('utf-16-le'))//2)+length8(len(v))+v+b'\0'
    start=28+4*len(strings);body=align(body)
    return struct.pack('<HHIIIIII',1,28,start+len(body),len(strings),0,256,start,0)+b''.join(struct.pack('<I',i) for i in offsets)+body

def resource_table():
    paths=['res/drawable/ic_launcher_background.xml','res/drawable/ic_launcher_foreground.xml','res/mipmap-anydpi-v26/ic_launcher.xml','res/mipmap-anydpi-v26/ic_launcher_round.xml','res/xml/accessibility_service_config.xml']
    strings=paths+['BT192 Switch','在设备与系统支持的条件下，将已关联并启用的蓝牙音频设备自动切换至192kHz。服务不读取屏幕内容，也不执行触控手势。','res/drawable-nodpi/bt192_switch.png']
    keys=['ic_launcher_background','ic_launcher_foreground','ic_launcher','ic_launcher_round','app_name','accessibility_desc','accessibility_service_config','bt192_switch']
    resources={7:{0x95:(0,0),0x96:(1,1),0x97:(7,7)},13:{0:(2,2),1:(3,3)},15:{0x1d:(4,5),0x1b:(5,6)},18:{0:(6,4)}}
    types=['unused_'+str(i) for i in range(1,19)]
    for i,name in [(7,'drawable'),(13,'mipmap'),(15,'string'),(18,'xml')]:types[i-1]=name
    tp=pool(types);kp=pool(keys);chunks=b''
    for typ,entries in sorted(resources.items()):
        count=max(entries)+1;flags=[0x40000000 if i in entries else 0 for i in range(count)]
        chunks+=struct.pack('<HHIBBHI',0x202,16,16+4*count,typ,0,0,count)+b''.join(struct.pack('<I',v) for v in flags)
        config=struct.pack('<I',64)+b'\0'*60;header=20+len(config);offsets=[];data=b''
        for i in range(count):
            if i not in entries:offsets.append(0xffffffff);continue
            offsets.append(len(data));k,si=entries[i];data+=struct.pack('<HHI',8,2,k)+struct.pack('<HBBI',8,0,3,si)
        start=header+4*count
        chunks+=struct.pack('<HHIBBHII',0x201,header,start+len(data),typ,0,0,count,start)+config+b''.join(struct.pack('<I',v) for v in offsets)+data
    name='bt192.auto'.encode('utf-16-le').ljust(256,b'\0');size=288+len(tp)+len(kp)+len(chunks)
    package=struct.pack('<HHII256sIIIII',0x200,288,size,0x7f,name,288,18,288+len(tp),len(keys),0)+tp+kp+chunks
    sp=pool(strings)
    return struct.pack('<HHII',2,12,12+len(sp)+len(package),1)+sp+package

def empty_dex():
    dex=bytearray(140);dex[:8]=b'dex\n039\0';struct.pack_into('<20I',dex,32,140,112,0x12345678,0,0,112,*([0]*12),28,112);struct.pack_into('<I',dex,112,2);struct.pack_into('<HHII',dex,116,0,0,1,0);struct.pack_into('<HHII',dex,128,0x1000,0,1,112);dex[12:32]=hashlib.sha1(dex[32:]).digest();struct.pack_into('<I',dex,8,zlib.adler32(dex[12:]));return bytes(dex)

def make_seed(source,output):
    source=Path(source);output=Path(output);assert not output.exists()
    with zipfile.ZipFile(output,'x',compression=zipfile.ZIP_DEFLATED) as z:
        z.writestr('AndroidManifest.xml',(source/'build_support/bootstrap_manifest.axml').read_bytes())
        # Android R+ rejects compressed OR unaligned resource tables (-124).
        entry=zipfile.ZipInfo('resources.arsc');entry.compress_type=zipfile.ZIP_STORED
        base=z.fp.tell()+30+len(entry.filename.encode('utf-8'))
        pad=(-base-4)%4
        entry.extra=struct.pack('<HH',0xFFFF,pad)+b'\0'*pad
        z.writestr(entry,resource_table())
        z.writestr('classes.dex',empty_dex())
        for p in sorted((source/'res').rglob('*.png')):
            z.writestr(str(p.relative_to(source)),p.read_bytes())
        for p in sorted((source/'licenses').glob('*')):
            if p.is_file():z.writestr('assets/licenses/'+p.name,p.read_bytes())
    return dict(sha256=hashlib.sha256(output.read_bytes()).hexdigest(),bytes=output.stat().st_size,classes=0,declaredResourceCount=8,originalAPKRequired=False)
