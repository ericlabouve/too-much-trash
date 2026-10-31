"""Isolated A1 review geometry; millimetres, +Y retracts, +Z faces cover."""
from pathlib import Path
import json, math
import cadquery as cq
import trimesh

OUT=Path(__file__).resolve().parent
def box(x0,x1,y0,y1,z0,z1):
    return cq.Workplane('XY').box(x1-x0,y1-y0,z1-z0).translate(((x0+x1)/2,(y0+y1)/2,(z0+z1)/2))
def cyl(x,y,z,h,r):
    return cq.Workplane('XY').circle(r).extrude(h).translate((x,y,z))
def compound(shapes):
    return cq.Workplane('XY').newObject([cq.Compound.makeCompound([s.val() for s in shapes])])
def tube(points,r):
    pieces=[]
    for a,b in zip(points,points[1:]):
        va,vb=cq.Vector(*a),cq.Vector(*b);d=vb.sub(va)
        if d.Length>1e-8:pieces.append(cq.Workplane('XY').newObject([cq.Solid.makeCylinder(r,d.Length,va,d.normalized())]))
    for a in points:pieces.append(cq.Workplane('XY').sphere(r).translate(a))
    return compound(pieces)

# Open spine replaces deep tray and full cover. Pulley moves to button end.
body=box(-9,9,0,66,0,3).union(box(0,19,0,18,0,3)).edges('|Z').fillet(1.2).edges('not |Z').fillet(.35)
body=body.union(box(-8.5,8.5,59,63,2.3,8).edges().fillet(.6))
# Broad front flange traps the return loop between it and the back spine.
band_lip=box(-10.5,10.5,58.5,65,7.6,9.6).edges('|Z').fillet(.8).edges('not |Z').fillet(.35)
body=body.union(band_lip)
body=body.union(cyl(8,8,2.6,15.4,2.5).edges().fillet(.3)).union(cyl(8,8,2.6,6.1,3.4).edges().fillet(.3))
# Retain one guide/stop pair immediately before pulley (wheel ends at Y17).
# Open center lets the raised twine eye pass; shallow lips retain slider edges.
for a,b,c,d in [(-8,-4.3,-5.5,-3.3),(4.3,8,3.3,5.5)]:
    guide=box(a,b,18,25.5,2.6,9.5).union(box(c,d,18,25.5,7.8,9.5)).edges().fillet(.25)
    body=body.union(guide)
# Shared cleat removes the unused separate band yoke.
slider=box(-4,4,10,49,3.4,7.4)
# Rounded rectangular shoe replaces thin-ended trapezoid. Contact width grows
# 4 -> 6 mm; perpendicular Z span stays 16 mm. Four mm depth supports its ends.
# Curved haunches extend below the frame, avoiding its back and the low pulley.
slider=slider.union(box(-3,3,0,10,3.4,7.4))
shoe=box(-3,3,-8,-4,-2.6,13.4).edges('|Y').fillet(1.5)
root=(cq.Workplane('YZ').moveTo(2,3.4).lineTo(2,7.4).lineTo(0,7.4)
      .threePointArc((-2.8,8.8),(-4,11.4)).lineTo(-4,-.6)
      .threePointArc((-2.8,2),(0,3.4)).close().extrude(6).translate((-3,0,0)))
slider=slider.union(root).union(shoe)
slider=slider.edges().fillet(.3)
# Solid wrap cleat near the T: broad root, rounded cap, no through-hole.
cleat_stem=box(-2.5,2.5,44,48,7.1,13.1).edges('|Z').fillet(.7).edges('not |Z').fillet(.25)
cleat_cap=box(-4.5,4.5,42,50,12.8,15.3).edges('|Z').fillet(1).edges('not |Z').fillet(.35)
slider=slider.union(cleat_stem).union(cleat_cap)
# Chamfered pulley, with generous bore clearance: illustrative, unqualified.
pulley=cq.Workplane('XZ').polyline([(2.8,9),(9,9),(9,10),(8,11),(8,15),(9,16),(9,17),(2.8,17)]).close().revolve(360,(0,0),(0,1)).edges().fillet(.25).translate((8,8,0))
def band_path(d):
    # One loop: broad fixed upper anchor, narrow shared moving cleat.
    # Band sits behind the twine wrap under the same cap.
    return [(0,64,5.4),(7.8,64,5.4),(9.214,63.414,5.4),(9.8,62,5.4),(9.8,56,7),
            (3.6,48-d,10.1),(3.6,44.5-d,10.1),(2,43-d,10.1),
            (-2,43-d,10.1),(-3.6,44.5-d,10.1),(-3.6,48-d,10.1),
            (-9.8,56,7),(-9.8,62,5.4),(-9.214,63.414,5.4),(-7.8,64,5.4),(0,64,5.4)]
band=tube(band_path(0),.6)
wrappts=[(0,43.15,11.4),(2,43.15,11.4),(3.35,44.5,11.4),(3.35,47.5,11.4),(2,48.85,11.4),(-2,48.85,11.4),(-3.35,47.5,11.4),(-3.35,44.5,11.4),(-2,43.15,11.4),(0,43.15,11.4)]
wrappts=[(x,y,11.65) for x,y,z in wrappts]
cordpts=wrappts+[(0,41.4,11.4),(0,8,13)]
for i in range(1,25):
    t=math.pi+math.pi/2*i/24;cordpts.append((8+8*math.cos(t),8+8*math.sin(t),13))
cordpts.append((36,0,13));cord=tube(cordpts,.65)
tie=tube([(0,41.4,11.4),(1.2,40.7,11.4),(0,40,12.1),(-1.2,40.7,11.4),(0,41.4,11.4),(-2.8,39.5,11.4)],.65)
cord=compound([cord,tie])
# Phone proxy translates 2 mm with the new face; its dimensions are unchanged.
phone=box(-23,23,-15,-9.35,-1,15)
button=box(-3,3,-9.35,-8.35,3.4,7.4)
solids={'body':body,'plunger':slider,'pulley':pulley}
visuals={**solids,'return_band':band,'twine':cord,'phone_reference':phone,'button_reference':button}
colors={'body':(.92,.30,.045),'plunger':(1,.57,.16),'pulley':(1,.43,.065),'cover':(.96,.36,.08),'return_band':(.08,.64,.48),'twine':(.43,.23,.67),'phone_reference':(.30,.36,.42),'button_reference':(.62,.69,.73)}
report={'status':'retained-band wrap-cleat rounded-shoe review prototype','units':'mm','provisional_body_envelope_mm':[29.5,66,18],'nominal_demo_stroke_mm':.65,'nominal_demo_gap_mm':.35,'free_clearance_checked_mm':18,'shoe_face_mm':{'X':6,'Z':16,'corner_radius':1.5,'axial_depth':4},'root_comparison':{'previous_nominal_area_mm2':16,'new_nominal_area_mm2':24,'area_increase_percent':50,'interpretation':'Geometric root-section comparison, not a strength or fatigue prediction. Curved supports replace abrupt narrowed junction.'},'contact_plane_shift_mm':-2,'phone_proxy_change':'Rigid translation only; unchanged dimensions','body_volume_reduction_percent':100*(1-body.val().Volume()/20147.303772634506),'checks':{},'intersections':[],'flexible_clearance':[],'full_harness_fit_checked':False,'unresolved':['Pulley axial retention without cover','Full harness mounting','Safe button travel after removal of lower stops','Actual knot and band dimensions/retention','Print orientation and strength','Wider shoe adjacent-button/case clearance'],'neck_compliance':'Two twine lengths joined by a rubber band along neck; separate from return band.'}
for name,s in solids.items():
    report['checks'][name]={'valid':s.val().isValid(),'solids':s.solids().size(),'volume_mm3':s.val().Volume()}
    assert s.val().isValid() and s.solids().size()==1,name
from OCP.BRepTools import BRepTools
for name,s in visuals.items():
    BRepTools.Clean_s(s.val().wrapped)
    s.val().exportStl(str(OUT/(name+'.stl')),tolerance=.003 if name in solids else .04,angularTolerance=.08 if name in solids else .18,relative=False)
for i in range(73):
    d=18*i/72;m=slider.translate((0,-d,0))
    for name,s in [('body',body),('pulley',pulley)]:
        v=sum(x.Volume() for x in m.intersect(s).solids().vals())
        if v>1e-5:report['intersections'].append({'stroke':d,'part':name,'mm3':v})
for a,b in [('body','pulley')]:
    v=sum(x.Volume() for x in solids[a].intersect(solids[b]).solids().vals())
    if v>1e-5:report['intersections'].append({'parts':[a,b],'mm3':v})
# Check the illustrated wrap and standing string against fixed obstacles at
# representative positions. Real knots remain unspecified, not validated.
for d in (0,9,18):
    loop=tube([(x,y-d,z) for x,y,z in wrappts],.65)
    v=sum(x.Volume() for x in loop.intersect(body).solids().vals())
    report['flexible_clearance'].append({'stroke':d,'illustrative_wrap_body_overlap_mm3':v})
    assert v<1e-5, 'Illustrated wrap hits body'
    modeled_band=tube(band_path(d),.6)
    for name,target in [('body',body),('plunger',slider.translate((0,-d,0))),('pulley',pulley)]:
        bv=sum(s.Volume() for s in modeled_band.intersect(target).solids().vals())
        report['flexible_clearance'][-1]['shared_band_'+name+'_overlap_mm3']=bv
        assert bv<1e-5, ('Shared band collision',d,name,bv)
report['revision']='shared-cleat-softened-edges'
report['edge_radii_mm']={'frame_outline':1.2,'frame_rim':.35,'guides':.25,'plunger_edges':.3,'pulley_edges':.25,'cleat_cap_rim':.35}
report['return_attachment']='Same capped cleat as string; band behind twine, old band yoke removed. Flexible sizes remain illustrative.'
assy=cq.Assembly(name='A1_band_return_review')
scene=trimesh.Scene();manifest=[]
for name,s in visuals.items():
    assy.add(s,name=name,color=cq.Color(*colors[name]))
    mesh=trimesh.load(OUT/(name+'.stl'),force='mesh')
    if name in solids:
        # OCCT fillet tessellation can include collapsed corner triangles.
        # Remove only duplicate/degenerate faces, without filling holes or
        # moving vertices; STEP and CAD geometry remain untouched.
        before=len(mesh.faces)
        mesh.update_faces(mesh.unique_faces())
        mesh.update_faces(mesh.nondegenerate_faces())
        mesh.remove_unreferenced_vertices()
        report['checks'][name]['removed_degenerate_or_duplicate_faces']=before-len(mesh.faces)
        mesh.export(OUT/(name+'.stl'))
    mesh.visual.vertex_colors=[*[int(c*255) for c in colors[name]],255]
    scene.add_geometry(mesh,node_name=name,geom_name=name)
    if name in solids:
        report['checks'][name]['watertight']=bool(mesh.is_watertight)
        assert mesh.is_watertight,name
    manifest.append({'name':name,'file':name+'.stl','color':colors[name]})
assy.export(str(OUT/'a1-band-return.step'))
scene.export(str(OUT/'a1-band-return.glb'))
(OUT/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
(OUT/'band-path.json').write_text(json.dumps({'points':band_path(0),'moving_indices':[5,6,7,8,9,10]},indent=2)+'\n')
(OUT/'review.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))
assert not report['intersections'], 'Rigid interference in stroke'
