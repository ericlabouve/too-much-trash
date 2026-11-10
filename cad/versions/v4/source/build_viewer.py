"""V4 data adapter for the shared V3 viewer app; no copied UI or V3 mutations."""
from pathlib import Path
from dataclasses import replace
import copy,json,sys
sys.path.insert(0,str(Path(__file__).resolve().parents[2]/'v3/source'))
import build as base
import model
from plunger_design import local_shape
from build_preview import clamp_geometry,FIXED_CUFF_DROP
from build_steep_stop import geometry_stop

def build(output):
    output.mkdir(parents=True,exist_ok=True)
    params=base.SAMPLES['wallet']
    solids=model.parts(params).copy()
    cap,jaw,cap_pad,jaw_pad=clamp_geometry(params)
    bracket,plunger,stop,*_=geometry_stop()
    solids.update(shaft_cap=cap,carrier=jaw,cap_liner=cap_pad,jaw_liner=jaw_pad,plunger=local_shape(plunger),actuator_bracket=local_shape(bracket),plunger_stop=local_shape(stop))
    for name in ('shaft_cap','carrier','cap_liner','jaw_liner','plunger','actuator_bracket','plunger_stop'):
        shape=solids[name].val()
        if not shape.isValid() or len(shape.Solids()) != 1:
            raise ValueError(f'Invalid or disconnected V4 viewer part: {name}')
    # The old guide is omitted; base.rows still expects it before filtering.
    bom=[copy.deepcopy(r) for r in base.BOM if r['id']!='clip_string_guide']
    bom.append(dict(id='plunger_stop',name='Plunger T/V travel-stop key',quantity=1,material='ELEGOO TPU 95A',note='Short underside key, rotated 90 degrees; distinct from axle key. Install after plunger; physical retention untested.'))
    notes={
      'actuator_bracket':'V4 approved 70-degree captured guide with underside stop-key opening. Zero sliced supports; physical fit pending.',
      'shaft_cap':'V4: 97 mm compact clamp with flush liner seat, 30% shorter rail projections and mirrored 3 × 2 mm integral string guides. Supports: zero in reviewed cap slice; loaded grip untested.',
      'carrier':'V4: compact fixed jaw, flush liner seat, extended arm window and cuff/stud lowered 3.28 mm to plunger foot center. Revised jaw still needs slicing and physical validation.',
      'plunger':'V4: thicker captured neck, curved foot transition, tail handle and 19.65 mm closed slot ending at handle root. Nominal escape limit 12.6 mm, not button-safe stroke. Zero sliced supports; physical checks pending.'}
    for r in bom:
        if r['id'] in notes:r['note']=notes[r['id']]
        if r['id']=='twine':r['note']='Schematic route through the cap guide instead of a separate clip. Tension and full-stroke routing remain unresolved.'
    for name,title in [('cap_liner','Shaft-cap TPU liner'),('jaw_liner','Fixed-jaw TPU liner')]:
        bom.insert(2,dict(id=name,name=title,quantity=1,material='ELEGOO TPU 95A',note='Full-face 0.8 mm liner replacing rigid contact skin; continuous lips register through existing windows. Grip and fit untested.'))
    old_rows=base.rows
    def rows(p,ss):
        result=[]
        # extra liners are not interpreted by V3 assembly_parts.
        for name,shape,color,bid in old_rows(p,ss):
            if name.startswith('guide_'):continue
            if name.startswith(('clamp_screw_', 'clamp_nut_')):
                station_z=model.CLAMP_STATIONS[int(name.rsplit('_',1)[1])-1][1]
                shape=shape.translate((0,0,5 if station_z<15 else -5))
            if name=='cuff_fixed':shape=shape.translate((0,0,-FIXED_CUFF_DROP))
            result.append((name,shape,color,bid))
        result.append(('plunger_stop',model.placed(ss['plunger_stop'],p),(0,.55,.60),'plunger_stop'))
        result.extend((n,ss[n],(0,.55,.60),n) for n in ('cap_liner','jaw_liner'))
        return result
    base.rows=rows;base.BOM=bom;base.OUT=output;base.REVISION='v4-approved-travel-stop'
    export_solids={n:s for n,s in solids.items() if n!='clip_string_guide'}
    # export_scene/rows need the clip internally only; omit it from BOM/parts.
    def compatible_rows(p,ss):return rows(p,{**ss,'clip_string_guide':solids['clip_string_guide']})
    base.rows=compatible_rows
    for sample,p in base.SAMPLES.items():
        for side in ('near','far'):
            p=replace(p,side=side)
            out=output if sample=='wallet' and side=='near' else output/f'{sample}-{side}'
            base.export_scene(p,export_solids,out)
            path=out/'manifest.json';data=json.loads(path.read_text())
            data.update(version='v4',title='Lined compact harness',revision='v4-approved-travel-stop',printed_designs=14,printed_pieces=24,status='V4 approved travel-stop actuator. Physical validation pending.')
            data['motion']['schematic_warning']='V4 cord/band paths are schematic; the accepted handle moved 8 mm and physical routing remains unresolved.'
            path.write_text(json.dumps(data,indent=2)+'\n')
    lines=['# V4 bill of materials','','|Component|Quantity|Material|','|---|---:|---|']
    lines.extend(f"|{r['name']}|{r['quantity']}|{r['material']}|" for r in bom)
    (output.parent/'bom.md').write_text('\n'.join(lines)+'\n')
if __name__=='__main__':build(Path(sys.argv[1]).resolve())
