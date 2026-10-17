"""Isolated single-fastener study; never overwrites active CAD or print exports."""
import json, math
from pathlib import Path
from build import overlap, export
import model as m

OUT=Path(__file__).resolve().parents[1]/'review/concepts/single-fastener'

def candidate(solids):
    if len([n for n in m.assembly_parts(m.Parameters(),solids) if n.startswith('rail_screw_')])!=2:
        raise RuntimeError('Historical study requires the pre-promotion two-fastener V3. Use check_compact_mount.py for the active design; do not overwrite historical study reports.')
    # Replace only the existing mounting bar; retain the frame and working parts.
    bracket=solids['actuator_bracket'].cut(m.box(31.9,38.1,-18.1,18.1,17,36))
    plate=m.box(32,38,-10,10,17,35).edges('|X').fillet(1.2)
    key=m.box(28,32.2,-8,8,21.9,30.1).edges('|X').fillet(1.2)
    bracket=bracket.union(plate).union(key)
    bracket=bracket.cut(m.cylinder((27,0,26),(1,0,0),12,8.8))
    # Extra relief permits key withdrawal before the module moves down.
    bracket=bracket.cut(m.box(21.5,32.2,2.2,5.6,15.8,17.1))
    # Keep the full turning envelope of the central nut off the support web.
    bracket=bracket.cut(m.box(38,49,2.2,5.6,17.1,18.1))
    return bracket

def key_shape():
    key=m.box(28,32.2,-8,8,21.9,30.1).edges('|X').fillet(1.2)
    return key.cut(m.cylinder((27,0,26),(1,0,0),12,8.8))

def assembly(p,solids,bracket):
    a=m.assembly_parts(p,solids)
    for n in list(a):
        if n.startswith(('rail_screw_','rail_nut_')):del a[n]
    a['actuator_bracket']=m.placed(bracket,p)
    a['rail_screw']=m.placed(solids['thumb_screw'].rotate((0,0,0),(0,1,0),-90).translate((46,0,26)),p)
    a['rail_nut']=m.placed(solids['thumb_nut'].rotate((0,0,0),(0,1,0),-90).translate((44,0,26)),p)
    return a

def main():
    solids=m.parts(m.Parameters());bracket=candidate(solids)
    assert bracket.val().isValid() and len(bracket.val().Solids())==1
    OUT.mkdir(parents=True,exist_ok=True)
    export(bracket,OUT/'bracket.stl');export(bracket,OUT/'bracket.step')
    report={'study_only':True,'active_v3_unchanged':True,'key_mm':{'length_y':16,'width_z':8.2,'engagement_x':4,'slot_width':8.8},'bracket_volume_mm3':bracket.val().Volume(),'positions':{}}
    moving=['actuator_bracket','plunger','pulley','pulley_axle','pulley_key','rail_screw','rail_nut']
    # All seven moving objects share one rigid translation in this sweep.
    # Their pairwise intersections are invariant; calculate them only once.
    reference=assembly(m.Parameters(),solids,bracket);internal={}
    for i,n in enumerate(moving):
        for other in moving[i+1:]:
            v=overlap(reference[n],reference[other])
            if v>.01:internal[n+'/'+other]=round(v,4)
    for sign in (1,-1):
        for center in (29,28,26,25.75,25.5,25,24,23,22,20,18.5):
            p=m.Parameters(phone_thickness=8,button_from_end=76+center,side='near' if sign==1 else 'far')
            a=assembly(p,solids,bracket);hits=dict(internal)
            for n in moving:
                for other in a:
                    if other in moving:continue
                    v=overlap(a[n],a[other])
                    if v>.01:hits[n+'/'+other]=round(v,4)
            report['positions'][str(sign*center)]={'rigid_collisions_mm3':hits,'clear':not hits}
            print(sign*center,hits,flush=True)
    report['unclamped_rotation']={}
    key=key_shape().translate((-20,29,0))
    for angle in (.5,1,1.5,2,2.5,3,4):
        values=[]
        for sign in (-1,1):
            v=overlap(key.rotate((12,29,26),(13,29,26),sign*angle),solids['shaft_cap'])
            values.append(round(v,5))
        report['unclamped_rotation'][str(angle)]={'key_rail_overlap_mm3':values,'contact_pad_center_lateral_shift_mm':round(18*math.sin(math.radians(angle)),3)}
    report['service_at_26_mm']={}
    module=['actuator_bracket','plunger','pulley','pulley_axle','pulley_key']
    for side in ('near','far'):
        p=m.Parameters(phone_thickness=8,button_from_end=102,side=side)
        a=assembly(p,solids,bracket);fixed={n:s for n,s in a.items() if n not in module+['rail_screw','rail_nut']};hits=[]
        for dx in range(0,21,2):
            nut=m.cylinder((18+dx,p.button_y,26),(1,0,0),6,18)
            for n in module:
                v=overlap(nut,a[n])
                if v>.01:hits.append(['nut',dx,n,round(v,4)])
        for dx in range(0,35,2):
            screw=a['rail_screw'].translate((-dx,0,0))
            for n,s in {**fixed,**{n:a[n] for n in module}}.items():
                v=overlap(screw,s)
                if v>.01:hits.append(['screw',dx,n,round(v,4)])
        moves=[(i/2,0) for i in range(10)]+[(4.5,-i/5) for i in range(1,11)]+[(4.5+i,-2) for i in range(1,41)]
        for dx,dz in moves:
            for n in module:
                part=a[n].translate((dx,0,dz))
                for other,s in fixed.items():
                    v=overlap(part,s)
                    if v>.01:hits.append(['module',dx,dz,n,other,round(v,4)])
        report['service_at_26_mm'][side]={'collisions':hits,'clear':not hits}
        print('service',side,hits[:5],len(hits),flush=True)
    report['limits']=['Rigid CAD study only. No print, force, wear or stiffness qualification.',
        'Loose-key rotation is not tightened-mount play: screw preload is required. No zero-wiggle claim.',
        'Phone removed during service. Coarse sampled paths, not continuous collision proof.',
        'Full cord/band sweep and all phone configurations are not requalified for this candidate.',
        'Active V3 remains the two-fastener flush-T assembly.']
    report['service_sequence']=['Remove phone and release twine tension.',
        'Remove the nut toward +X, then withdraw the screw toward -X.',
        'Pull the complete module outward 4.5 mm to disengage the locating lugs.',
        'Lower 2 mm, then continue outward. Reverse for assembly.']
    report['assessment']={'current_two_screw_nominal_inward_center_mm':28,
        'candidate_conservative_evaluated_center_mm':26,'inward_gain_mm':2,
        'rail_length_unchanged_mm':120,'hypothetical_printed_piece_count':21,
        'main_reach_limit':'Axle head/end colliding with cap or carrier, not the second screw.',
        'loose_key_result':'At the sampled 2.5 degrees both signs remain clear; at 3 degrees both signs intersect the slot wall. This is isolated-key motion, not measured tightened play.',
        'recommendation':'Do not promote for reach alone. Investigate axle/collar clearance before further inward travel; qualify clamping/printed fit before replacing two fasteners.'}
    (OUT/'study.json').write_text(json.dumps(report,indent=2)+'\n')

if __name__=='__main__':main()
