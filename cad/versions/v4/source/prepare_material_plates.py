"""Export official V4 parts and prepare separate PETG/TPU support-audit plates.

Run with an unused ignored output directory. No printer communication.
"""
from pathlib import Path
import sys,json,math,hashlib
import cadquery as cq
import trimesh
from build_compact_mount_concept import geometry_compact
from build_preview import clamp_geometry
from shared_key_design import snap_key
import model,build
CAD=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(CAD))
from workspace.release import footprint
from shapely import affinity
from shapely.geometry import box as rect

def export_parts(out):
    source=out/'source';source.mkdir(parents=True)
    p=build.SAMPLES['bare'];s=model.parts(p)
    cap,jaw,cp,jp=clamp_geometry(p);br,pl,_,_=geometry_compact()
    parts={'shaft_cap':(cap,'Y',90,1,'PETG'),'carrier':(jaw,'Y',90,1,'PETG'),
      'sliding_jaw':(s['sliding_jaw'],'Y',-90,1,'PETG'),
      'actuator_bracket':(br,'Z',0,1,'PETG'),'plunger':(pl,'Z',0,1,'PETG'),
      'pulley':(s['pulley'],'X',90,1,'PETG'),'pulley_axle':(s['pulley_axle'],'X',90,1,'PETG'),
      'cap_liner':(cp,'Y',-90,1,'TPU'),'jaw_liner':(jp,'Y',90,1,'TPU'),
      'phone_cuff':(s['phone_cuff'],'Y',-90,3,'TPU'),
      'collar_screw':(s['collar_screw'],'X',180,5,'TPU'),
      'thumb_nut':(s['thumb_nut'],'Z',0,5,'TPU'),
      'pulley_key':(snap_key(),'Z',0,2,'TPU')}
    result={}
    for n,(shape,axis,angle,qty,material) in parts.items():
      assert shape.val().isValid() and len(shape.val().Solids())==1,n
      v={'X':(1,0,0),'Y':(0,1,0),'Z':(0,0,1)}[axis]
      shape=shape.rotate((0,0,0),v,angle);bb=shape.val().BoundingBox()
      shape=shape.translate((-(bb.xmin+bb.xmax)/2,-(bb.ymin+bb.ymax)/2,-bb.zmin))
      path=source/(n+'.stl');build.export(shape,path,manufacturing=True)
      mesh=trimesh.load_mesh(path);mesh.apply_translation([0,0,-mesh.bounds[0,2]]);mesh.export(path)
      assert mesh.is_watertight and mesh.volume>0,n
      result[n]={'quantity':qty,'material':material,'size_mm':mesh.extents.tolist(),'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
      print(n,qty,mesh.extents,flush=True)
    report={'revision':'v4-compact-centered-full-materials','parts':result,'printed_pieces':sum(r['quantity'] for r in result.values()),'printer_contacted':False}
    (source/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
    return source,result

def arrange(source,parts,material):
    # Full projected footprints include every overhang. Maintain 3 mm separation.
    shapes={n:footprint(trimesh.load_mesh(source/(n+'.stl'))) for n,r in parts.items() if r['material']==material}
    instances=[(n if parts[n]['quantity']==1 else n+'_'+str(i),n) for n in shapes for i in range(1,parts[n]['quantity']+1)]
    instances.sort(key=lambda p:shapes[p[1]].area,reverse=True)
    placed=[];layout={};bed=rect(4,4,176,176)
    for key,n in instances:
      best=None
      for angle in (0,90):
        sh=affinity.rotate(shapes[n],angle,origin=(0,0));x0,y0,x1,y1=sh.bounds
        for y in range(math.ceil(4-y0),math.floor(176-y1)+1,3):
          for x in range(math.ceil(4-x0),math.floor(176-x1)+1,3):
            candidate=affinity.translate(sh,xoff=x,yoff=y)
            if candidate.intersects(rect(155.7,151.7,180,180)):continue
            if any(candidate.distance(other)<3 for other in placed):continue
            score=(y+y1)*180+x+x1
            if best is None or score<best[0]:best=(score,x,y,angle,candidate)
      if best is None:raise ValueError('Cannot pack '+key+' on one '+material+' plate')
      _,x,y,a,sh=best;placed.append(sh);layout[key]=((x,y),'Z',a,'Approved bed face preserved; full projected footprints separated by >=3 mm')
      if key!=n:(source/(key+'.stl')).write_bytes((source/(n+'.stl')).read_bytes())
      print('placed',key,x,y,a,flush=True)
    return layout

def slice_plate(out,source,layout,material):
    import prepare_cuff_fit_plate as plate
    import review_actuator_plate as review
    plate.ROOT=CAD;plate.SOURCE=source;plate.PARTS=layout
    plate.PRIOR=CAD/('versions/v3/print/jobs/2026-10-26-compact-petg' if material=='PETG' else 'versions/v3/print/jobs/2026-10-24-three-cuffs-thread-tpu')
    sys.argv=['slice','--output-dir',str(out)]
    if out.exists(): sys.argv.append('--resume-unsliced')
    if not (out/'cuff-fit.gcode.3mf').exists(): plate.main(process_overrides={'bridge_no_support':'0','enable_support':'1'},material_status=material+' offline recipe; printer not contacted')
    inputs=json.loads((out/'inputs.json').read_text());inputs['nested_layout']=True
    inputs['scope']='Selected V4 '+material+' components: '+', '.join(layout)+'; offline support audit.'
    (out/'inputs.json').write_text(json.dumps(inputs,indent=2)+'\n')
    review.OUT=out
    review.main(project_stem='cuff-fit',title='V4 '+material+' plate',detail_parts=list(layout),notes=['Automatic supports ON; bridge suppression OFF.','Current V4 geometry; no print sent.','Full projected footprints separated by at least 3 mm; inspect actual paths.'])
    r=json.loads((out/'review.json').read_text())
    supports={n:{k:v for k,v in o['deposited_g_by_role'].items() if k in ('support','interface') and v} for n,o in r['objects'].items()}
    print('SUPPORT AUDIT',material,json.dumps(supports),flush=True)

if __name__=='__main__':
    out=Path(sys.argv[1]).resolve()
    if '--resume' in sys.argv:
      source=out/'source';parts=json.loads((source/'fit-attachment-check.json').read_text())['parts']
    else:
      out.mkdir(parents=True,exist_ok=False)
      source,parts=export_parts(out)
    for material in ('PETG','TPU'):
      layout=arrange(source,parts,material)
      (out/(material+'-layout.json')).write_text(json.dumps(layout,indent=2)+'\n')
      slice_plate(out/material.lower(),source,layout,material)
