const assert=require('node:assert/strict');
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
(async()=>{
 const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH,args:['--use-angle=swiftshader']});
 try{
  const page=await browser.newPage({viewport:{width:1400,height:1000}}),errors=[];
  page.on('pageerror',e=>errors.push(e.message));
  await page.goto('http://127.0.0.1:8767/versions/v3/viewer.html?sample=bare&side=near&ui=bom-controls');
  const view=page.locator('#view');await page.locator('#view[data-ready=true]').waitFor({timeout:120000});
  await page.locator('[data-view=bom]').click();
  const toggle=page.locator('#bom-isolate');assert(await toggle.isDisabled());
  await page.locator('tr[data-id=shaft_cap]').click();await toggle.click();
  assert.equal(await view.getAttribute('data-bom-visible'),'["shaft_cap"]');
  await page.locator('tr[data-id=carrier]').click();
  assert.equal(await view.getAttribute('data-bom-visible'),'["carrier"]');
  await toggle.click();assert.equal(JSON.parse(await view.getAttribute('data-bom-visible')).length,16);
  await toggle.click();await page.locator('#viewer-fullscreen').click();assert(await toggle.isVisible());
  const cube=page.locator('#stage .view-cube canvas'),right=page.getByRole('button',{name:'Rotate right',exact:true}).first();
  const direction=async()=>JSON.parse('['+await cube.getAttribute('data-direction')+']');
  await cube.press('Home');await page.waitForTimeout(300);const start=await direction();
  await right.click();await page.waitForTimeout(300);const end=await direction();
  assert(Math.abs(start.reduce((n,v,i)=>n+v*end[i],0))<.001,'click must turn 90 degrees');
  for(let i=0;i<3;i++)await right.click();await page.waitForTimeout(300);
  const full=await direction();assert(start.reduce((n,v,i)=>n+v*full[i],0)>.9999,'four turns restore view');
  const box=await right.boundingBox();await page.mouse.move(box.x+box.width/2,box.y+box.height/2);await page.mouse.down();
  await page.mouse.move(box.x+box.width/2+30,box.y+box.height/2,{steps:8});await page.waitForTimeout(200);const drag=await direction();
  await page.mouse.up();await page.waitForTimeout(200);const released=await direction();
  assert(drag.reduce((n,v,i)=>n+v*released[i],0)>.9999,'drag release must not add click turn');
  await page.locator('#viewer-fullscreen').click();await page.locator('[data-view=phone]').click();assert(!(await toggle.isVisible()));
  await page.locator('[data-view=bom]').click();assert.equal(await view.getAttribute('data-bom-isolated'),'false');assert(await toggle.isDisabled());
  assert.deepEqual(errors,[]);console.log(JSON.stringify({passed:true,errors}));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1;});
