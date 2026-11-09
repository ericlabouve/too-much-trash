import * as THREE from 'three';
import {OrbitControls} from 'three/addons/controls/OrbitControls.js';
import {STLLoader} from 'three/addons/loaders/STLLoader.js';
import {installViewCube} from '../../view_cube.js';
import {installFramePen} from '../v3/review/concepts/braced-tail-b/frame-pen.js';
import {installSurfacePen} from '../v3/review/concepts/braced-tail-b/surface-pen.js';

const canvas = document.querySelector('#liner-preview');
const stage = document.querySelector('#liner-stage');
const status = document.querySelector('#preview-status');
const separation = document.querySelector('#separation');
const showShaft = document.querySelector('#show-shaft');
const showContext = document.querySelector('#show-context');
const reset = document.querySelector('#reset-view');
const guideView = document.querySelector('#guide-view');

async function showPreview() {
  const renderer = new THREE.WebGLRenderer({canvas, antialias: true, preserveDrawingBuffer: true});
  renderer.setPixelRatio(Math.min(devicePixelRatio, 2));
  renderer.setClearColor(0xf3f4f2);
  const scene = new THREE.Scene();
  scene.add(new THREE.HemisphereLight(0xffffff, 0x687985, 2));
  const light = new THREE.DirectionalLight(0xffffff, 2);
  light.position.set(85, -120, 160);
  scene.add(light);

  const camera = new THREE.PerspectiveCamera(37, 1, 0.1, 1000);
  camera.up.set(0, 0, 1);
  const controls = new OrbitControls(camera, canvas);
  const loader = new STLLoader();
  const names = ['cap', 'jaw', 'cap-liner', 'jaw-liner', 'shaft'];
  const [cap, jaw, capLiner, jawLiner, shaft] = await Promise.all(
    names.map(name => loader.loadAsync(new URL(`./preview/${name}.stl`, import.meta.url).href))
  );

  const rigid = new THREE.MeshStandardMaterial({color: 0xe68b37});
  const soft = new THREE.MeshStandardMaterial({color: 0x16aebd});
  const capMesh = new THREE.Mesh(cap, rigid);
  const jawMesh = new THREE.Mesh(jaw, rigid);
  const capPad = new THREE.Mesh(capLiner, soft);
  const jawPad = new THREE.Mesh(jawLiner, soft);
  const shaftMesh = new THREE.Mesh(shaft, new THREE.MeshStandardMaterial({color: 0xa4b3bb}));
  const pull = new THREE.ArrowHelper(new THREE.Vector3(0, 0, -1),
    new THREE.Vector3(0, -21, -29), 37, 0x7544a0, 7, 4);
  scene.add(capMesh, jawMesh, capPad, jawPad, shaftMesh, pull);

  const context = await fetch(new URL('./preview/context.json', import.meta.url)).then(response => response.json());
  const contextMeshes = {};
  await Promise.all(context.map(async ({name, color}) => {
    const geometry = await loader.loadAsync(new URL('./preview/' + name + '.stl', import.meta.url).href);
    const mesh = new THREE.Mesh(geometry, new THREE.MeshStandardMaterial({color}));
    contextMeshes[name] = mesh;
    scene.add(mesh);
  }));

  const cube = installViewCube({canvas, camera, controls, clickStepDegrees: 90});
  const poseControls = [separation, showShaft, showContext, reset, guideView];
  installSurfacePen(stage, () => cube.camera, controls, {
    cap: capMesh, jaw: jawMesh, capPad, jawPad, ...contextMeshes,
  });
  installFramePen(stage, {
    sourceCanvas: canvas, controls: poseControls, filename: 'v4-liner-annotation.png',
  });
  window.addEventListener('frame-pen-state', event => {
    stage.querySelector('.view-cube').inert = event.detail;
    if (!event.detail) resizeCanvas();
  });

  function pose() {
    separation.disabled = showContext.checked;
    const spread = showContext.checked ? 0 : Number(separation.value);
    Object.values(contextMeshes).forEach(mesh => { mesh.visible = showContext.checked; });
    pull.visible = !showContext.checked;
    capMesh.position.x = 38 * spread;
    jawMesh.position.x = -38 * spread;
    capPad.position.x = 15 * spread;
    jawPad.position.x = -15 * spread;
    shaftMesh.visible = showShaft.checked;
  }

  function resetView() {
    cube.perspective();
    camera.up.set(0, 0, 1);
    camera.position.set(160, -260, 185);
    controls.target.set(-25, 0, 13);
    controls.update();
  }

  separation.addEventListener('input', pose);
  showShaft.addEventListener('change', pose);
  showContext.addEventListener('change', pose);
  reset.addEventListener('click', resetView);
  guideView.addEventListener('click', () => {
    showContext.checked = true;
    pose();
    cube.perspective();
    camera.up.set(0, 1, 0);
    camera.position.set(-1, 22.25, -78);
    controls.target.set(-1, 22.25, -25);
    controls.update();
  });
  function resizeCanvas() {
    if (window.annotationFrozen) return;
    const width = canvas.clientWidth;
    const height = canvas.clientHeight;
    if (!width || !height) return;
    renderer.setSize(width, height, false);
    camera.aspect = width / height;
    camera.updateProjectionMatrix();
  }
  new ResizeObserver(resizeCanvas).observe(canvas);
  renderer.setAnimationLoop(() => {
    if (window.annotationFrozen) return;
    cube.tick();
    renderer.render(scene, cube.camera);
  });
  resetView();
  pose();
  for (const control of poseControls) control.disabled = false;
  pose();
  status.textContent = 'Bare-phone spacing · drag to orbit and zoom to inspect the pulley and jaw clearances. Turn off Assembled harness to explode the pads. Bands are schematic.';
}

try {
  await showPreview();
} catch (error) {
  status.textContent = '3D preview unavailable. Build the V4 viewer site to generate its meshes.';
  console.error(error);
}
