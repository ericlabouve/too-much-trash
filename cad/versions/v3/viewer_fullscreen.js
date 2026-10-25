// Native full screen where supported; fill the app panel otherwise.
export function installFullscreen(stage,button,onResize){
 const expanded=()=>document.fullscreenElement===stage||stage.classList.contains('is-expanded');
 function sync(){
  const active=expanded();
  button.textContent=active?'⛶ Exit full screen':'⛶ Full screen';
  button.setAttribute('aria-pressed',String(active));
  button.title=active?'Exit full screen (Esc)':'Expand 3D viewer';
  document.body.classList.toggle('viewer-expanded',active);
  requestAnimationFrame(onResize);
 }
 function exitFallback(){stage.classList.remove('is-expanded');sync();button.focus({preventScroll:true});}
 button.addEventListener('click',async()=>{
  if(document.fullscreenElement===stage){await document.exitFullscreen();sync();return;}
  if(stage.classList.contains('is-expanded')){exitFallback();return;}
  try{
   if(!document.fullscreenEnabled||!stage.requestFullscreen)throw new Error('Fullscreen unavailable');
   await stage.requestFullscreen();
  }catch{stage.classList.add('is-expanded');}
  sync();
 });
 document.addEventListener('fullscreenchange',sync);
 document.addEventListener('keydown',e=>{if(e.key==='Escape'&&stage.classList.contains('is-expanded'))exitFallback();});
 sync();
}
