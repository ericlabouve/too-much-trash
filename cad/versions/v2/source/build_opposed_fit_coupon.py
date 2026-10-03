"""Export an exact lower 20 mm section of the active r10 collar pair.
Only coupon outputs are written; never modifies the full manufacturing exports.
"""
from pathlib import Path
import hashlib,json,argparse
import cadquery as cq
import trimesh
import model as m
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'print/fit-coupons/neck-r11-opposed-20mm'

def main():
 global OUT
 parser=argparse.ArgumentParser()
 parser.add_argument('--end-face',action='store_true',help='Reprint trial: vertical neck passage, distinct output directory')
 args=parser.parse_args()
 if args.end_face: OUT=ROOT/'print/fit-coupons/neck-r11-opposed-20mm'
 OUT.mkdir(parents=True,exist_ok=True)
 p=m.Parameters();z0,z1=-86,-66
 crop=m.box(-100,100,-100,100,z0,z1)
 pieces={'carrier_fit_section':m.carrier(p).intersect(crop),'shaft_cap_fit_section':m.shaft_cap(p).intersect(crop)}
 report={'revision':'opposed-clamp-r11','purpose':'Short lower collar fit test; not a loaded retention test','source_sha256':hashlib.sha256((ROOT/'source/model.py').read_bytes()).hexdigest(),'source_z_interval_mm':[z0,z1],'nominal_opening_mm':[p.collar_opening_x,p.collar_opening_y],'split_gap_mm':1,'existing_screw_nut_pairs':2,'parts':[]}
 opening=m.box(-5.8,5.8,-8.8,8.8,z0,z1)
 for name,s in pieces.items():
  assert s.val().isValid() and len(s.val().Solids())==1,name
  assert sum(v.Volume() for v in s.intersect(opening).solids().vals())<.001
  # Preserve full parts' layer directions, then put each section on the bed.
  t=s
  bb=t.val().BoundingBox();t=t.translate((-(bb.xmin+bb.xmax)/2,-(bb.ymin+bb.ymax)/2,-bb.zmin))
  file=OUT/(name+'.stl');cq.exporters.export(t,str(file),tolerance=.06,angularTolerance=.12)
  mesh=trimesh.load_mesh(file)
  if abs(mesh.bounds[0,2])>1e-6:
   t=t.translate((0,0,-float(mesh.bounds[0,2])));cq.exporters.export(t,str(file),tolerance=.06,angularTolerance=.12);mesh=trimesh.load_mesh(file)
  cq.exporters.export(t,str(OUT/(name+'.step')))
  assert mesh.is_watertight and mesh.volume>0 and abs(mesh.bounds[0,2])<.001
  report['parts'].append({'name':name,'file':file.name,'quantity':1,'layer_mm':.2,'walls':3,'infill_percent':15,'bounds_mm':mesh.extents.tolist(),'watertight':True,'bed_z_min_mm':float(mesh.bounds[0,2]),'sha256':hashlib.sha256(file.read_bytes()).hexdigest(),'cad_volume_mm3':s.val().Volume()})
 report['print_orientation']='cut end on bed; neck passage vertical'
 report['limitations']=['Two opposed lower fastener stations: tighten alternately in small increments. Do not load a phone on this coupon.','Tests local opening fit at multiple points, not simultaneous fit over the full102 mm or cap removal around the actuator rail.','Upper cap relief and full carrier stiffness/support cleanup are not reproduced.','Nominal accepted opening remains inconsistent with historical stock proxy; actual fit must be checked.']
 (OUT/'manifest.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))

if __name__=='__main__':main()
