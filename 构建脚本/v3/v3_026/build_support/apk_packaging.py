"""Installer-facing APK packaging checks (distinct from ART/signature checks)."""
from pathlib import Path
import struct,zipfile,hashlib

def check_resources_arsc(path):
    path=Path(path);b=path.read_bytes()
    with zipfile.ZipFile(path) as z:
        assert len(z.namelist())==len(set(z.namelist())), 'Duplicate ZIP entry'
        i=z.getinfo('resources.arsc');o=i.header_offset
        assert b[o:o+4]==b'PK\x03\x04'
        flags,method=struct.unpack_from('<HH',b,o+6);nl,el=struct.unpack_from('<HH',b,o+26);start=o+30+nl+el
        result=dict(compression=i.compress_type,localCompression=method,dataOffset=start,alignment4=start%4,stored=i.compress_type==zipfile.ZIP_STORED and method==0,aligned4=start%4==0,encrypted=bool(flags&1),bytes=i.file_size,contentSHA256=hashlib.sha256(z.read(i)).hexdigest())
        assert result['stored'], 'INSTALL_PARSE_FAILED_RESOURCES_ARSC_COMPRESSED (-124): resource table must be ZIP_STORED for targetSDK30+'
        assert result['aligned4'], 'INSTALL_PARSE_FAILED_RESOURCES_ARSC_COMPRESSED (-124): resource table data must be 4-byte aligned'
        assert not result['encrypted']
        assert len(z.read(i))==i.file_size and i.compress_size==i.file_size
        return result
