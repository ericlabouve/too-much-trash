"""Active single-fastener reach and loose-key audit; no strength qualification."""
import json, math
from pathlib import Path
from build import overlap, check
import model as m
from study_single_mount import key_shape
from plunger_design import tube

s=m.parts(m.Parameters())
report={'revision':'flat-back-mount-v3','positions':{},'loose_key':{},'outgoing_cord_sweep':{},
        'rail_length_mm':120,'nominal_previous_two_screw_inward_center_mm':28,
        'mount_offset_y_mm':m.MOUNT_Y,'isolated_key_rotation_test_center_y_mm':36,
        'limitations':['Not a tightened-play, force, strength, wear or print qualification.',
                      'Reach uses an explicit 8 mm synthetic phone; original phone proxies remain unchanged.',
                      'Locating-key rotation excludes the rest of the assembly and clamp preload.']}
for side in ('near','far'):
    center=29 if side=='near' else 24
    label=side+'-'+str(center)
    p=m.Parameters(phone_thickness=8,button_from_end=76+center,side=side)
    result=check(p,s)
    report['positions'][label]=result
    assert result['mechanical_passed'],(side,result)
    a=m.assembly_parts(p,s);path,bands,_=m.flexible_paths(p)
    envelopes={name:tube(bands[name],.6) for name in ('band_return','band_keeper')}
    # Direct outgoing span after the pulley arc through the downstream guides.
    envelopes.update({f'cord-{i}':m.rod(start,end,2) for i,(start,end) in enumerate(zip(path[33:],path[34:]),33)})
    collisions={}
    for name,envelope in envelopes.items():
        for other,part in a.items():
            v=overlap(envelope,part)
            if v>.01:collisions[name+'/'+other]=v
    report['positions'][label]['routing_collisions_mm3']=collisions
    result['routing_clear']=not collisions
    result['usable_with_current_route']=result['mechanical_passed'] and not collisions
    assert result['usable_with_current_route'],(side,result)
    for center in (24,25,26,27,28,28.5,29,44):
        probe=m.Parameters(phone_thickness=8,button_from_end=76+center,side=side)
        parts=m.assembly_parts(probe,s);route,_,_=m.flexible_paths(probe)
        outgoing=m.rod(route[33],route[34],2)
        hits={}
        for name,part in parts.items():
            value=overlap(outgoing,part)
            if value>.01:hits[name]=value
        mount_hit=overlap(parts['actuator_bracket'],parts['shaft_cap'])
        report['outgoing_cord_sweep'][side+'-'+str(center)]={'collisions_mm3':hits,'clear':not hits,'mount_cap_overlap_mm3':mount_hit,'mount_center_y_mm':probe.button_y+m.MOUNT_Y}
        print(side,center,'outgoing cord',hits,flush=True)
    p=m.Parameters(phone_thickness=8,button_from_end=99.75,side=side)
    a=m.assembly_parts(p,s)
    v=overlap(a['actuator_bracket'],a['shaft_cap'])
    report['positions'][side+'-23.75']={'bracket_cap_collision_mm3':v}
    print(label,'routing',collisions,'; 23.75 bracket/cap overlap',v,flush=True)
key=key_shape().translate((-20,36,0))
for angle in (.5,1,1.5,2,2.5,3):
    values=[overlap(key.rotate((12,36,26),(13,36,26),sign*angle),s['shaft_cap']) for sign in (-1,1)]
    report['loose_key'][str(angle)]={'slot_intersection_mm3':values,'shoe_center_lateral_shift_mm':18*math.sin(math.radians(angle))}
assert all(v<.01 for v in report['loose_key']['2.5']['slot_intersection_mm3'])
assert all(v>.01 for v in report['loose_key']['3']['slot_intersection_mm3'])
report['audit_completed']=True
report['inward_24_usable_both_sides']=False
report['assessment']='The offset mount changes available slot travel. Original phone positions remain unchanged. Near Y29 and far Y-24 pass the full synthetic check; no continuous reach range or force qualification.'
(Path(__file__).resolve().parents[1]/'review/compact-keyed-plunger.json').write_text(json.dumps(report,indent=2)+'\n')
print('Active compact mount audit complete; 24 mm usable both sides:',report['inward_24_usable_both_sides'],flush=True)
