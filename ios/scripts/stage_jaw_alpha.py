"""Stage only the hash-verified alpha runtime and weights; never fixtures/media."""
import argparse,importlib.util,shutil
from pathlib import Path
root=Path(__file__).resolve().parents[2]
p=argparse.ArgumentParser();p.add_argument('package',type=Path);args=p.parse_args()
spec=importlib.util.spec_from_file_location('alpha_export',root/'ml/experiments/jaw-trigger/alpha/export.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
m.verify_package(args.package)
dest=root/'ios/AlphaPrivate/runtime';dest.mkdir(parents=True,exist_ok=True)
for name in ['visual-component.json','baseline-model.json','exact-parent-model.json']:
 shutil.copy2(args.package/'runtime'/name,dest/name)
print('Staged three verified R59 models; no fixtures or binaries.')
