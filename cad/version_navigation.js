const select=document.querySelector('#version'),frame=document.querySelector('#design'),note=document.querySelector('#note');
try{
 const response=await fetch('versions.json');
 if(!response.ok)throw new Error(`Versions: HTTP ${response.status}`);
 const registry=await response.json();
 const versions=new Map(registry.versions.map(v=>[v.id,v]));
 for(const v of versions.values())select.add(new Option(v.label,v.id));
 function show(id){
  const v=versions.get(id)||versions.get(registry.default);
  select.value=v.id;frame.src=v.viewer;frame.title=v.label;note.textContent=v.note;
  const url=new URL(location.href);url.searchParams.set('version',v.id);history.replaceState(null,'',url);
  try{localStorage.setItem('tmt-design-version',v.id);}catch{}
 }
 let stored;try{stored=localStorage.getItem('tmt-design-version');}catch{}
 show(new URL(location.href).searchParams.get('version')||stored||registry.default);
 select.disabled=false;select.addEventListener('change',()=>show(select.value));
}catch(error){note.textContent=`Cannot load design versions: ${error.message}`;}
