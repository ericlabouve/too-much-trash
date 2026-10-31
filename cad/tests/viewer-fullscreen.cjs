const assert=require('node:assert/strict');
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
(async()=>{
 const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH,args:['--use-angle=swiftshader']});
 try{
  const page=await browser.newPage({viewport:{width:1440,height:1000}}),errors=[];
  page.on('pageerror',e=>errors.push(e.message));
  await page.goto((process.env.CAD_VIEWER_URL||'http://127.0.0.1:8767')+'/versions/v3/viewer.html?sample=bare&side=near');
  await page.locator('#view[data-ready=true]').waitFor({timeout:120000});
  async function layout(){return page.evaluate(()=>{
   const s=document.querySelector('#stage').getBoundingClientRect(),a=document.querySelector('main>aside').getBoundingClientRect();
   return {width:s.width,viewport:innerWidth,below:a.top>=s.bottom-1,overflow:document.documentElement.scrollWidth>innerWidth};
  });}
  let l=await layout();assert(l.below&&!l.overflow);assert.equal(l.width,l.viewport);
  const button=page.locator('#viewer-fullscreen');await button.click();
  await page.waitForFunction(()=>document.fullscreenElement?.id==='stage');
  await page.waitForFunction(()=>document.querySelector('#view').clientHeight>innerHeight-100);
  await page.waitForTimeout(800); // Let WebGL repaint after the fullscreen resize.
  await page.screenshot({path:'/private/tmp/v3-fullscreen.png'});
  assert.equal(await button.getAttribute('aria-pressed'),'true');
  await button.click();await page.waitForFunction(()=>!document.fullscreenElement);
  await page.waitForFunction(()=>document.querySelector('#viewer-fullscreen').getAttribute('aria-pressed')==='false');
  // Embedded browsers may disallow native full screen; test panel fallback.
  await page.evaluate(()=>Object.defineProperty(document,'fullscreenEnabled',{configurable:true,value:false}));
  await button.click();await page.waitForFunction(()=>document.querySelector('#stage').classList.contains('is-expanded'));
  await page.keyboard.press('Escape');await page.waitForFunction(()=>!document.querySelector('#stage').classList.contains('is-expanded'));
  assert.equal(await button.getAttribute('aria-pressed'),'false');
  await page.locator('#view').scrollIntoViewIfNeeded();
  await page.screenshot({path:'/private/tmp/v3-wide-viewer.png'});
  await page.setViewportSize({width:390,height:844});
  l=await layout();assert(l.below&&!l.overflow);assert.equal(l.width,l.viewport);
  await button.click();await page.waitForFunction(()=>document.querySelector('#stage').classList.contains('is-expanded'));
  await button.click();await page.waitForFunction(()=>!document.querySelector('#stage').classList.contains('is-expanded'));
  assert.deepEqual(errors,[]);console.log(JSON.stringify({passed:true,nativeFullscreen:true,fallback:true,mobile:true,errors}));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1)});
