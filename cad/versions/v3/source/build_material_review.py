"""Publish material plate navigation and sorted extrusion-mass tables."""
import json,html
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'review/material-plates';OUT.mkdir(exist_ok=True)
jobs=[('1','PETG · all seven rigid parts','2026-10-26-flush-fins-petg'),
      ('2','TPU · all flexible parts','2026-10-26-material-tpu')]
labels={'carrier':'Fixed jaw','shaft_cap':'Shaft cap','sliding_jaw':'Sliding jaw','actuator_bracket':'Actuator bracket','plunger':'Plunger','pulley':'Redirect pulley','pulley_axle':'Smooth axle','phone_cuff':'Rounded cuff','collar_screw':'Common long screw','thumb_nut':'Common nut','pulley_key':'T/V axle key','clip_string_guide':'Clip string guide'}
rows={};plates=[]
for plate,title,job in jobs:
    d=json.loads((ROOT/'print/jobs'/job/'review.json').read_text())
    plates.append({'plate':plate,'title':title,'job':job,'pieces':d['pieces'],'grams':d['total_g'],'minutes':d['total_minutes'],'support_g':sum(d['deposited_g_by_role'].get(k,0) for k in ('support','interface')),'warning':d['warning']})
    for name,part in d['objects'].items():
        design=name.rsplit('_',1)[0] if name.rsplit('_',1)[-1].isdigit() else name
        r=rows.setdefault(design,{'design':design,'name':labels[design],'plate':plate,'material':'TPU 95A' if plate=='2' else 'PETG','quantity':0,'support_g':0.,'model_g':0.})
        r['quantity']+=1
        r['support_g']+=sum(part['deposited_g_by_role'].get(k,0) for k in ('support','interface'))
        r['model_g']+=part['deposited_g_by_role'].get('model',0)
manifest=json.loads((ROOT/'print/manifest.json').read_text())
assert {n:r['quantity'] for n,r in rows.items()}=={p['name']:p['quantity'] for p in manifest['parts']}
for r in rows.values():
    r['support_each_g']=r['support_g']/r['quantity'];r['model_each_g']=r['model_g']/r['quantity']
data={'plates':plates,'pieces':sum(r['quantity'] for r in rows.values()),'parts':list(rows.values()),'rank_basis':'per-piece average; all-copies totals also shown','printer_contacted':False,'rigid_arrangement':'Silhouette nesting fits all seven rigid parts on one plate; exact projected deposited-path separation checked where bounding boxes overlap.'}
(OUT/'comparison.json').write_text(json.dumps(data,indent=2)+'\n')
def table(key):
    return '<table><thead><tr><th>Piece</th><th>Plate</th><th>Qty</th><th>g / piece</th><th>g / all copies</th></tr></thead><tbody>'+''.join(f'<tr><td>{html.escape(r["name"])} <small>{r["material"]}</small></td><td>{r["plate"]}</td><td>{r["quantity"]}</td><td>{r[key+"_each_g"]:.4f}</td><td>{r[key+"_g"]:.4f}</td></tr>' for r in sorted(rows.values(),key=lambda r:(-r[key+'_each_g'],r['name'])))+'</tbody></table>'
buttons=''.join(f'<button data-url="../../print/jobs/{job}/">Plate {p} · {title}</button>' for p,title,job in jobs)
cards=''.join(f'<article><b>Plate {p["plate"]} · {p["pieces"]} pieces</b><p>{p["grams"]:.2f} g · {round(p["minutes"])} min · {p["support_g"]:.3f} g support</p><a href="../../print/jobs/{p["job"]}/cuff-fit.gcode.3mf">Sliced 3MF</a> · <a href="../../print/jobs/{p["job"]}/" target="_blank">Open full preview</a></article>' for p in plates)
page='''<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>V3 · Material plates and support rankings</title><style>
body{margin:0;color:#24383b;background:#faf9f6;font:16px system-ui}header,section{padding:22px;max-width:1400px;margin:auto}h1{margin:0 0 12px}p{line-height:1.5}nav,.cards{display:flex;gap:12px;flex-wrap:wrap}button{padding:13px;border:1px solid #b9c6c7;border-radius:6px;background:white;cursor:pointer;color:inherit}button[aria-pressed=true]{background:#24464a;color:white}iframe{display:block;width:100%;height:85vh;border:0;background:white}.cards article{flex:1;min-width:230px;background:white;padding:16px;border:1px solid #ddd}a{color:#126c80}table{width:100%;border-collapse:collapse;background:white}th,td{padding:12px;text-align:right;border-bottom:1px solid #ddd}th:first-child,td:first-child{text-align:left}small{display:block;color:#647477}h2{margin-top:30px}.tables{display:grid;grid-template-columns:1fr 1fr;gap:20px}.notice{background:#f2e8d5;padding:12px}@media(max-width:950px){.tables{display:block}section,header{padding:12px}th,td{padding:8px}}
</style><header><h1>V3 · Material plates</h1><p class="notice">22 pieces. All seven rigid pieces fit Plate 1; all 15 TPU pieces fit Plate 2. The sliding jaw has two 31 × 4 mm openings, retaining its center connection and cuff-stud bases. PETG recipes are provided for rigid parts—PLA would require a separate filament recipe and reslice. No print sent.</p><nav>BUTTONS</nav></header><iframe id="preview" title="Interactive selected plate toolpaths" src="../../print/jobs/2026-10-26-flush-fins-petg/"></iframe><section><div class="cards">CARDS</div><p>Same A1 mini / 0.4 mm nozzle / 0.12 mm layers. PETG: 250→245°C nozzle, 70°C bed. TPU: 230°C nozzle, 35°C bed, 2 mm³/s limit. Cuff supports are intentionally disabled based on successful physical feedback; the axle slot is bridged. Other parts have automatic supports enabled. Both slices have no warnings.</p><div class="tables"><div><h2>Support · highest to lowest</h2>SUPPORT</div><div><h2>Non-support model material · highest to lowest</h2>MODEL</div></div><p>Ranked per physical piece; repeated parts are grouped with quantity and combined mass. Support includes scaffold and interface. Model includes walls and infill; startup purge and adhesion are excluded. Totals may differ slightly through rounding. Zero support is slicer evidence, not proof of print quality. Strength, band fit, new TPU key/guide and full-assembly routing remain unqualified.</p><a href="comparison.json">Full numerical report</a></section><script>const buttons=[...document.querySelectorAll('nav button')];buttons.forEach((b,i)=>{b.setAttribute('aria-pressed',i===0);b.onclick=()=>{document.querySelector('#preview').src=b.dataset.url;buttons.forEach(x=>x.setAttribute('aria-pressed',x===b));}});</script></html>'''
page=page.replace('BUTTONS',buttons).replace('CARDS',cards).replace('SUPPORT',table('support')).replace('MODEL',table('model'))
(OUT/'index.html').write_text(page)
print(json.dumps(data,indent=2))
