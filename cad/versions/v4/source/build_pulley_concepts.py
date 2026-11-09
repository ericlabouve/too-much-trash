"""Three isolated V4 pulley lip concepts; no promotion or print authorization."""
import sys,json
from pathlib import Path
import cadquery as cq
sys.path.insert(0,str(Path(__file__).resolve().parents[2]/'v3/source'))
from model import box

def build(out):
 out.mkdir(parents=True,exist_ok=True)
 # Canonical wheel axis Z. Side z=0 faces the proposed cap guide.
 tail=[(6.8,1.8),(6.8,2.2),(9,3.8),(9,4),(4.3,4)]
 profiles={
  'original':[(4.3,0),(9,0),(9,.2)]+tail,
  'a':[(4.3,0),(10.5,0),(10.5,.3),(9,.7)]+tail,
  'b':[(4.3,0),(10,0),(10,1.0),(9.5,1.5),(8.3,1.5),(8.3,1.1),(9,.5)]+tail,
  'c':[(4.3,0),(10,0),(10,.8),(9.8,1.15),(9.4,1.4),(8.9,1.4),(8.55,1.15),(8.5,.8),(9,.4)]+tail,
 }
 original=cq.Workplane('XZ').polyline(profiles['original']).close().revolve(360,(0,0),(0,1))
 report={}
 for name,pts in profiles.items():
  wheel=cq.Workplane('XZ').polyline(pts).close().revolve(360,(0,0),(0,1))
  if name == 'c':
   wheel=(cq.Workplane('XZ').moveTo(4.3,0).lineTo(10,0).lineTo(10,.7)
    .threePointArc((9.3,1.4),(8.6,.7)).lineTo(9,.4)
    .polyline(tail,includeCurrent=True).close().revolve(360,(0,0),(0,1)))
  assert wheel.val().isValid() and len(wheel.solids().vals())==1
  report[name]={'volume_mm3':wheel.val().Volume(),'diameter_mm':wheel.val().BoundingBox().xlen,'axial_width_mm':wheel.val().BoundingBox().zlen,'bore_mm':8.6}
  variants=[('',wheel),('-section',wheel.intersect(box(-20,20,0,20,-2,8)))]
  if name!='original':
   addition=wheel.cut(original)
   variants.extend([('-addition',addition),('-section-addition',addition.intersect(box(-20,20,0,20,-2,8)))])
  for suffix,s in variants:
   # Bare near-side actuator: groove center (6.45,21.75,-2.475...).
   s=s.rotate((0,0,0),(1,0,0),90).translate((6.45,23.75,-2.4750919068))
   cq.exporters.export(s,str(out/(name+suffix+'.stl')))
 report['limits']=['Concept geometry only, not sliced or fit tested.','One-sided lip faces nominal positive-Y guide; assess reversed installation for opposite-side actuator.','Larger rim must clear handle, axle hardware and full insertion/motion before promotion.']
 (out/'geometry.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':build(Path(sys.argv[1]))
