"""Recessed axle/key study; active V3 and historical exports stay untouched."""
import json, math
from pathlib import Path
from itertools import combinations
from build import overlap, export
import model as m
from plunger_design import box, cyl, local_shape, local_point, tube
import study_single_mount as single

OUT=Path(__file__).resolve().parents[1]/'review/concepts/compact-axle'

def design(solids):
    bracket=single.candidate(solids)
    # Recessed head: 2 mm front bearing land (w11..13), 1.6 mm head.
    front=cyl(13.5,8,11,4,8).edges().fillet(.2)
    # Reinforce the rear key pocket; avoid the slider's u<=4 envelope.
    pad=box(4.4,24.5,2,14,2.6,4.2).edges('|Z').fillet(.4)
    bracket=bracket.union(local_shape(front)).union(local_shape(pad))
    bracket=bracket.cut(local_shape(cyl(13.5,8,-4,20,4.3)))
    bracket=bracket.cut(local_shape(cyl(13.5,8,13,3,5.8)))
    bracket=bracket.cut(local_shape(box(4.4,27,2.4,13.6,-2.1,2.2)))
    axle=cyl(13.5,8,-3.6,16.8,4).union(cyl(13.5,8,13.2,1.6,5.5).edges().fillet(.2))
    axle=axle.cut(box(3,23,6.3,9.7,-1.4,2.0))
    # Shorter key keeps its grip tab outside the plunger's swept envelope.
    # Handle on +u end so withdrawal moves it away from, not through, the axle.
    key=box(7,19,6.5,9.5,-1.2,1.8).edges().fillet(.2)
    key=key.union(box(18,21,4.5,11.5,-1.8,2.0).edges().fillet(.35))
    key=key.cut(box(8,9,6.4,7.1,-1.3,1.9)).cut(box(8,9,8.9,9.6,-1.3,1.9))
    return {**solids,'actuator_bracket':bracket,'pulley_axle':local_shape(axle),'pulley_key':local_shape(key)}

def keeper_path():
    pts=[(17.2,3.7),(17.2,12.3),(21.8,3.7),(21.8,12.3),(6.2,5.7),(6.2,10.3)]
    pts += [(13.5+4.8*math.cos(i*math.pi/32),8+4.8*math.sin(i*math.pi/32)) for i in range(64)]
    pts=sorted(set(pts));hull=[]
    def cross(a,b,c):return (b[0]-a[0])*(c[1]-a[1])-(b[1]-a[1])*(c[0]-a[0])
    for seq in (pts,pts[::-1]):
        half=[]
        for q in seq:
            while len(half)>1 and cross(half[-2],half[-1],q)<=0:half.pop()
            half.append(q)
        hull.extend(half[:-1])
    return [local_point((u,v,.3)) for u,v in hull+[hull[0]]]

def export_review_assembly(s):
    """Context STEP, not a print plate; cap and single-screw cassette at Y24."""
    p=m.Parameters(phone_thickness=8,button_from_end=100)
    a=single.assembly(p,s,s['actuator_bracket'])
    scene=m.cq.Assembly(name='compact_axle_study_not_active_v3')
    for n in ('shaft_cap','actuator_bracket','plunger','pulley','pulley_axle','pulley_key','rail_screw','rail_nut'):
        scene.add(a[n],name=n,color=m.cq.Color(.96,.36,.08))
    scene.add(m.placed(tube(keeper_path(),.6),p),name='schematic_keeper_band',color=m.cq.Color(.57,.29,.68))
    scene.export(str(OUT/'assembly.step'))

def main():
    original=m.parts(m.Parameters());s=design(original);OUT.mkdir(parents=True,exist_ok=True)
    report={'study_only':True,'active_v3_unchanged':True,'solids':{},'positions':{}}
    for n in ('actuator_bracket','pulley_axle','pulley_key'):
        shape=s[n];report['solids'][n]={'valid':shape.val().isValid(),'solid_count':len(shape.val().Solids()),'volume_mm3':round(shape.val().Volume(),3)}
        assert shape.val().isValid() and len(shape.val().Solids())==1,(n,report['solids'][n])
        export(shape,OUT/(n+'.stl'));export(shape,OUT/(n+'.step'))
    export_review_assembly(s)
    moving=['actuator_bracket','plunger','pulley','pulley_axle','pulley_key','rail_screw','rail_nut']
    ref=single.assembly(m.Parameters(),s,s['actuator_bracket']);internal={}
    for a,b in combinations(moving,2):
        v=overlap(ref[a],ref[b])
        if v>.01:internal[a+'/'+b]=round(v,4)
    report['internal_collisions_mm3']=internal;print('internal',internal,flush=True)
    for side in ('near','far'):
        for center in (26,24.5,24,23.75,23.5,23):
            p=m.Parameters(phone_thickness=8,button_from_end=76+center,side=side)
            a=single.assembly(p,s,s['actuator_bracket']);hits=dict(internal)
            for n in moving:
                for other,shape in a.items():
                    if other in moving:continue
                    v=overlap(a[n],shape)
                    if v>.01:hits[n+'/'+other]=round(v,4)
            report['positions'][f'{side}-{center}']={'collisions_mm3':hits,'clear':not hits}
            print(side,center,hits,flush=True)
    report['stroke']={}
    for d in (0,.325,.65):
        report['stroke'][str(d)]={n:round(overlap(s['plunger'].translate((-d,0,0)),s[n]),5) for n in ('actuator_bracket','pulley','pulley_axle','pulley_key')}
    band=tube(keeper_path(),.6)
    report['keeper_envelope_overlap_mm3']={n:round(overlap(band,s[n]),5) for n in ('actuator_bracket','plunger','pulley','pulley_axle','pulley_key')}
    report['retention']={'head_block_mm3':round(overlap(s['pulley_axle'].translate((0,1,0)),s['actuator_bracket']),5),'key_block_mm3':round(overlap(s['pulley_key'].translate((0,-1,0)),s['actuator_bracket']),5),'shaft_tip_ligament_mm':2.2,'head_thickness_mm':1.6,'front_bearing_length_mm':2,'rear_bearing_length_mm':4,'wheel_axial_clearance_mm':.8,'old_axle_span_mm':23,'new_axle_span_mm':18.4,'new_fork_outer_w_mm':15}
    hits=[]
    for du in range(23):
        key=s['pulley_key'].translate((0,0,-du))
        for n in ('actuator_bracket','pulley_axle','pulley','plunger'):
            v=overlap(key,s[n])
            if v>.01:hits.append(['key',du,n,round(v,5)])
    for dw in range(23):
        axle=s['pulley_axle'].translate((0,-dw,0))
        for n in ('actuator_bracket','pulley','plunger'):
            v=overlap(axle,s[n])
            if v>.01:hits.append(['axle',dw,n,round(v,5)])
    report['off_tool_removal_collisions']=hits
    report['limits']=['Not promoted or print-ready. Head/key strength and bearing wear untested.','Keeper band is schematic; real loop installation, grip, stretch and knot/cord interactions require review.','Single-fastener clamp preload and play remain unqualified.','Full module service at new inward positions and all-phone fit not yet requalified.','Recorded 14 mm pocket conflict and button-force/overtravel risks remain.']
    (OUT/'study.json').write_text(json.dumps(report,indent=2)+'\n')
    print('retention',report['retention'],'keeper',report['keeper_envelope_overlap_mm3'],'removal',hits[:5],flush=True)

if __name__=='__main__':main()
