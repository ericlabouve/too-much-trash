// Material choices affect BOM recommendations, not geometry or qualification.
export const palette={pla:'#ed9b37',petg:'#159c9c',tpu:'#9557c7',buy:'#82909d',missing:'#d34e4e'};
export function strategy(row,available,optimal=false){
  const [name,,,initial]=row;
  const have=optimal?new Set(['petg','tpu']):new Set(available);
  const rigid=have.has('petg')?'petg':have.has('pla')?'pla':null;
  const title=k=>({pla:'PLA / PLA+',petg:'PETG',tpu:'TPU'}[k]);
  if(name.startsWith('`print/'))return rigid
    ?{key:rigid,text:`Print ${title(rigid)}${rigid==='pla'?' — initial prototype':''}`,ready:true}
    :{key:'missing',text:'PETG needed — obtain filament or this part printed in PETG. TPU cannot replace the rigid structure.',ready:false};
  if(['Side jaw pads','Rear jaw pads','Shaft-contact liners/shims','Soft button-contact cap','Optional trigger saddle'].includes(name))return have.has('tpu')
    ?{key:'tpu',text:`TPU recommended — planned STL, not available yet. For now: ${initial.toLowerCase()}.`,ready:false}
    :{key:'buy',text:initial,ready:true};
  if(name==='Housing route clips/ties'){
    const chosen=rigid||(have.has('tpu')?'tpu':null);
    return {key:chosen||'buy',text:`Purchased removable ties${chosen?`; ${title(chosen)} ${chosen==='tpu'?'retaining loops':'guides'} are a planned replacement (no STL yet)`:''}. Choose one routing-retention option.`,ready:false};
  }
  if(name.startsWith('M4×80'))return {key:'buy',text:`Metal screw with purchased thumb head${rigid?`; optional ${title(rigid)} replacement knob is not yet modeled`:''}. Head counted once.`,ready:true};
  return {key:'buy',text:initial,ready:true};
}
