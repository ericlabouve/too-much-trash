"""V4 data adapter for the shared V3 viewer app; no copied UI or V3 mutations."""
from pathlib import Path
from dataclasses import replace
import copy,json,sys
sys.path.insert(0,str(Path(__file__).resolve().parents[2]/'v3/source'))
import build as base
import model
from plunger_design import local_shape
from build_preview import clamp_geometry,FIXED_CUFF_DROP
from build_compact_mount_concept import geometry_compact
from phone_seating import seat_phone,seating
from cord_routes import routes, motion as cord_motion

def build(output):
    output.mkdir(parents=True,exist_ok=True)
    params=base.SAMPLES['wallet']
    solids=model.parts(params).copy()
    cap,jaw,cap_pad,jaw_pad=clamp_geometry(params)
    bracket,plunger,stop,*_=geometry_compact()
    solids.update(shaft_cap=cap,carrier=jaw,cap_liner=cap_pad,jaw_liner=jaw_pad,plunger=local_shape(plunger),actuator_bracket=local_shape(bracket),plunger_stop=local_shape(stop))
    for name in ('shaft_cap','carrier','cap_liner','jaw_liner','plunger','actuator_bracket','plunger_stop'):
        shape=solids[name].val()
        if not shape.isValid() or len(shape.Solids()) != 1:
            raise ValueError(f'Invalid or disconnected V4 viewer part: {name}')
    # The old guide is omitted; base.rows still expects it before filtering.
    bom=[copy.deepcopy(r) for r in base.BOM if r['id']!='clip_string_guide']
    notes={
      'actuator_bracket':'V4 compact 16.8 mm mount with centered Z8.4 screw bore, 70-degree captured guide and closed base travel slot for the common key. Automatic-support slice: zero support. Physical fit pending.',
      'shaft_cap':'V4: 97 mm compact clamp with flush liner seat, 30% shorter rail projections and mirrored 3 × 2 mm integral string guides. Supports: zero in reviewed cap slice; loaded grip untested.',
      'carrier':'V4: compact fixed jaw, flush liner seat, extended arm window and cuff/stud lowered 3.28 mm to plunger foot center. Revised jaw still needs slicing and physical validation.',
      'plunger':'V4: filled captured neck, curved foot, tail handle and integral raised common-key seat. Original axle key moves with plunger in plate slot; 12.6 mm escape limit, not button-safe stroke. Zero sliced supports; physical retention untested.'}
    for r in bom:
        if r['id'] in notes:r['note']=notes[r['id']]
        if r['id']=='twine':
            r['name']='Manually tensioned string';r['note']='Manual tension adjustment; no inline rubber band. Routing remains schematic.'
        if r['id']=='rubber_bands':
            r['quantity']=2;r['note']='One actuator return band and one jaw-closing band. No inline overtravel or axle-key keeper band.'
        if r['id']=='pulley_key':
            r.update(name='Common TPU T/V snap key',quantity=2,note='Two identical original 14.7 mm keys: one retains pulley axle, one moves with plunger in closed actuator-plate slot. Install plunger key top-down after inserting plunger. Pinch V arms below plate to remove. Axle fit user-tested; plunger retention untested. No keeper band.')
    for name,title in [('cap_liner','Shaft-cap TPU liner'),('jaw_liner','Fixed-jaw TPU liner')]:
        bom.insert(2,dict(id=name,name=title,quantity=1,material='ELEGOO TPU 95A',note='Full-face 0.8 mm liner replacing rigid contact skin; continuous lips register through existing windows. Grip and fit untested.'))
    old_rows=base.rows
    def rows(p,ss):
        result=[]
        # extra liners are not interpreted by V3 assembly_parts.
        for name,shape,color,bid in old_rows(p,ss):
            if name.startswith('guide_') or name in ('band_keeper','band_overtravel','band_jaw_2','twine_trigger'):continue
            route=routes(p)
            cord_paths={'twine':route['string_points'],'twine_phone':route['phone_points'],'twine_attachment':route['attachment_points'],'band_return':route['return_points']}
            if name in cord_paths:shape=model.polyline(cord_paths[name],1.2 if name=='band_return' else p.twine_diameter)
            if name.startswith(('clamp_screw_', 'clamp_nut_')):
                station_z=model.CLAMP_STATIONS[int(name.rsplit('_',1)[1])-1][1]
                shape=shape.translate((0,0,5 if station_z<15 else -5))
            if name.startswith(('rail_screw_', 'rail_nut_')):shape=shape.translate((0,1.4,0))
            if name=='cuff_fixed':shape=shape.translate((0,0,-FIXED_CUFF_DROP))
            if name=='sliding_jaw' or name.startswith('cuff_sliding_'):shape=shape.translate((seating(p)['sliding_jaw_closure_mm'],0,0))
            if name.startswith('band_jaw_'):
                z=model.JAW_BAND_LEVELS[int(name.rsplit('_',1)[1])-1]
                shape=model.polyline(model.jaw_band(p.phone_left-model.SLIDING_BEAM_SHIFT-1+model.SLIDING_CLEAT_SHIFT+seating(p)['sliding_jaw_closure_mm'],model.FIXED_CLEAT_X,z),1.4)
            if name in ('phone_envelope','camera_keepout','phone_volume_up'):shape=seat_phone(shape,p)
            result.append((name,shape,color,bid))
        result.append(('plunger_stop',model.placed(ss['plunger_stop'],p),(0,.55,.60),'pulley_key'))
        result.extend((n,ss[n],(0,.55,.60),n) for n in ('cap_liner','jaw_liner'))
        return result
    base.rows=rows;base.BOM=bom;base.OUT=output;base.REVISION='v4-compact-centered-mount'
    export_solids={n:s for n,s in solids.items() if n not in ('clip_string_guide','plunger_stop')}
    # export_scene/rows need the clip internally only; omit it from BOM/parts.
    def compatible_rows(p,ss):return rows(p,{**ss,'clip_string_guide':solids['clip_string_guide'],'plunger_stop':solids['plunger_stop']})
    base.rows=compatible_rows
    for sample,p in base.SAMPLES.items():
        for side in ('near','far'):
            p=replace(p,side=side)
            out=output if sample=='wallet' and side=='near' else output/f'{sample}-{side}'
            base.export_scene(p,export_solids,out)
            path=out/'manifest.json';data=json.loads(path.read_text())
            data.update(version='v4',title='Lined compact harness',revision='v4-compact-centered-mount',printed_designs=13,printed_pieces=24,status='V4 approved travel-stop actuator. Physical validation pending.')
            data['phone_seating']=seating(p)
            scene={name:shape for name,shape,_,_ in compatible_rows(p,export_solids)}
            data['phone_seating']['cuff_distance_mm']={name:scene['phone_envelope'].val().distance(scene[name].val()) for name in ('cuff_fixed','cuff_sliding_1','cuff_sliding_2')}
            data['motion']['mechanical_travel_mm']=12.6
            data['motion']['plunger_stop_moves_with_plunger']=True
            data['motion']['travel_mode']='Mechanical travel with assembly visible; range may pass phone contact, not button-safe stroke.'
            data['phone_seating']['cuff_overlap_mm3']={name:sum(s.Volume() for s in scene['phone_envelope'].intersect(scene[name]).solids().vals()) for name in ('cuff_fixed','cuff_sliding_1','cuff_sliding_2')}
            data['motion'].update(cord_motion(p))
            path.write_text(json.dumps(data,indent=2)+'\n')
    lines=['# V4 bill of materials','','|Component|Quantity|Material|','|---|---:|---|']
    lines.extend(f"|{r['name']}|{r['quantity']}|{r['material']}|" for r in bom)
    (output.parent/'bom.md').write_text('\n'.join(lines)+'\n')
if __name__=='__main__':build(Path(sys.argv[1]).resolve())
