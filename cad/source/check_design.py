"""Functional checks: fit variants, full swept rocker, hardware and force budget."""
from dataclasses import replace
import json, math
from pathlib import Path
from itertools import combinations
from parameters import Parameters,SAMPLES
from parts import all_parts
from assembly import place,phone,hardware,stop_angle,tip_advance,contact_x,proxies

OUT=Path(__file__).resolve().parents[1]/'print'

def volume_overlap(a,b):
    return sum(s.Volume() for s in a.intersect(b).vals())

def check():
    base=Parameters();parts=all_parts(base)
    samples={**SAMPLES,'small':replace(base,phone_w=66,phone_t=7.5,button_from_end=105,button_from_screen=4),
             'large':replace(base,phone_w=86,phone_t=20,phone_l=170,button_from_end=125,button_from_screen=6)}
    samples={f'{n}_{side}':replace(p,actuator_side=side) for n,p in samples.items() for side in ('near','far')}
    failures=[];report={'samples':{},'failures':failures}
    for name,p in samples.items():
        p.validate();shapes={n:place(n,s,p) for n,s in parts.items()};ph=phone(p)
        for n,s in shapes.items():
            v=volume_overlap(s,ph)
            if v>.01:failures.append(f'{name}: {n}/phone {v:.3f} mm3')
        near=[n for n in shapes if n not in ('handle_anchor',)]
        for a,b in combinations(near,2):
            v=volume_overlap(shapes[a],shapes[b])
            if v>.01:failures.append(f'{name}: {a}/{b} {v:.3f} mm3')
        v=volume_overlap(ph,proxies(p)['stock_neck'])
        if v>.01:failures.append(f'{name}: phone/shaft {v:.3f} mm3')
        assert abs((ph.val().BoundingBox().ymin+ph.val().BoundingBox().ymax)/2-p.neck_cy)<1e-7
        hw0=hardware(p)
        for hn in ('draw_screw_M4','draw_screw_head','jaw_nut'):
            for pn in ('carrier','sliding_jaw','neck_cap'):
                v=volume_overlap(hw0[hn],shapes[pn])
                if v>.01:failures.append(f'{name}: {hn}/{pn} {v:.3f} mm3')
        amax=stop_angle(p)
        for i in range(11):
            a=amax*i/10;moving=place('rocker',parts['rocker'],p,a)
            for n in ('carrier','actuator_bracket','sliding_jaw'):
                v=volume_overlap(moving,shapes[n])
                if v>.01:failures.append(f'{name}@{i}: rocker/{n} {v:.3f} mm3')
            hw=hardware(p,a)
            v=volume_overlap(moving,hw['travel_stop_M3'])
            if v>.01:failures.append(f'{name}@{i}: rocker/travel stop {v:.3f} mm3')
            for n in ('contact_M3','contact_locknut','contact_rear_locknut','cable_pinch_barrel'):
                for fixed in ('carrier','actuator_bracket'):
                    v=volume_overlap(hw[n],shapes[fixed])
                    if v>.01:failures.append(f'{name}@{i}: {n}/{fixed} {v:.3f} mm3')
        cable=18*math.sin(amax)
        # Aligned upper-trigger tie and centered housing; axial stroke assumption.
        stroke20,stroke40=20,40
        extension=max(0,stroke40-cable)
        max_tension=p.spring_initial_n+p.spring_rate_n_mm*extension
        arm=12*math.cos(amax)-(contact_x(p)-11)*math.sin(amax)
        max_force=(max_tension*18*math.cos(amax)-(p.return_torque_nmm+p.return_rate_nmm_rad*amax))/arm
        assert extension < p.spring_rated_extension_mm
        assert abs(tip_advance(p,amax)-p.rest_gap-p.safe_button_stroke)<1e-7
        report['samples'][name]={'stop_degrees':math.degrees(amax),'cable_to_stop_mm':cable,
          'tip_rise_mm':(contact_x(p)-11)*math.sin(amax)+12*(1-math.cos(amax)),
          'takeup_20_mm':stroke20,'takeup_40_mm':stroke40,'spring_extension_mm':extension,
          'max_cable_tension_n':max_tension,'available_tip_force_n_before_stop':max_force}
    OUT.mkdir(exist_ok=True);(OUT/'validation.json').write_text(json.dumps(report,indent=2)+'\n')
    for f in failures:print(f)
    print(json.dumps(report['samples'],indent=2))
    if failures:raise SystemExit(f'{len(failures)} collision checks failed')
    print('PASS: samples, printed pairs, swept rocker, selected hardware, analytic travel and spring extension')
if __name__=='__main__':check()
