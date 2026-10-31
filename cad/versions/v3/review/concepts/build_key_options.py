"""Render the two cross-key interpretations from CAD, not imagined geometry.

Study only: the narrow option intentionally has no replacement insertion stop.
"""
from pathlib import Path
import sys
import json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT.parents[1] / 'source'))
from plunger_design import box

def key(width):
    stem = box(7, 19, 6.5, 9.5, -1.2, 1.8).edges().fillet(.2)
    head = box(18, 21, 8-width/2, 8+width/2, -1.2, 1.8).edges().fillet(.35)
    shape = stem.union(head)
    return shape.cut(box(8, 9, 6.4, 7.1, -1.3, 1.9)).cut(box(8, 9, 8.9, 9.6, -1.3, 1.9))

def draw(ax, shape, elev, azim):
    vertices, triangles = shape.val().tessellate(.02, .1)
    # Put the head at the top and show the same physical scale in every panel.
    pts = np.array([(v.y-8, v.z-.3, v.x-7) for v in vertices])
    faces = pts[np.asarray(triangles)]
    normal = np.cross(faces[:, 1]-faces[:, 0], faces[:, 2]-faces[:, 0])
    normal /= np.maximum(np.linalg.norm(normal, axis=1)[:, None], 1e-12)
    light = np.array([-.4, -.6, .7]); light /= np.linalg.norm(light)
    intensity = .62 + .38*np.clip(normal @ light, 0, 1)
    colors = np.array([1., .59, .22])[None, :] * intensity[:, None]
    ax.add_collection3d(Poly3DCollection(faces, facecolors=colors, linewidths=0, edgecolors='none'))
    ax.set(xlim=(-7.5, 7.5), ylim=(-7.5, 7.5), zlim=(-.5, 14.5))
    ax.set_box_aspect((1, 1, 1)); ax.set_proj_type('ortho')
    ax.view_init(elev=elev, azim=azim); ax.set_axis_off()

fig = plt.figure(figsize=(15, 9), facecolor='white')
views = [(0, -90, 'FACE — head width'), (0, 0, 'EDGE — thickness'), (22, -55, '3D')]
options = [
    ('A · Narrow the head', 3, 'Head = stem width: 3 mm. Both are 3 mm thick.',
     'Removes the wide insertion stop / band seat. Retention needs redesign.'),
    ('B · Keep the wide head; flatten its thickness', 7, 'Head width stays 7 mm. Head and stem are both 3 mm thick.',
     'Keeps the broad insertion stop / band seat. Printed retention still untested.')]
fig.text(.035, .965, 'Cross-key: which change did you mean?', fontsize=22, weight='bold', color='#27333b')
fig.text(.035, .93, 'Actual CAD study shapes · identical scale · orange is retained material', fontsize=12, color='#48545b')
for row, (title, width, dimension, limitation) in enumerate(options):
    top = .88 - row*.43
    fig.text(.035, top, title, fontsize=18, weight='bold', color='#27333b')
    fig.text(.035, top-.035, dimension, fontsize=12, color='#27333b')
    shape = key(width)
    assert shape.val().isValid() and len(shape.val().Solids()) == 1
    for col, (elev, azim, label) in enumerate(views):
        ax = fig.add_axes([.035+col*.315, top-.315, .28, .28], projection='3d')
        draw(ax, shape, elev, azim)
        ax.text2D(.5, -.02, label, transform=ax.transAxes, ha='center', fontsize=11, color='#48545b')
    fig.text(.035, top-.37, limitation, fontsize=12, color='#27333b')
fig.savefig(ROOT/'cross-key-options.png', dpi=150, facecolor='white')
(ROOT/'cross-key-options.spec.json').write_text(json.dumps({
    'status': 'Option B selected by user; no strength or print qualification',
    'selected_option': 'B',
    'selection_date': '2026-10-14',
    'request_date': '2026-10-14',
    'A': {'head_width_mm': 3, 'stem_width_mm': 3, 'thickness_mm': 3,
          'warning': 'Wide head stop removed; replacement retention not designed'},
    'B': {'head_width_mm': 7, 'stem_width_mm': 3, 'thickness_mm': 3,
          'warning': 'Wide head retained; physical retention untested'},
    'unchanged': ['14 mm key length', 'stem band notches'],
    'views': ['face', 'edge', 'orthographic 3D'], 'common_scale': True
}, indent=2)+'\n')
print(ROOT/'cross-key-options.png', flush=True)
