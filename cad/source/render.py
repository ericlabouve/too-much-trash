"""Render opaque real CAD triangles; no generative imagery."""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
from assembly import scene,stop_angle

def draw(ax,rows,limits,elev=32,azim=-65):
    for name,s,c in rows:
        verts,faces=s.val().tessellate(.18,.15)
        v=np.array([[a.x,a.y,a.z] for a in verts]);tri=v[np.array(faces)]
        normal=np.cross(tri[:,1]-tri[:,0],tri[:,2]-tri[:,0]);normal/=np.maximum(np.linalg.norm(normal,axis=1)[:,None],1e-9)
        shade=.58+.42*np.abs(normal@np.array([-.4,-.5,.76]))
        ax.add_collection3d(Poly3DCollection(tri,facecolors=np.clip(np.array(c)*shade[:,None],0,1),edgecolors='none',zsort='average'))
    ax.set(xlim=limits[0],ylim=limits[1],zlim=limits[2]);ax.set_box_aspect([b-a for a,b in limits]);ax.view_init(elev=elev,azim=azim);ax.set_axis_off()

def render_all(parts,p,out):
    rows=scene(parts,p)
    near=[r for r in rows if not r[0].startswith(('stock_','handle_','housing_route','series_','trigger_')) and not r[0].startswith('collar_M4_-')]
    fig=plt.figure(figsize=(15,9),facecolor='white')
    ax=fig.add_subplot(121,projection='3d',proj_type='ortho');draw(ax,near,((-42,140),(-10,160),(-30,48)),38,-67)
    ax.set_title('Phone retained in adjustable padded V jaws',fontsize=13)
    bx=fig.add_subplot(122,projection='3d',proj_type='ortho');draw(bx,[r for r in near if r[0] not in ('phone_envelope','camera_keepout')],((-42,140),(-10,160),(-30,48)),30,125)
    bx.set_title('Open carrier / integral rectangular shaft saddle',fontsize=13)
    fig.suptitle('Too Much Trash | R3 — six unique designs, seven printed pieces',fontsize=19,weight='bold',y=.96)
    fig.text(.06,.09,'Orange: actual printed CAD solids. Gray: phone/wallet envelope and metal hardware.\n14 × 19 mm shaft • 76 × 152 × 18 mm sample • +local Z toward claws • +local Y away from charging edge',fontsize=11)
    fig.text(.06,.035,'Fit prototype: pads, spring selection, retention and safe button travel require physical validation.',fontsize=10,color='#555')
    fig.savefig(out/'assembly-cad.png',dpi=170);plt.close(fig)
    fig=plt.figure(figsize=(14,7),facecolor='white')
    names=('actuator_bracket','rocker','pivot','return_','contact_','soft_','travel_','phone_inner','cable_pinch','carriage_')
    for i,a in enumerate((0,stop_angle(p))):
        ax=fig.add_subplot(1,2,i+1,projection='3d',proj_type='ortho');detail=[r for r in scene(parts,p,a,stock=False) if r[0].startswith(names)]
        draw(ax,detail,((-17,30),(p.button_from_end-16,p.button_from_end+16),(-22,42)),12,-90)
        ax.set_title('Released: 0.35 mm nominal gap' if i==0 else 'Pressed: nominal 0.30 mm button travel at stop',fontsize=11)
    fig.suptitle('Housing reaction → cable clamp → pinned rocker → padded contact screw',fontsize=16,y=.96)
    fig.text(.07,.06,'Return: torsion spring on pivot. Excess squeeze travel: inline extension spring at trigger.\nTravel values are calibration assumptions, not phone specifications. Hardware uses unthreaded envelopes.',fontsize=10)
    fig.savefig(out/'actuator-cad.png',dpi=170);plt.close(fig)
    fig=plt.figure(figsize=(9,13),facecolor='white');ax=fig.add_subplot(111,projection='3d',proj_type='ortho');draw(ax,rows,((-120,145),(-15,165),(-540,250)),10,-86)
    fig.suptitle('R3 retrofit on measured-section stock proxy',fontsize=17,y=.95)
    fig.text(.07,.045,'Stock silhouette, cable bends and handle station are provisional.\nShaft section and 200 mm available mounting region are measured.\nPhone mount stays between the claw mechanism and blue brace.',fontsize=10)
    fig.savefig(out/'full-assembly-cad.png',dpi=160);plt.close(fig)
