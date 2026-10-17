"""Active friction-clamp reach audit; no strength or retention qualification."""
import json
from pathlib import Path
from build import overlap, check
import model as m
from plunger_design import tube

s=m.parts(m.Parameters())
report={'revision':'post-print-open-pulley-v3','positions':{},'outgoing_cord_sweep':{},
        'rail_length_mm':120,'nominal_previous_two_screw_inward_center_mm':28,
        'mount_offset_y_mm':m.MOUNT_Y,'rail_locating_lugs':False,
        'limitations':['Not a tightened-play, force, strength, wear or print qualification.',
                      'Reach uses an explicit 8 mm synthetic phone; original phone proxies remain unchanged.',
                      'No geometric anti-rotation stop: screw preload and friction must resist sliding and rotation.']}
for side,center in (('near',29),('far',24),('far',28.5)):
    label=side+'-'+str(center)
    p=m.Parameters(phone_thickness=8,button_from_end=76+center,side=side)
    result=check(p,s)
    report['positions'][label]=result
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
    if side=='far' and center==24:
        # Keep the former inward candidate as a reported regression: the
        # longer axle conflicts with the carrier. Never silently move it.
        print(label,'former candidate usable:',result['usable_with_current_route'],flush=True)
        continue
    # Preserve failed candidates in the report rather than aborting before saving.
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
report['audit_completed']=True
report['inward_24_usable_both_sides']=False
report['assessment']='Phone envelopes and harness are unchanged. Consult each sampled position for rigid and routing failures after the 2 mm pulley lift; earlier clearance conclusions do not carry forward. The former far Y-24 candidate is retained. No continuous reach range or force qualification.'
(Path(__file__).resolve().parents[1]/'review/compact-keyed-plunger.json').write_text(json.dumps(report,indent=2)+'\n')
print('Active compact mount audit complete; 24 mm usable both sides:',report['inward_24_usable_both_sides'],flush=True)
