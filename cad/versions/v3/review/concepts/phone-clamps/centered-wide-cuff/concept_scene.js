import * as T from 'three';
import {OrbitControls} from 'three/addons/controls/OrbitControls.js';
import {installViewCube} from '../../../../../../view_cube.js';
const $=s=>document.querySelector(s);
export function sceneAt(id){
 const host=$('#'+id),renderer=new T.WebGLRenderer({antialias:true,preserveDrawingBuffer:true});renderer.setPixelRatio(Math.min(devicePixelRatio,2));renderer.setClearColor(0xffffff);renderer.localClippingEnabled=true;renderer.outputColorSpace=T.SRGBColorSpace;renderer.toneMapping=T.ACESFilmicToneMapping;host.append(renderer.domElement);
 const scene=new T.Scene(),root=new T.Group();root.rotation.x=-Math.PI/2;scene.add(root);scene.add(new T.HemisphereLight(0xffffff,0x84949b,2.4));
 for(const [pos,intensity] of [[[-100,180,150],2.7],[[160,60,-80],1.6]]){const light=new T.DirectionalLight(0xffffff,intensity);light.position.set(...pos);scene.add(light);}
 const camera=new T.PerspectiveCamera(32,1,.1,3000),controls=new OrbitControls(camera,renderer.domElement);controls.enableDamping=false;
 const cube=installViewCube({canvas:renderer.domElement,camera,controls});let last='',dirty=true;
 const label=document.createElement('div');label.className='part-label';label.hidden=true;host.append(label);
 function render(){renderer.setSize(host.clientWidth,host.clientHeight,false);camera.aspect=host.clientWidth/host.clientHeight;camera.updateProjectionMatrix();cube.tick();renderer.render(scene,cube.camera);dirty=false;}
 function tick(){const state=[...camera.position.toArray(),...camera.quaternion.toArray(),...camera.up.toArray(),...controls.target.toArray(),cube.camera.isOrthographicCamera].join(',');if(dirty||state!==last){render();last=state;}requestAnimationFrame(tick);}requestAnimationFrame(tick);
 controls.addEventListener('change',()=>{dirty=true;});new ResizeObserver(()=>{dirty=true;}).observe(host);
 const ray=new T.Raycaster();let start;
 renderer.domElement.addEventListener('pointerdown',e=>{start=[e.clientX,e.clientY];});
 renderer.domElement.addEventListener('click',e=>{if(!start||Math.hypot(e.clientX-start[0],e.clientY-start[1])>4)return;const r=renderer.domElement.getBoundingClientRect();ray.setFromCamera(new T.Vector2((e.clientX-r.left)/r.width*2-1,1-(e.clientY-r.top)/r.height*2),cube.camera);const hit=ray.intersectObjects(root.children,false).find(h=>h.object.visible);for(const m of root.children)m.material?.emissive?.setHex(0);label.hidden=!hit;if(hit){hit.object.material.emissive.setHex(0x233b3b);label.textContent=hit.object.name;}dirty=true;});
 function clear(){for(const child of [...root.children]){child.material.dispose();root.remove(child);}label.hidden=true;dirty=true;}
 function frame(){root.updateWorldMatrix(true,true);const bounds=new T.Box3();for(const m of root.children)if(m.visible&&m.userData.group!=='neck'&&m.userData.group!=='phone')bounds.expandByObject(m);if(bounds.isEmpty())bounds.setFromObject(root);const center=bounds.getCenter(new T.Vector3()),radius=Math.max(bounds.getSize(new T.Vector3()).length()/2,10);camera.aspect=host.clientWidth/host.clientHeight;const vf=T.MathUtils.degToRad(camera.fov),fov=Math.min(vf,2*Math.atan(Math.tan(vf/2)*camera.aspect));const distance=radius/Math.sin(fov/2)*1.12;camera.up.set(0,1,0);camera.position.copy(center).add(new T.Vector3(-1.1,.85,1.35).normalize().multiplyScalar(distance));controls.target.copy(center);cube.perspective();controls.update();dirty=true;}
 return{host,root,camera,controls,cube,render,clear,frame,invalidate(){dirty=true;},renderer};
}
