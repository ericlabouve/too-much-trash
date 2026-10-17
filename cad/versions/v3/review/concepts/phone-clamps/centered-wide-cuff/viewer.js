import * as T from 'three';
import {sceneAt} from './concept_scene.js';
import {STLLoader} from 'three/addons/loaders/STLLoader.js';

const $=s=>document.querySelector(s),loader=new STLLoader(),cache=new Map();
const descriptions={
 A:{mechanism:'A broad recessed T-head holds the middle of the wide cuff. Its short stem enters a shallow jaw pocket. The existing small key passes sideways through the stem, blocking the main T from withdrawing toward the phone.',tradeoff:'Closest to your larger-T idea, but the tightest package. It requires a relieved receiver, added standoff, and a thin ligament beyond the locking hole. The small cross-key can still drift; this is not a self-locking fastener.',detail:'Amber = new broad T. Blue = the existing 12.2 mm key inserted at 90°. The stem stops before the silver neck; it does not pass through it.'},
 B:{mechanism:'The cuff slides along the phone edge onto a broad dovetail shoe. The track captures it against pulling away from the jaw. A closed end and a removable shared-key stop prevent sliding off either end.',tradeoff:'Fewest new rigid retainer shapes and a distributed attachment. Needs space to slide the cuff off for service. TPU track peel and stretch need tests; a rigid PETG fit trial will not establish retention in TPU.',detail:'Side-loading track: no T stem points at the neck. The blue key blocks the open end of the track. Remove the stop before sliding the cuff off.'},
 C:{mechanism:'The fixed cuff is centered and limited to the existing 21.6 mm contact footprint. Its attachment is intentionally unresolved. Each opposite 21.6 mm cuff keeps one larger pierced T, cross-locked by the existing 12.2 mm axle key: two locking assemblies overall.',tradeoff:'No fastener or glue is implied for the fixed cuff. The smaller-cuff locking keys still need drift and load tests. The unchanged actuator and red volume button show one bare-phone example, not universal button clearance.',detail:'Select Fixed cuff to inspect the common T socket and plain backing; it is NOT secured. Select Sliding cuff to inspect the retained amber T and blue transverse key. Green and cyan are one TPU part.'}
};
const main=sceneAt('assembly'),detail=sceneAt('detail');let manifest,current,mode='assembled',target='fixed';
function color(value){return Array.isArray(value)?new T.Color(...value):new T.Color(value??0xe88a30);}
const assetVersion=Date.now();
async function geometry(file){if(!cache.has(file))cache.set(file,loader.loadAsync(file+'?load='+assetVersion));return await cache.get(file);}
async function fill(view,parts,isDetail){
 view.clear();
 for(const p of parts){const material=new T.MeshStandardMaterial({color:color(p.color),roughness:.65,metalness:0});const mesh=new T.Mesh(await geometry(p.file),material);mesh.name=p.name;mesh.userData=p;view.root.add(mesh);if(isDetail&&mode==='exploded')mesh.position.fromArray(p.explode||[0,0,0]);
  if(isDetail&&mode==='section'){material.clippingPlanes=[new T.Plane(new T.Vector3(0,0,1),0)];material.side=T.DoubleSide;}
 }
 updateVisibility();view.frame();view.render();
}
function updateVisibility(){for(const m of main.root.children){m.visible=m.userData.group==='phone'?$('#phone').checked:m.userData.group==='cap'?$('#cap').checked:m.userData.group==='actuator'?$('#actuator').checked:true;}main.invalidate();}
async function show(id){window.reviewReady=false;current=manifest.concepts.find(c=>c.id===id)||manifest.concepts[0];const d=descriptions[current.id];$('#title').textContent=current.title;$('#dimensions').textContent=`Fixed cuff ${current.dimensions.fixed_cuff_width_mm} mm · sliding cuffs ${current.dimensions.sliding_cuff_width_mm} mm · centers ±50 mm`;$('#mechanism').textContent=d.mechanism;$('#tradeoff').textContent=d.tradeoff;$('#detail-note').textContent=d.detail+(mode==='exploded'?' Exploded spacing is illustrative, not a verified insertion path.':mode==='section'?' Half-section removes material only in the rendering.':'');$('#evidence').textContent=(current.notes||[]).join(' ')||'CAD solids and nominal clearances are reviewed; manufacturing, strength, full phone fit and actuator reach are not qualified.';
 for(const b of document.querySelectorAll('[data-concept]'))b.setAttribute('aria-pressed',String(b.dataset.concept===current.id));
 await Promise.all([fill(main,current.parts,false),fill(detail,target==='sliding'?current.sliding_detail_parts:current.detail_parts,true)]);document.body.dataset.concept=current.id;document.body.dataset.detail=mode;document.body.dataset.target=target;const url=new URL(location.href);url.searchParams.set('concept',current.id);url.searchParams.set('detail',mode);url.searchParams.set('target',target);url.searchParams.set('revision',manifest.revision);history.replaceState(null,'',url);window.reviewReady=true;
}
try{
 const response=await fetch('manifest.json',{cache:'no-store'});if(!response.ok)throw Error('Concept geometry has not loaded');manifest=await response.json();manifest.concepts=manifest.concepts.map(c=>({...c,id:c.id.toUpperCase()}));
 const query=new URLSearchParams(location.search);mode=['assembled','exploded','section'].includes(query.get('detail'))?query.get('detail'):'assembled';$('#detail-mode').value=mode;
 target=query.get('target')==='sliding'?'sliding':'fixed';$('#detail-target').value=target;
 for(const b of document.querySelectorAll('[data-concept]'))b.onclick=()=>show(b.dataset.concept).catch(fail);
 $('#detail-mode').onchange=()=>{mode=$('#detail-mode').value;show(current.id).catch(fail);};$('#detail-target').onchange=()=>{target=$('#detail-target').value;show(current.id).catch(fail);};$('#phone').onchange=updateVisibility;$('#cap').onchange=updateVisibility;$('#actuator').onchange=updateVisibility;$('#reset-main').onclick=()=>main.frame();$('#reset-detail').onclick=()=>detail.frame();
 await show(query.get('concept')||'C');window.conceptReview={show,get manifest(){return manifest;},get current(){return current.id;},get detail(){return mode;},counts:()=>({main:main.root.children.length,detail:detail.root.children.length}),setTarget:async value=>{target=value;$('#detail-target').value=value;await show(current.id);},setDetail:async value=>{mode=value;$('#detail-mode').value=value;await show(current.id);}};
}catch(e){fail(e);}
function fail(e){$('#error').textContent=e.message;console.error(e);}
