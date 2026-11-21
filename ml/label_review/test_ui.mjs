import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import vm from 'node:vm';

function dashboard() {
  const html = fs.readFileSync(new URL('./index.html', import.meta.url), 'utf8');
  const elements = new Map();
  class Element {
    constructor(id) { this.id=id;this.hidden=false;this.value='';this.listeners={};this.dataset={};this.attributes={}; }
    setAttribute(k,v) { this.attributes[k]=v; }
    replaceChildren(...children) { this.children=children;this.value=children[0]?.value||''; }
    addEventListener(event,fn) { this.listeners[event]=fn; }
    showModal() { this.open=true; }
    close() { this.open=false; }
    pause() {} load() {} removeAttribute() {}
  }
  for (const [,id] of html.matchAll(/id="([^"]+)"/g)) elements.set(id,new Element(id));
  elements.get('workers').value='2';elements.get('filter').value='all';elements.get('scope').value='all';elements.get('sample-limit').value='10';
  const state = {job:null,requests:[], data:{dataset:'fixture',path:'/fixture',title:'Fixture',source:'Fixture',clips:[],decisions:{}},
    options:{dataset:'fixture',selection:{eligible:3,total:5,human_reviewed:1},models:[{id:'vision',name:'Vision',efforts:['low','high'],default_effort:'low'}],default_model:'vision',default_effort:'high'}};
  const document={ getElementById:id=>elements.get(id), createElement:()=>new Element(), querySelector:()=>[...elements.values()].find(x=>x.open) };
  const context=vm.createContext({document,window:{addEventListener(){}},setInterval(){},alert(){throw Error('unexpected alert');},
    fetch:async(path,request)=>{
      state.requests.push([path,request]);
      let body;
      if(path==='/data')body={...state.data,job:state.job};
      else if(path==='/datasets')body=[];
      else if(path==='/prediction-options')body=state.options;
      else if(path==='/prediction-review') {const r=state.review=JSON.parse(request.body);state.data.decisions[r.clip]={prediction:r.prediction,decision:r.decision,...(r.corrected_label?{corrected_label:r.corrected_label}:{})};body={...state.data.decisions};}
      else if(path==='/jobs/start') {state.started=JSON.parse(request.body);body=state.job={state:'running',completed:0,failed:0,total:3,workers:2,root:'/fixture'};}
      else throw Error('unexpected path '+path);
      return {ok:true,json:async()=>body};
    }});
  vm.runInContext(html.split('<script type="module">')[1].split('</script>')[0],context);
  return {elements,state,context};
}
const settle=()=>new Promise(resolve=>setImmediate(resolve));

test('dialog exposes model/thinking and sends selected settings',async()=>{
  const {elements:e,state}=dashboard();await settle();
  await e.get('run').onclick();
  assert.equal(e.get('prediction-dialog').open,true);
  assert.equal(e.get('selection').textContent,'3 eligible / 5 samples · 1 human-reviewed');
  assert.equal(e.get('model').value,'vision');assert.equal(e.get('effort').value,'high');
  e.get('effort').value='low';e.get('workers').value='3';
  await e.get('start-job').onclick();
  assert.deepEqual(state.started,{dataset:'fixture',workers:3,model:'vision',effort:'low',limit:null});
  assert.equal(e.get('start-job').disabled,true);
});

test('closing via backdrop or escape leaves shared progress on dashboard',async()=>{
  const {elements:e,context,state}=dashboard();await settle();
  await e.get('run').onclick();
  state.job={state:'running',completed:1,failed:1,total:3,workers:2,root:'/fixture'};
  vm.runInContext('paintJob('+JSON.stringify(state.job)+')',context);
  e.get('prediction-dialog').listeners.click({target:e.get('prediction-dialog')});
  assert.equal(e.get('prediction-dialog').open,false);
  assert.equal(e.get('dashboard-job').hidden,false);
  assert.equal(e.get('dashboard-progress').value,2);
  assert.equal(e.get('dashboard-progress').max,3);
  assert.match(e.get('job').textContent,/1 \/ 3 predicted · 1 failed/);
  await e.get('job-details').onclick();
  assert.equal(e.get('dialog-progress').value,2);
  e.get('prediction-dialog').close(); // Native dialog handles Escape; closing never cancels the run.
  assert.equal(e.get('dashboard-job').hidden,false);
  assert.equal(state.requests.filter(([path])=>path==='/jobs/cancel').length,0);
});

test('scope selects all eligible or a bounded number of remaining samples',async()=>{
  const {elements:e,state}=dashboard();await settle();await e.get('run').onclick();
  assert.equal(e.get('limit-field').hidden,true);
  assert.equal(e.get('run-count').textContent,'Will run 3 of 3 eligible samples, in clip order.');
  e.get('scope').value='limit';e.get('scope').onchange();e.get('sample-limit').value='2';e.get('sample-limit').oninput();
  assert.equal(e.get('limit-field').hidden,false);
  assert.equal(e.get('run-count').textContent,'Will run 2 of 3 eligible samples, in clip order.');
  await e.get('start-job').onclick();assert.equal(state.started.limit,2);
});

test('invalid sample limit never starts a run',async()=>{
  const {elements:e,state}=dashboard();await settle();await e.get('run').onclick();
  e.get('scope').value='limit';e.get('sample-limit').value='0';
  await e.get('start-job').onclick();assert.equal(state.started,undefined);
  assert.match(e.get('prediction-error').textContent,/positive whole number/);
});

test('review-status filters include unresolved history and exclude resolved human labels',async()=>{
 const {elements:e,state,context}=dashboard();await settle();
 state.data.clips=[
  {id:'high-binary',prediction:'confirmed',confidence:'high'},
  {id:'high-uncertain',prediction:'uncertain',confidence:'high'},
  {id:'medium',prediction:'confirmed',confidence:'medium'},
  {id:'low',prediction:'not_deposited',confidence:'low'},
  {id:'unknown-confidence',prediction:'confirmed'},
  {id:'historic-human',prediction:'uncertain',confidence:'low',human_evaluated:true},
  {id:'current-human',prediction:'uncertain',confidence:'medium'},
  {id:'pending',prediction:null}];
 state.data.decisions={'current-human':{prediction:'uncertain',decision:'deny',corrected_label:'confirmed'}};
 await e.get('refresh').onclick();
 const ids=()=>Array.from(vm.runInContext('clips.map(c=>c.id)',context));
 e.get('filter').value='needs-human';e.get('filter').onchange();
 assert.deepEqual(ids(),['high-uncertain','medium','low','unknown-confidence','historic-human','pending']);
 e.get('filter').value='ai';e.get('filter').onchange();assert.equal(ids().length,7);assert.ok(ids().includes('high-uncertain'));
 e.get('filter').value='human';e.get('filter').onchange();assert.deepEqual(ids(),['historic-human','current-human']);
 e.get('filter').value='all';e.get('filter').onchange();assert.equal(ids().length,8);
});

test('uncertain predictions show two direct outcome buttons and save binary human labels',async()=>{
 for(const [label,button] of [['confirmed','approve'],['not_deposited','deny']]) {
  const {elements:e,state}=dashboard();await settle();
  state.data.clips=[{id:'uncertain-clip',prediction:'uncertain',confidence:'medium',kind:'video',start:2}];await e.get('refresh').onclick();
  assert.equal(e.get('replay').hidden,false);
  assert.equal(e.get('approve').textContent,'Deposited');assert.equal(e.get('deny').textContent,'Not deposited');
  await e.get(button).onclick();
  assert.equal(state.review.prediction,'uncertain');assert.equal(state.review.corrected_label,label);
  assert.equal(state.review.decision,'deny');assert.equal(state.data.clips[0].prediction,'uncertain');
  assert.equal(e.has('correction-dialog'),false);
  assert.match(e.get('human-label').textContent,/Your label:/);
 }
});

test('replay uses the event-relative start on a high-confidence sample',async()=>{
 const {elements:e,state}=dashboard();await settle();
 state.data.clips=[{id:'known',prediction:'confirmed',confidence:'high',kind:'video',start:2}];await e.get('refresh').onclick();
 e.get('video').readyState=1;e.get('video').duration=8;e.get('video').play=()=>Promise.resolve();
 e.get('video').onloadedmetadata();assert.equal(e.get('video').currentTime,2);
 e.get('video').currentTime=7;e.get('replay').onclick();assert.equal(e.get('video').currentTime,2);
});

test('saving a human label removes the sample from Need human review immediately',async()=>{
 const {elements:e,state,context}=dashboard();await settle();
 state.data.clips=[{id:'one',prediction:'uncertain',confidence:'high'},{id:'two',prediction:'uncertain',confidence:'medium'}];
 await e.get('refresh').onclick();e.get('filter').value='needs-human';e.get('filter').onchange();
 await e.get('approve').onclick();
 assert.equal(state.review.clip,'one');assert.equal(state.review.corrected_label,'confirmed');
 assert.deepEqual(Array.from(vm.runInContext('clips.map(c=>c.id)',context)),['two']);
 assert.equal(e.get('position').textContent,'two · 1/1');
});

test('all predicted clips have direct binary actions regardless of confidence or review state',async()=>{
 for(const sample of [
  {id:'clip-001',prediction:'confirmed',confidence:'high'},
  {id:'high-negative',prediction:'not_deposited',confidence:'high'},
  {id:'human-reviewed-high',prediction:'confirmed',confidence:'high',human_evaluated:true},
  {id:'clip-043',prediction:'not_deposited',confidence:'medium'},
  {id:'medium-positive',prediction:'confirmed',confidence:'medium'},
  {id:'low-negative',prediction:'not_deposited',confidence:'low'},
  {id:'unknown-confidence',prediction:'confirmed'}]) {
  for(const [label,button] of [['confirmed','approve'],['not_deposited','deny']]) {
   const {elements:e,state}=dashboard();await settle();state.data.clips=[{...sample,kind:'video',start:2}];await e.get('refresh').onclick();
   assert.equal(e.get('approve').textContent,'Deposited');assert.equal(e.get('deny').textContent,'Not deposited');assert.equal(e.get('replay').hidden,false);
   await e.get(button).onclick();
   assert.equal(state.review.corrected_label,label);assert.equal(state.review.prediction,sample.prediction);
   assert.equal(state.review.decision,label===sample.prediction?'approve':'deny');
   assert.equal(e.has('correction-dialog'),false);
   assert.equal(state.data.clips[0].prediction,sample.prediction);
  }
 }
});

test('viewer defaults to Need human review and falls back to All samples after the last label',async()=>{
 const {elements:e,state,context}=dashboard();await settle();
 state.data.clips=[{id:'high',prediction:'confirmed',confidence:'high'},{id:'needs',prediction:'not_deposited',confidence:'medium'}];
 await vm.runInContext('refresh(false)',context);
 assert.equal(e.get('filter').value,'needs-human');assert.equal(e.get('position').textContent,'needs · 1/1');
 await e.get('deny').onclick();
 assert.equal(state.review.corrected_label,'not_deposited');
 assert.equal(e.get('filter').value,'all');assert.equal(vm.runInContext('clips.length',context),2);
 await vm.runInContext('refresh(false)',context);assert.equal(e.get('filter').value,'all');
});

test('refresh preserves an explicitly selected filter while a review queue exists',async()=>{
 const {elements:e,state,context}=dashboard();await settle();
 state.data.clips=[{id:'one',prediction:'uncertain',confidence:'high'}];await vm.runInContext('refresh(false)',context);
 assert.equal(e.get('filter').value,'needs-human');
 e.get('filter').value='ai';e.get('filter').onchange();await e.get('refresh').onclick();
 assert.equal(e.get('filter').value,'ai');
});

test('dataset storage badge follows the loaded dataset on refresh',async()=>{
 const {elements:e,state}=dashboard();await settle();
 state.data.clips=[{id:'fixture',prediction:'confirmed',confidence:'high'}];
 for(const [kind,label,color,readOnly] of [['working','Working copy','badge-success',false],['reference','Frozen Reference','badge-warning',true],['golden','Golden set','badge-error',false],['local','Local dataset','badge-neutral',false]]) {
  state.data.storage={kind,label,read_only:readOnly};await e.get('refresh').onclick();
  assert.equal(e.get('dataset-storage').textContent,label);
  assert.match(e.get('dataset-storage').className,new RegExp(color));
  assert.equal(e.get('run').disabled,readOnly);
  assert.equal(e.get('approve').disabled,readOnly);
  if(readOnly) {await e.get('approve').onclick();assert.equal(state.review,undefined);}
 }

});

test('header counts humans and saved predictions across the full dataset',async()=>{
 const {elements:e,state}=dashboard();await settle();
 state.data.source='Codex deposit review · private-run-id';
 state.data.clips=[
  {id:'a',prediction:'confirmed',confidence:'high'},
  {id:'b',prediction:'uncertain',human_evaluated:true,human_review:{decision:'deny'}},
  {id:'c',prediction:'not_deposited'},
  {id:'d',prediction:null}];
 state.data.decisions={a:{prediction:'confirmed',decision:'deny',corrected_label:'not_deposited'}};
 await e.get('refresh').onclick();
 const expected='Human reviewed: 2/4 · AI reviewed: 3/4';
 assert.equal(e.get('review-counts').textContent,expected);
 assert.equal(e.get('label-counts').textContent,'0 deposited · 2 not deposited · 2 unresolved');
 e.get('filter').value='human';e.get('filter').onchange();
 assert.equal(e.get('review-counts').textContent,expected);
 assert.equal(e.get('label-counts').textContent,'0 deposited · 2 not deposited · 2 unresolved');
});

test('unresolved human denials remain eligible until explicit outcomes empty and disable the queue',async()=>{
 const {elements:e,state,context}=dashboard();await settle();
 state.data.clips=[
  {id:'legacy-denial',prediction:'not_deposited',confidence:'high',human_evaluated:true,human_review:{prediction:'not_deposited',decision:'deny'}},
  {id:'approved',prediction:'confirmed',confidence:'low',human_evaluated:true,human_review:{prediction:'confirmed',decision:'approve'}},
  {id:'corrected',prediction:'confirmed',confidence:'low',human_evaluated:true,human_review:{prediction:'confirmed',decision:'deny',corrected_label:'not_deposited'}}];
 state.data.decisions={'legacy-denial':{prediction:'not_deposited',decision:'deny'}};
 await vm.runInContext('refresh(false)',context);
 assert.equal(e.get('filter').value,'needs-human');
 assert.equal(e.get('needs-human-option').disabled,false);
 assert.deepEqual(Array.from(vm.runInContext('clips.map(c=>c.id)',context)),['legacy-denial']);
 await e.get('approve').onclick();
 assert.equal(state.review.corrected_label,'confirmed');
 assert.equal(e.get('filter').value,'all');
 assert.equal(e.get('needs-human-option').disabled,true);
 state.data.clips.push({id:'new-uncertain',prediction:'uncertain',confidence:'high'});
 await e.get('refresh').onclick();
 assert.equal(e.get('needs-human-option').disabled,false);
 e.get('filter').value='needs-human';e.get('filter').onchange();
 assert.deepEqual(Array.from(vm.runInContext('clips.map(c=>c.id)',context)),['new-uncertain']);
});
