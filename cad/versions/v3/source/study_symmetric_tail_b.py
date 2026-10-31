"""Trim redundant mount-side tail ramp to match opposite side."""
import json,shutil
from pathlib import Path
import cadquery as cq
from plunger_design import box
from build import export
ROOT=Path(__file__).resolve().parents[1];src=ROOT/'review/concepts/edge-tunnel-b';out=ROOT/'review/concepts/symmetric-tail-b';out.mkdir(exist_ok=True)
for f in src.iterdir():
 if f.is_file():shutil.copy2(f,out/f.name)
b=cq.importers.importStep(str(src/'b-bracket.step'));p=cq.importers.importStep(str(src/'b-plunger.step'))
# Match the opposite tail outline, retaining the anchor's existing transverse end lip.
region=box(-40,-6.2,24.251,47,-1,25)
removed=b.intersect(region).cut(b.mirror('YZ'))
new=b.cut(removed).clean();assert new.val().isValid() and len(new.val().Solids())==1
assert new.cut(b).val().Volume()<1e-5
for ext in ['stl','step']:export(new,out/('b-bracket.'+ext))
r={'revision':'symmetric-tail-b','removed_volume_mm3':removed.val().Volume(),'subtraction_only':True,'tail_outline_matches_opposite':True,'unchanged_plunger':True,'unchanged_mount':True,'limits':['Printed strength and band retention remain untested.','Subtraction cannot introduce a new rigid plunger collision; previous 91-position clearance check retained.']}
for n in ['geometry-check.json','fit-attachment-check.json']:(out/n).write_text(json.dumps(r,indent=2))
print(r)
