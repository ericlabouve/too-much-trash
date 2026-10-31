export function installFramePen(view) {
  const bar=document.createElement('div');
  bar.style.cssText='padding:10px 26px;background:#e6eeee;display:flex;gap:12px;align-items:center;flex-wrap:wrap';
  bar.innerHTML='<button id="freeze-pen">Freeze & draw</button><label>Pen color <input aria-label="Pen color" type="color" value="#e83232"></label><label>Pen width <input aria-label="Pen width" type="range" min="0.5" max="16" step="0.5" value="4"></label><button id="pen-undo" disabled>Undo stroke</button><button id="pen-clear" disabled>Clear drawing</button><button id="pen-save" disabled>Save annotated PNG</button><span id="pen-help" role="status">Position the model, then freeze to draw anywhere.</span>';
  view.before(bar); view.style.position='relative';
  const canvas=document.createElement('canvas');canvas.setAttribute('aria-label','Frozen frame drawing canvas');canvas.style.cssText='position:absolute;inset:0;width:100%;height:100%;display:none;touch-action:none;cursor:crosshair;z-index:10';view.append(canvas);
  const ctx=canvas.getContext('2d'),base=document.createElement('canvas');
  let frozen=false,strokes=[],active=null,disabled=[];
  const toggle=bar.querySelector('#freeze-pen'),help=bar.querySelector('#pen-help');
  const undo=bar.querySelector('#pen-undo'),clear=bar.querySelector('#pen-clear'),save=bar.querySelector('#pen-save');
  function redraw(){ctx.clearRect(0,0,canvas.width,canvas.height);ctx.drawImage(base,0,0);for(const s of strokes){ctx.strokeStyle=s.color;ctx.fillStyle=s.color;ctx.lineWidth=s.width;ctx.lineJoin=ctx.lineCap='round';ctx.beginPath();s.points.forEach(([x,y],i)=>i?ctx.lineTo(x,y):ctx.moveTo(x,y));ctx.stroke();if(s.points.length===1){ctx.beginPath();ctx.arc(...s.points[0],s.width/2,0,Math.PI*2);ctx.fill();}}undo.disabled=clear.disabled=!frozen||!strokes.length;}
  toggle.onclick=()=>{if(!frozen){const source=view.querySelector('canvas:not([aria-label])');if(!source)return;requestAnimationFrame(()=>{canvas.width=base.width=source.width;canvas.height=base.height=source.height;base.getContext('2d').drawImage(source,0,0);strokes=[];frozen=true;window.annotationFrozen=true;window.dispatchEvent(new CustomEvent("frame-pen-state",{detail:true}));disabled=[...document.querySelectorAll('header button,header input')].map(e=>[e,e.disabled]);disabled.forEach(([e])=>e.disabled=true);canvas.style.display='block';toggle.textContent='Resume 3D';save.disabled=false;help.textContent='Frame frozen. Draw on the model or empty space. Resume clears this drawing.';redraw();});}else{frozen=false;window.annotationFrozen=false;window.dispatchEvent(new CustomEvent("frame-pen-state",{detail:false}));canvas.style.display='none';disabled.forEach(([e,d])=>e.disabled=d);strokes=[];active=null;toggle.textContent='Freeze & draw';save.disabled=undo.disabled=clear.disabled=true;help.textContent='Position the model, then freeze to draw anywhere.';}};
  function point(e){const r=canvas.getBoundingClientRect();return[(e.clientX-r.left)*canvas.width/r.width,(e.clientY-r.top)*canvas.height/r.height];}
  canvas.onpointerdown=e=>{if(e.button!==0)return;e.preventDefault();canvas.setPointerCapture(e.pointerId);active={color:bar.querySelector('[type=color]').value,width:Number(bar.querySelector('[type=range]').value)*canvas.width/canvas.clientWidth,points:[point(e)]};strokes.push(active);redraw();};
  canvas.onpointermove=e=>{if(!active)return;active.points.push(point(e));redraw();};
  canvas.onpointerup=canvas.onpointercancel=()=>{active=null;};
  undo.onclick=()=>{strokes.pop();redraw();};clear.onclick=()=>{strokes=[];redraw();};
  save.onclick=()=>{const a=document.createElement('a');a.download='actuator-annotation.png';a.href=canvas.toDataURL('image/png');a.click();};
}
