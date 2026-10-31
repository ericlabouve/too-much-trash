"""Summarize the immutable matched support study."""
import json
from pathlib import Path
root=Path(__file__).resolve().parents[1]
rows=[]
for variant in ('baseline','flush-back','lowered-cleat'):
    folder=root/'print/jobs'/('2026-10-25-sliding-jaw-'+variant)
    report=json.loads((folder/'review.json').read_text())
    rows.append(dict(variant=variant,support_g=sum(report['deposited_g_by_role'].get(k,0) for k in ('support','interface')),
        total_g=report['total_g'],minutes=report['total_minutes'],hashes=report['hashes'],
        review=str((folder/'index.html').relative_to(root))))
for kind in ('machine.json','process.json','filament.json'):
    assert len({row['hashes'][kind] for row in rows})==1,kind
data=dict(selected='lowered-cleat',matched_profiles=True,rows=rows,
    support_reduction_percent=100*(1-rows[-1]['support_g']/rows[0]['support_g']),
    limits=['Support enabled in all slices; comparison is not proof of print quality or global minimum.',
            'Only one full refinement/review round after the initial flat-back candidate. No printer contacted.'])
(root/'review/sliding-jaw-slice-comparison.json').write_text(json.dumps(data,indent=2)+'\n')
print(json.dumps(data,indent=2))
