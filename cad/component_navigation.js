// Explicit BOM-to-assembly links: no phantom geometry for unmodeled supplies.
export function assemblyNames(row, names){
  const name=row[0];
  if(name.startsWith('`print/'))return [name.slice(7,-5)];
  const rules=[
    ['M4×80',['draw_screw_M4','draw_screw_head']],['M4 square nut',['jaw_nut']],
    ['M4×35',['collar_M4_phone_21.2']],['M3×25',['carriage_M3_-8','carriage_M3_8']],
    ['3 mm smooth',['pivot_M3']],['M3 threaded',['contact_M3','contact_locknut','contact_rear_locknut']],
    ['M3×20',['travel_stop_M3','travel_stop_nut']],['Bicycle brake housing',['housing_route_0']],
    ['Stainless brake',['phone_inner_wire']],['Screw-on cable',['cable_pinch_barrel']],
    ['Torsion return',['return_spring_coil','return_spring_fixed_leg','return_spring_moving_leg']],
    ['Closed-eye',['series_extension_spring_envelope']],['Side jaw pads',['soft_side_pad_left','soft_side_pad_right']],
    ['Rear jaw pads',['soft_rear_pad_left','soft_rear_pad_right']],['Soft button-contact',['soft_button_tip']],
    ['Trigger strap',['trigger_strap_envelope']]];
  return (rules.find(([prefix])=>name.startsWith(prefix))?.[1]||[]).filter(n=>names.has(n));
}
export function installNavigation({THREE,scene,camera,controls,canvas,bomMeshes,meshByName,rows,getMode,setMode,allowed}){
  const menu=document.querySelector('#component-menu'),info=document.querySelector('#selection-info');
  let selected=-1,targets=[],outline=null,pointerStart=null;
  const rowNames=rows.map(row=>assemblyNames(row,meshByName));
  bomMeshes.forEach(entry=>{entry.mesh.userData.rowId=rows.findIndex(r=>r[0]===entry.rowName);});
  for(const [name,mesh] of meshByName){mesh.userData.rowId=rowNames.findIndex(list=>list.includes(name));}
  const closeMenu=()=>{menu.hidden=true;};
  function refreshRows(){document.querySelectorAll('tr[data-row-id]').forEach(el=>{const active=Number(el.dataset.rowId)===selected;el.classList.toggle('selected',active);el.setAttribute('aria-selected',String(active));});}
  function clear(){for(const m of targets)m.material.emissive?.setHex(0);targets=[];selected=-1;if(outline){scene.remove(outline);outline.geometry.dispose();outline.material.dispose();outline=null;}info.textContent='';refreshRows();closeMenu();}
  function highlight(meshes){targets=meshes;for(const m of targets)m.material.emissive?.setHex(0x665000);scene.updateMatrixWorld(true);const box=new THREE.Box3();for(const m of targets)box.expandByObject(m);outline=new THREE.Box3Helper(box,0xffbd16);outline.material.depthTest=false;outline.renderOrder=1000;scene.add(outline);return box;}
  function focus(box){const center=box.getCenter(new THREE.Vector3()),size=box.getSize(new THREE.Vector3());const direction=camera.position.clone().sub(controls.target).normalize();if(direction.lengthSq()<.1)direction.set(1,1,1).normalize();const radius=Math.max(size.length()/2,12);const fov=Math.min(camera.fov*Math.PI/180,2*Math.atan(Math.tan(camera.fov*Math.PI/360)*camera.aspect));const distance=radius/Math.sin(fov/2)*1.35;controls.target.copy(center);camera.position.copy(center).add(direction.multiplyScalar(distance));controls.update();canvas.scrollIntoView({block:'center',behavior:'instant'});}
  function select(rowId,meshOverride=null){clear();selected=rowId;refreshRows();const title=rows[rowId]?.[0].replaceAll('`','');if(!title)return;
    const meshes=meshOverride||(getMode()==='bom'?bomMeshes.filter(e=>e.rowName===rows[rowId][0]).map(e=>e.mesh):rowNames[rowId].filter(n=>allowed(n,getMode())).map(n=>meshByName.get(n)));
    if(!meshes.length){info.textContent=`${title}: no CAD model is available for this item yet.`;info.scrollIntoView({block:'nearest'});return;}
    const box=highlight(meshes);focus(box);info.textContent=`Selected: ${title}. Yellow outline marks the component. Right-click for assembly views; “Show all” resets the view.`;
  }
  function context(rowId,x,y,instanceNames=null){if(rowId<0||!rows[rowId])return;menu.replaceChildren();const heading=document.createElement('strong');heading.textContent=rows[rowId][0].replaceAll('`','');menu.append(heading);
    for(const [view,label] of [['phone','Phone assembly'],['full','Full tool'],['actuator','Actuator']]){const names=(instanceNames||rowNames[rowId]).filter(n=>allowed(n,view));const button=document.createElement('button');button.role='menuitem';button.textContent=`View in ${label}`;button.disabled=names.length===0;button.title=names.length?'Zoom to and highlight this component':'No modeled instance in this view';button.onclick=()=>{closeMenu();setMode(view);select(rowId,names.map(n=>meshByName.get(n)));};menu.append(button);}
    if(!rowNames[rowId].length){const note=document.createElement('p');note.textContent='No CAD geometry available yet.';menu.append(note);}
    menu.hidden=false;menu.style.left=`${Math.max(8,Math.min(x,innerWidth-menu.offsetWidth-8))}px`;menu.style.top=`${Math.max(8,Math.min(y,innerHeight-menu.offsetHeight-8))}px`;menu.querySelector('button:not(:disabled)')?.focus();
  }
  const inventory=document.querySelector('#inventory');
  inventory.addEventListener('click',e=>{const tr=e.target.closest('tr[data-row-id]');if(tr)select(Number(tr.dataset.rowId));});
  inventory.addEventListener('contextmenu',e=>{const tr=e.target.closest('tr[data-row-id]');if(tr){e.preventDefault();context(Number(tr.dataset.rowId),e.clientX,e.clientY);}});
  inventory.addEventListener('keydown',e=>{const tr=e.target.closest('tr[data-row-id]');if(!tr)return;const id=Number(tr.dataset.rowId);if(e.key==='Enter'||e.key===' '){e.preventDefault();select(id);}if(e.key==='ContextMenu'||(e.shiftKey&&e.key==='F10')){e.preventDefault();const rect=tr.getBoundingClientRect();context(id,rect.left+30,rect.top+20);}});
  const raycaster=new THREE.Raycaster();
  function pick(e){const rect=canvas.getBoundingClientRect();const mouse=new THREE.Vector2((e.clientX-rect.left)/rect.width*2-1,-(e.clientY-rect.top)/rect.height*2+1);scene.updateMatrixWorld(true);raycaster.setFromCamera(mouse,camera);const candidates=getMode()==='bom'?bomMeshes.map(e=>e.mesh):[...meshByName.values()].filter(m=>m.visible);return raycaster.intersectObjects(candidates,false).find(hit=>hit.object.userData.rowId>=0)?.object;}
  canvas.addEventListener('pointerdown',e=>{pointerStart=[e.clientX,e.clientY];});
  canvas.addEventListener('click',e=>{if(!pointerStart||Math.hypot(e.clientX-pointerStart[0],e.clientY-pointerStart[1])>5)return;const mesh=pick(e);if(mesh)select(mesh.userData.rowId,[mesh]);});
  canvas.addEventListener('contextmenu',e=>{e.preventDefault();const mesh=pick(e);if(mesh)context(mesh.userData.rowId,e.clientX,e.clientY,getMode()==='bom'?null:[mesh.name]);else closeMenu();});
  document.addEventListener('pointerdown',e=>{if(!menu.contains(e.target))closeMenu();});document.addEventListener('keydown',e=>{if(e.key==='Escape')closeMenu();});window.addEventListener('resize',closeMenu);window.addEventListener('scroll',closeMenu,true);
  document.querySelector('#show-all').onclick=()=>{clear();setMode(getMode());};
  return {clear,refreshRows,tick(){if(outline){scene.updateMatrixWorld(true);outline.box.makeEmpty();for(const m of targets)outline.box.expandByObject(m);}}};
}
