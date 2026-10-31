"""Restore flat handle after user rejected the added left lip (2026-10-31)."""
from pathlib import Path
import shutil
ROOT=Path(__file__).resolve().parents[1]
src=ROOT/'review/concepts/flat-handle-face-b'
out=ROOT/'review/concepts/left-lip-handle-b'
for ext in ['step','stl']:
 shutil.copy2(src/('b-plunger.'+ext),out/('b-plunger.'+ext))
print('Left lip removed; flat wheel-side face retained. Historical lip slice is superseded.')
