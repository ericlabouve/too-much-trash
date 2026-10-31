"""Measure reinforced bracket geometry, not strength or print qualification."""
import json
from pathlib import Path
from plunger_design import cassette,box,MOUNT_Y,BACK_Y

b=cassette()['actuator_bracket']
sections={}
for z in (16.8,16.9,16.99):
    slab=b.intersect(box(32,38,-10,10,z,z+.005))
    sections[str(z)]=sum(s.Volume() for s in slab.vals())/.005
assert b.val().isValid() and len(b.val().Solids())==1
assert min(sections.values())>60,sections
assert abs(b.val().BoundingBox().ymax-BACK_Y)<1e-5
back_faces=[f for f in b.val().Faces() if f.geomType()=='PLANE' and abs(f.Center().y-BACK_Y)<1e-5 and f.normalAt().y>.99]
assert sum(f.Area() for f in back_faces)>500
previous_volume=7839.15
report={'revision':'post-print-open-pulley-v3','geometry_passed':True,
        'neck_section':{'method':'Volume / 0.005 mm slice thickness within local X32..38, Y-10..10, below mounting plate',
                        'old_mm2':17.4,'new_sections_mm2':sections,'minimum_area_ratio':min(sections.values())/17.4},
        'haunch':{'spine_extent_x_mm':[32.2,64],'root_y_mm':[-6.2,5.4],'base_z_mm':12.5,'top_z_mm':20.5,'plan_corner_radius_mm':1.2,'edge_radius_mm':.6,'nut_turning_radius_mm':9,'nut_relief_radius_mm':9.3,'end_blend':'Cubic easing in width and height; horizontal endpoint tangents; height eases X46..64 from Z20.5 to Z16.65, buried into rounded spine'},
        'flat_back':{'plane_y_mm':BACK_Y,'mount_center_y_mm':MOUNT_Y,'mount_hole_diameter_mm':8.8,'bore_to_back_ligament_mm':BACK_Y-(MOUNT_Y+4.4),'locating_lugs':False,'planar_bed_contact_area_mm2':sum(f.Area() for f in back_faces),'orientation':'-90 degrees about local X; +Y back down','support_free_verified':False},
        'volume':{'previous_mm3':previous_volume,'current_mm3':b.val().Volume(),'increase_percent':100*(b.val().Volume()/previous_volume-1)},
        'unchanged':['120 mm cap rail','single-fastener mount position','plunger position','phone dimensions and positions','open-frame layout','V1 and V2'],
        'limitations':['Section-area ratio is NOT a strength or stiffness multiplier. No load, fatigue, layer adhesion or print test.',
                      'Fillets, nut relief and spine overlap are geometric refinements only; fresh slice and physical load review required.',
                      'See service-access and plunger-integration reports for sampled clearance; known near-side inward cord interference and 14 mm pocket conflicts remain.']}
(Path(__file__).resolve().parents[1]/'review/mount-reinforcement.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2),flush=True)
