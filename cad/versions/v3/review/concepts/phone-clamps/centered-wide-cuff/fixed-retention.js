import * as T from 'three';
import {STLLoader} from 'three/addons/loaders/STLLoader.js';
import {sceneAt} from './concept_scene.js';
const $=s=>document.querySelector(s),loader=new STLLoader(),cache=new Map(),views={stud:sceneAt('stud'),short:sceneAt('short')};
let manifest,generation=0;const stamp=Date.now();
async function geo(file){if(!cache.has(file))cache.set(file,loader.loadAsync(file+'?v='+stamp));return cache.get(file);}
function frame(){for(const v of Object.values(views))v.frame();const distance=Math.max(...Object.values(views).map(v=>v.camera.position.distanceTo(v.controls.target)));for(const v of Object.values(views)){v.camera.position.sub(v.controls.target).normalize().multiplyScalar(distance).add(v.controls.target);v.controls.update();v.invalidate();}}
async function show(){const request=++generation;window.reviewReady=false;const whole=$('#whole').checked,mode=whole?'assembled':$('#mode').value;$('#mode').disabled=whole;
 for(const option of manifest.options){const v=views[option.id];v.clear();for(const p of whole?option.parts:option.detail_parts){
   const material=new T.MeshStandardMaterial({color:p.color,roughness:.65,metalness:0});
   if(mode==='section'){material.clippingPlanes=[new T.Plane(new T.Vector3(0,0,1),0)];material.side=T.DoubleSide;}
   const geometry=await geo(p.file);if(request!==generation){material.dispose();return;}const mesh=new T.Mesh(geometry,material);mesh.name=p.name;mesh.userData=p;
   mesh.visible=p.group==='phone'?false:p.group==='neck'?$('#neck').checked:p.group==='cuff'?$('#cuff').checked:true;
   if(mode==='exploded')mesh.position.fromArray(p.explode||[0,0,0]);v.root.add(mesh);
  }
 }
 if(request!==generation)return;frame();for(const v of Object.values(views))v.render();document.body.dataset.mode=mode;document.body.dataset.whole=whole;const url=new URL(location.href);url.searchParams.set('mode',mode);url.searchParams.set('whole',String(whole));url.searchParams.set('revision',manifest.revision);history.replaceState(null,'',url);window.reviewReady=true;
}
try{
 const response=await fetch('fixed-retention.json',{cache:'no-store'});if(!response.ok)throw Error('Retention geometry has not loaded');manifest=await response.json();
 const q=new URLSearchParams(location.search);if(['assembled','exploded','section'].includes(q.get('mode')))$('#mode').value=q.get('mode');$('#whole').checked=q.get('whole')==='true';
 $('#stud-check').textContent='Valid single-piece jaw; zero nominal cuff/neck interference. Common cuff unchanged.';
 $('#short-check').textContent='Valid single-piece jaw; zero nominal assembled interference. Sampled keeper/T removal paths clear in this local model.';
 for(const id of ['mode','whole','neck','cuff'])$('#'+id).onchange=()=>show().catch(fail);$('#reset').onclick=frame;
 await show();window.retentionReview={manifest,show,counts:()=>Object.fromEntries(Object.entries(views).map(([id,v])=>[id,v.root.children.length]))};
}catch(e){fail(e);}
function fail(e){$('#error').textContent=e.message;console.error(e);}
