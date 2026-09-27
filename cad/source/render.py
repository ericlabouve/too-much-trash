"""Render real CAD triangles. Orthographic screen/back views expose placement."""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from dataclasses import replace
from assembly import scene,stop_angle

def bounds(rows,pad=8):
    boxes=[s.val().BoundingBox() for n,s,c in rows]
    return [(min(getattr(b,a+'min') for b in boxes)-pad,max(getattr(b,a+'max') for b in boxes)+pad) for a in 'xyz']

def draw(ax,rows,limits=None,elev=32,azim=-65):
    # Orthographic software z-buffer: avoids painter-order artifacts where a
    # large phone triangle incorrectly hides a smaller rear support or camera.
    er,ar=np.radians([elev,azim])
    direction=np.array([np.cos(er)*np.cos(ar),np.cos(er)*np.sin(ar),np.sin(er)])
    right=np.array([-np.sin(ar),np.cos(ar),0]);up=np.cross(direction,right)
    vertices=[];faces=[];colors=[];offset=0
    for name,shape,color in rows:
        vv,ff=shape.val().tessellate(.18,.15)
        vv=np.array([[v.x,v.y,v.z] for v in vv]);ff=np.array(ff)
        normals=np.cross(vv[ff[:,1]]-vv[ff[:,0]],vv[ff[:,2]]-vv[ff[:,0]])
        normals/=np.maximum(np.linalg.norm(normals,axis=1)[:,None],1e-9)
        shades=.58+.42*np.abs(normals@np.array([-.4,-.5,.76]))
        vertices.extend(vv);faces.extend(ff+offset);colors.extend(np.clip(np.array(color)*shades[:,None],0,1));offset+=len(vv)
    vertices=np.array(vertices);faces=np.array(faces);colors=np.array(colors)
    q=np.column_stack((vertices@right,vertices@up,vertices@direction))
    lo=q[:,:2].min(axis=0);hi=q[:,:2].max(axis=0)
    size=900;scale=(size-30)/max(hi-lo)
    q[:,:2]=(q[:,:2]-(hi+lo)/2)*scale+size/2
    q[:,1]=size-q[:,1]
    canvas=np.ones((size,size,3));depth=np.full((size,size),-np.inf)
    for face,color in zip(faces,colors):
        tri=q[face];x0=max(0,int(np.floor(tri[:,0].min())));x1=min(size-1,int(np.ceil(tri[:,0].max())))
        y0=max(0,int(np.floor(tri[:,1].min())));y1=min(size-1,int(np.ceil(tri[:,1].max())))
        if x1<x0 or y1<y0:continue
        (a,b,c)=tri;den=(b[1]-c[1])*(a[0]-c[0])+(c[0]-b[0])*(a[1]-c[1])
        if abs(den)<1e-10:continue
        yy,xx=np.mgrid[y0:y1+1,x0:x1+1];xx=xx+.5;yy=yy+.5
        u=((b[1]-c[1])*(xx-c[0])+(c[0]-b[0])*(yy-c[1]))/den
        v=((c[1]-a[1])*(xx-c[0])+(a[0]-c[0])*(yy-c[1]))/den;w=1-u-v
        z=u*a[2]+v*b[2]+w*c[2];region=depth[y0:y1+1,x0:x1+1]
        hit=(u>=-1e-8)&(v>=-1e-8)&(w>=-1e-8)&(z>region)
        region[hit]=z[hit];canvas[y0:y1+1,x0:x1+1][hit]=color
    ax.imshow(canvas);ax.set_axis_off()

def near_rows(parts,p):
    return [r for r in scene(parts,p) if not r[0].startswith(('stock_','handle_','housing_route','series_','trigger_','collar_M4_handle'))]

def render_all(parts,p,out):
    near=near_rows(parts,p)
    fig=plt.figure(figsize=(15,9),facecolor='white')
    ax=fig.add_subplot(121);draw(ax,near,elev=-60,azim=-65)
    ax.set_title('Screen side: open face, centered gripping band',fontsize=13)
    bx=fig.add_subplot(122);draw(bx,near,elev=55,azim=115)
    bx.set_title('Camera side: bridge and sliding jaw behind phone',fontsize=13)
    fig.suptitle('Too Much Trash | R4 — Option B: phone beside shaft',fontsize=19,weight='bold',y=.96)
    fig.text(.06,.09,'Orange: actual printed CAD solids. Gray: phone/wallet envelope and hardware.\n14 × 19 mm shaft • 76 × 152 × 18 mm sample • rear cameras toward claws',fontsize=11)
    fig.text(.06,.035,'Fit prototype: axial retention depends on padded clamp friction; use an independent phone tether.',fontsize=10,color='#555')
    fig.savefig(out/'assembly-cad.png',dpi=170);plt.close(fig)
    fig=plt.figure(figsize=(14,7),facecolor='white')
    names=('actuator_bracket','rocker','pivot','return_','contact_','soft_button','travel_','phone_inner','cable_pinch','carriage_')
    for i,a in enumerate((0,stop_angle(p))):
        ax=fig.add_subplot(1,2,i+1);detail=[r for r in scene(parts,p,a,stock=False) if r[0].startswith(names)]
        draw(ax,detail,elev=15,azim=90)
        ax.set_title('Released: 0.35 mm nominal gap' if i==0 else 'Pressed: nominal 0.30 mm button travel at stop',fontsize=11)
    fig.suptitle('Fixed housing stop → pinned rocker → padded contact screw',fontsize=16,y=.96)
    fig.text(.07,.06,'Return: torsion spring on pivot. Excess squeeze travel: inline extension spring at trigger.\nTravel values require physical calibration. Hardware uses unthreaded envelopes.',fontsize=10)
    fig.savefig(out/'actuator-cad.png',dpi=170);plt.close(fig)
    fig=plt.figure(figsize=(11,13),facecolor='white');ax=fig.add_subplot(111);draw(ax,scene(parts,p),elev=10,azim=-86)
    fig.suptitle('R4 — phone beside shaft; cable centered on trigger-facing surface',fontsize=15,y=.95)
    fig.text(.07,.045,'Stock silhouette, housing bends and handle station are provisional.\nShaft section and 200 mm available mounting region are measured.\nHousing polyline shows routing only; use smooth bends on the physical tool.',fontsize=10)
    fig.savefig(out/'full-assembly-cad.png',dpi=160);plt.close(fig)
    fig=plt.figure(figsize=(15,8),facecolor='white')
    for i,side in enumerate(('far','near')):
        pp=replace(p,actuator_side=side);ax=fig.add_subplot(1,2,i+1)
        draw(ax,near_rows(parts,pp),elev=-65,azim=-65)
        ax.set_title(f'Actuator {side} from shaft — same six part designs')
    fig.suptitle('Reversible actuator placement: identical bracket and rocker, no mirrored print',fontsize=16)
    fig.text(.08,.04,'Phone/camera envelope is reversed for the alternative control layout. Compatibility still requires measured button/camera clearance.',fontsize=10)
    fig.savefig(out/'actuator-sides-cad.png',dpi=160);plt.close(fig)

    fig=plt.figure(figsize=(15,9),facecolor='white')
    ax=fig.add_subplot(121)
    draw(ax,[r for r in near if r[0] in ('phone_envelope','camera_keepout','phone_volume_up','phone_volume_down')],elev=90,azim=180)
    ax.set_title('Rear landscape: cameras lower left; volume up on upper edge',fontsize=11)
    bxpos=450-(p.button_y-p.neck_cy)*870/p.phone_l
    bypos=450-p.phone_w/2*870/p.phone_l
    ax.annotate('Volume up',xy=(bxpos,bypos),xytext=(bxpos+35,bypos-75),fontsize=12,color='#145c9c',arrowprops={'arrowstyle':'->','color':'#145c9c'})
    bx=fig.add_subplot(122);draw(bx,near,elev=90,azim=180)
    bx.set_title('Demo actuator moved to upper edge, nearest shaft',fontsize=11)
    fig.suptitle('Corrected iPhone demo orientation — same printable parts',fontsize=17)
    fig.text(.07,.08,'Button centers use the supplied sample. Button sizes, spacing and camera block are illustrative envelopes.\nThis is a CAD placement view, not a dimensioned Apple device drawing.',fontsize=10)
    fig.savefig(out/'rear-landscape-cad.png',dpi=170);plt.close(fig)
