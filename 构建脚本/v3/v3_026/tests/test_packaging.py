"""Self-contained host tests. No MT/device/old APK required."""
from pathlib import Path
import hashlib,json,runpy,struct,tempfile,unittest,warnings,zipfile
SRC=Path(__file__).resolve().parents[1]
B=runpy.run_path(str(SRC/'build_resources.py'))
check=runpy.run_path(str(SRC/'build_support/apk_packaging.py'))['check_resources_arsc']

class PackagingTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory(prefix='bt192-packaging-')
        self.root=Path(self.tmp.name).resolve()
        assert self.root.parent==Path(tempfile.gettempdir()).resolve()
    def tearDown(self):
        assert Path(self.tmp.name).resolve()==self.root
        assert self.root.parent==Path(tempfile.gettempdir()).resolve()
        self.tmp.cleanup()
    def test_seed_is_stored_and_aligned(self):
        p=self.root/'seed.apk';B['make_seed'](SRC,p);v=check(p)
        self.assertTrue(v['stored'] and v['aligned4'])
        with zipfile.ZipFile(p) as z:
            self.assertEqual(z.read('resources.arsc'),B['resource_table']())
            self.assertEqual(z.read('res/drawable-nodpi/bt192_switch.png'),(SRC/'res/drawable-nodpi/bt192_switch.png').read_bytes())
    def test_compressed_rejected(self):
        p=self.root/'compressed.apk'
        with zipfile.ZipFile(p,'x',compression=zipfile.ZIP_DEFLATED) as z:z.writestr('resources.arsc',B['resource_table']())
        with self.assertRaisesRegex(AssertionError,'ZIP_STORED'):check(p)
    def test_stored_but_unaligned_rejected(self):
        p=self.root/'unaligned.apk'
        with zipfile.ZipFile(p,'x') as z:
            z.writestr('prefix',b'x');z.writestr('resources.arsc',B['resource_table'](),compress_type=zipfile.ZIP_STORED)
        with self.assertRaisesRegex(AssertionError,'4-byte aligned'):check(p)
    def test_duplicate_entry_rejected(self):
        p=self.root/'duplicate.apk'
        with warnings.catch_warnings():
            warnings.simplefilter('ignore',UserWarning)
            with zipfile.ZipFile(p,'x') as z:
                z.writestr('resources.arsc',B['resource_table']());z.writestr('resources.arsc',B['resource_table']())
        with self.assertRaisesRegex(AssertionError,'Duplicate'):check(p)
    def test_selected_source_hashes(self):
        record=json.loads((SRC/'selection_identity.json').read_text())['sourceSHA256']
        actual={str(p.relative_to(SRC)):hashlib.sha256(p.read_bytes()).hexdigest() for p in SRC.glob('smali/**/*.smali')}
        self.assertEqual(len(actual),41);self.assertEqual(record,actual)
    def test_table_header(self):
        b=B['resource_table']();kind,header,size,packages=struct.unpack_from('<HHII',b)
        self.assertEqual((kind,header,size,packages),(2,12,len(b),1))
    def test_prepared_icon_square_rgba(self):
        b=(SRC/'res/drawable-nodpi/bt192_switch.png').read_bytes();self.assertEqual(b[:8],b'\x89PNG\r\n\x1a\n')
        w,h,depth,color=struct.unpack_from('>IIBB',b,16);self.assertEqual(w,h);self.assertEqual((depth,color),(8,6))

if __name__=='__main__':unittest.main()
