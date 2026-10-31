import * as T from 'three';
export function installSurfacePen(view,camera,controls,meshes){
 const canvas=view.querySelector('canvas'),bar=document.createElement('div');
 bar.style.cssText='padding:8px 26px;background:#f0eee5;display:flex;gap:12px;align-items:center;flex-wrap:wrap';
 bar.innerHTML='<button id="surface-pen" aria-pressed="false">Component pen</button><label>Surface color <input aria-label="Surface color" type="color" value="#00b7c7"></label><label>Surface radius (mm) <input aria-label="Surface radius" type="range" min="0.5" max="10" step="0.5" value="2"></label><button id="surface-undo" disabled>Undo surface stroke</button><button id="surface-clear" disabled>Clear surface marks</button><span>Live 3D: paint components only. Alt + drag to orbit.</span>';
 view.before(bar);
 const button=bar.querySelector('#surface-pen'),undo=bar.querySelector('#surface-undo'),clear=bar.querySelector('#surface-clear');
 let enabled=false,drawing=false,stroke=null,last=null;const strokes=[],ray=new T.Raycaster();
 const update=()=>{undo.disabled=clear.disabled=!strokes.length;};
 const dispose=s=>s.forEach(m=>{m.removeFromParent();m.geometry.dispose();m.material.dispose();});
 function stop(){drawing=false;stroke=null;last=null;controls.enabled=true;}
 button.onclick=()=>{enabled=!enabled;stop();button.setAttribute('aria-pressed',String(enabled));button.textContent=enabled?'Component pen ON':'Component pen';canvas.style.cursor=enabled?'crosshair':'';};
 undo.onclick=()=>{if(strokes.length)dispose(strokes.pop());update();};clear.onclick=()=>{strokes.forEach(dispose);strokes.length=0;update();};
 function paint(e){
  if(last&&Math.hypot(e.clientX-last[0],e.clientY-last[1])<3)return;last=[e.clientX,e.clientY];
  const r=canvas.getBoundingClientRect();ray.setFromCamera(new T.Vector2((e.clientX-r.left)/r.width*2-1,1-(e.clientY-r.top)/r.height*2),typeof camera==='function'?camera():camera);
  const hit=ray.intersectObjects(Object.entries(meshes).filter(([n,m])=>m.visible&&n!=='knot-envelope').map(([,m])=>m),false)[0];if(!hit)return;
  const mesh=hit.object,point=mesh.worldToLocal(hit.point.clone()),radius=Number(bar.querySelector('[type=range]').value),p=mesh.geometry.attributes.position,idx=mesh.geometry.index,verts=[],tri=new T.Triangle(),nearest=new T.Vector3();
  for(let i=0;i<(idx?idx.count:p.count);i+=3){const ids=[0,1,2].map(j=>idx?idx.getX(i+j):i+j);tri.set(...ids.map(j=>new T.Vector3().fromBufferAttribute(p,j)));tri.closestPointToPoint(point,nearest);if(nearest.distanceTo(point)<=radius)for(const j of ids)verts.push(p.getX(j),p.getY(j),p.getZ(j));}
  const g=new T.BufferGeometry();g.setAttribute('position',new T.Float32BufferAttribute(verts,3));g.computeVertexNormals();const mat=new T.MeshStandardMaterial({color:bar.querySelector('[type=color]').value,roughness:.7,side:T.DoubleSide,polygonOffset:true,polygonOffsetFactor:-2,polygonOffsetUnits:-2});
  mat.onBeforeCompile=s=>{s.uniforms.penPoint={value:point};s.uniforms.penRadius={value:radius};s.vertexShader='varying vec3 penPosition;\n'+s.vertexShader.replace('#include <begin_vertex>','#include <begin_vertex>\npenPosition=position;');s.fragmentShader='varying vec3 penPosition;uniform vec3 penPoint;uniform float penRadius;\n'+s.fragmentShader.replace('#include <clipping_planes_fragment>','#include <clipping_planes_fragment>\nif(distance(penPosition,penPoint)>penRadius)discard;');};
  const mark=new T.Mesh(g,mat);mark.renderOrder=3;mesh.add(mark);stroke.push(mark);update();
 }
 canvas.addEventListener('pointerdown',e=>{if(!enabled||window.annotationFrozen||e.altKey||e.button!==0)return;e.stopImmediatePropagation();e.preventDefault();controls.enabled=false;drawing=true;stroke=[];strokes.push(stroke);canvas.setPointerCapture(e.pointerId);paint(e);},{capture:true});
 canvas.addEventListener('pointermove',e=>{if(!drawing)return;e.stopImmediatePropagation();paint(e);},{capture:true});
 for(const name of ['pointerup','pointercancel'])canvas.addEventListener(name,e=>{if(!drawing)return;e.stopImmediatePropagation();if(stroke&&!stroke.length)strokes.pop();stop();update();},{capture:true});
 window.addEventListener('frame-pen-state',e=>{stop();bar.querySelectorAll('button,input').forEach(x=>x.disabled=e.detail);if(!e.detail)update();});
}
