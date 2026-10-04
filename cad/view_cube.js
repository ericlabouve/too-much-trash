import * as THREE from 'three';

// Controls keep a perspective backing camera; orthographic rendering preserves
// its target, orientation and apparent scale so orbit/zoom work in either mode.
export function installViewCube({canvas,camera,controls}) {
  const host=document.createElement('div');host.className='view-cube';
  Object.assign(host.style,{position:'absolute',right:'8px',top:'8px',zIndex:4,width:'112px',background:'#ffffffdc',borderRadius:'8px',font:'11px system-ui',textAlign:'center'});
  const parent=canvas.parentElement;if(getComputedStyle(parent).position==='static')parent.style.position='relative';parent.append(host);
  const c=document.createElement('canvas');c.width=c.height=112;Object.assign(c.style,{width:'112px',height:'112px',touchAction:'none',cursor:'grab'});c.tabIndex=0;c.setAttribute('aria-label','View cube: drag to orbit; click faces, edges or corners to snap');host.append(c);
  const toggle=document.createElement('button');toggle.textContent='Perspective';toggle.title='Toggle orthographic / perspective projection';toggle.style.cssText='font-size:10px;padding:3px 6px;margin-bottom:5px';host.append(toggle);
  const r=new THREE.WebGLRenderer({canvas:c,alpha:true,antialias:true});r.setPixelRatio(Math.min(devicePixelRatio,2));r.setSize(112,112,false);
  const scene=new THREE.Scene(),view=new THREE.PerspectiveCamera(35,1,.1,100),ortho=new THREE.OrthographicCamera();let orthographic=false;
  const names=['RIGHT','LEFT','TOP','BOTTOM','FRONT','BACK'];
  const materials=names.map(name=>{const tex=document.createElement('canvas');tex.width=tex.height=128;const ctx=tex.getContext('2d');ctx.fillStyle='#e9eef0';ctx.fillRect(0,0,128,128);ctx.strokeStyle='#607780';ctx.lineWidth=4;ctx.strokeRect(2,2,124,124);ctx.fillStyle='#243b40';ctx.textAlign='center';ctx.font='bold 19px system-ui';ctx.fillText(name,64,70);return new THREE.MeshBasicMaterial({map:new THREE.CanvasTexture(tex)});});
  const cube=new THREE.Mesh(new THREE.BoxGeometry(1,1,1),materials);scene.add(cube);
  const ray=new THREE.Raycaster();let start,last,moved=false;
  function snap(direction){const distance=camera.position.distanceTo(controls.target);camera.up.set(0,Math.abs(direction.y)>.99?0:1,Math.abs(direction.y)>.99?-Math.sign(direction.y):0);camera.position.copy(controls.target).addScaledVector(direction.normalize(),distance);controls.update();orthographic=true;toggle.textContent='Orthographic';}
  c.addEventListener('pointerdown',e=>{e.preventDefault();start=last=[e.clientX,e.clientY];moved=false;c.setPointerCapture(e.pointerId);controls.enabled=false;});
  c.addEventListener('pointermove',e=>{if(!last)return;const dx=e.clientX-last[0],dy=e.clientY-last[1];moved ||= Math.hypot(e.clientX-start[0],e.clientY-start[1])>4;last=[e.clientX,e.clientY];if(!moved)return;const right=new THREE.Vector3(1,0,0).applyQuaternion(camera.quaternion),up=new THREE.Vector3(0,1,0).applyQuaternion(camera.quaternion);const q=new THREE.Quaternion().setFromAxisAngle(up,-dx*.012).multiply(new THREE.Quaternion().setFromAxisAngle(right,-dy*.012));camera.position.sub(controls.target).applyQuaternion(q).add(controls.target);camera.up.applyQuaternion(q);camera.lookAt(controls.target);});
  c.addEventListener('pointerup',e=>{if(!last)return;last=null;controls.enabled=true;if(!moved){const b=c.getBoundingClientRect();ray.setFromCamera(new THREE.Vector2((e.clientX-b.left)/b.width*2-1,1-(e.clientY-b.top)/b.height*2),view);const hit=ray.intersectObject(cube)[0];if(hit){const p=hit.point;const d=new THREE.Vector3(...p.toArray().map(v=>Math.abs(v)>.32?Math.sign(v):0));snap(d);}}});
  c.addEventListener('pointercancel',()=>{last=null;controls.enabled=true;});
  c.addEventListener('keydown',e=>{const dirs={ArrowUp:[0,1,0],ArrowDown:[0,-1,0],ArrowLeft:[-1,0,0],ArrowRight:[1,0,0],Home:[0,0,1],End:[1,1,1]};if(dirs[e.key]){e.preventDefault();snap(new THREE.Vector3(...dirs[e.key]));}});
  toggle.onclick=()=>{orthographic=!orthographic;toggle.textContent=orthographic?'Orthographic':'Perspective';};
  return {get camera(){if(!orthographic)return camera;const half=camera.position.distanceTo(controls.target)*Math.tan(THREE.MathUtils.degToRad(camera.fov/2))/camera.zoom;ortho.left=-half*camera.aspect;ortho.right=half*camera.aspect;ortho.top=half;ortho.bottom=-half;ortho.near=camera.near;ortho.far=camera.far;ortho.position.copy(camera.position);ortho.quaternion.copy(camera.quaternion);ortho.updateProjectionMatrix();ortho.updateMatrixWorld();return ortho;},tick(){host.hidden=canvas.clientWidth===0||canvas.clientHeight===0;view.position.set(0,0,3.4).applyQuaternion(camera.quaternion);view.quaternion.copy(camera.quaternion);view.updateMatrixWorld();c.dataset.direction=camera.position.clone().sub(controls.target).normalize().toArray().join(',');c.dataset.projection=orthographic?'orthographic':'perspective';r.render(scene,view);},perspective(){orthographic=false;toggle.textContent='Perspective';},snap};
}
