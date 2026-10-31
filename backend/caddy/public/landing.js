// Reveal sections as they enter view. Content remains visible without JavaScript.
if ('IntersectionObserver' in window && !window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
  document.documentElement.classList.add('js');
  const observer = new IntersectionObserver((entries) => {
    for (const entry of entries) {
      if (!entry.isIntersecting) continue;
      entry.target.classList.add('visible');
      observer.unobserve(entry.target);
    }
  }, { rootMargin: '0px 0px -7% 0px', threshold: 0.08 });
  document.querySelectorAll('.reveal').forEach((element) => observer.observe(element));
}

// Abstract capture geometry, not a live point cloud or measured dataset.
const canvas = document.querySelector('.capture-cloud');
if (canvas) {
  const context = canvas.getContext('2d');
  const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
  const hero = canvas.closest('.hero');
  const pointCount = window.innerWidth < 650 ? 300 : 550;
  const points = Array.from({ length: pointCount }, (_, index) => {
    const angle = index * 2.399963;
    const y = 1 - 2 * (index + 0.5) / pointCount;
    const radius = Math.sqrt(1 - y * y);
    return { x: Math.cos(angle) * radius, y, z: Math.sin(angle) * radius };
  });
  let width = 0;
  let height = 0;
  let frame = 0;
  let visible = true;
  let pointer = 0;
  const buckets = Array.from({ length: 8 }, () => []);
  const draw = (time = 0) => {
    if (!context) return;
    context.clearRect(0, 0, width, height);
    const rotation = reducedMotion.matches ? 0.3 : time * 0.0002 + pointer;
    const cosine = Math.cos(rotation);
    const sine = Math.sin(rotation);
    const size = Math.min(width * 0.35, 310);
    const centerX = width * 0.77;
    const centerY = height * 0.47;
    for (const bucket of buckets) bucket.length = 0;
    for (const point of points) {
      const x = point.x * cosine - point.z * sine;
      const z = point.x * sine + point.z * cosine;
      const perspective = 2.8 / (2.8 - z);
      const px = centerX + x * size * perspective;
      const py = centerY + point.y * size * perspective;
      // Keep the text-facing side of the visualization quiet.
      const fade = Math.max(0.06, Math.min(1, (px / width - 0.25) * 2));
      const alpha = (z + 1.4) * 0.28 * fade;
      buckets[Math.min(7, Math.floor(alpha * 12))].push(px, py, (z + 1.5) * 0.75);
    }
    // Eight batched fills replace hundreds of individual fills and color changes.
    for (let index = 0; index < buckets.length; index++) {
      context.fillStyle = `rgba(157,193,255,${(index + 0.5) / 12})`;
      context.beginPath();
      const bucket = buckets[index];
      for (let offset = 0; offset < bucket.length; offset += 3) {
        const radius = bucket[offset + 2];
        context.moveTo(bucket[offset] + radius, bucket[offset + 1]);
        context.arc(bucket[offset], bucket[offset + 1], radius, 0, Math.PI * 2);
      }
      context.fill();
    }
  };
  const animate = (time) => {
    draw(time);
    frame = visible && !document.hidden && !reducedMotion.matches ? requestAnimationFrame(animate) : 0;
  };
  const start = () => {
    cancelAnimationFrame(frame);
    frame = 0;
    if (visible && !document.hidden && !reducedMotion.matches) frame = requestAnimationFrame(animate);
    else draw();
  };
  new ResizeObserver(() => {
    width = hero.clientWidth;
    height = hero.clientHeight;
    const scale = Math.min(window.devicePixelRatio || 1, 1.25);
    canvas.width = width * scale;
    canvas.height = height * scale;
    context?.setTransform(scale, 0, 0, scale, 0, 0);
    start();
  }).observe(hero);
  hero.addEventListener('pointermove', (event) => {
    if (!reducedMotion.matches) pointer = ((event.clientX - hero.getBoundingClientRect().left) / width - 0.5) * 0.4;
  }, { passive: true });
  hero.addEventListener('pointerleave', () => { pointer = 0; });
  if ('IntersectionObserver' in window) new IntersectionObserver(([entry]) => {
    visible = entry.isIntersecting;
    start();
  }).observe(hero);
  document.addEventListener('visibilitychange', start);
  reducedMotion.addEventListener('change', start);
}

// Pause decorative CSS motion outside the viewport, too.
if ('IntersectionObserver' in window) {
  const motionObserver = new IntersectionObserver((entries) => {
    for (const entry of entries) entry.target.classList.toggle('motion-paused', !entry.isIntersecting);
  });
  document.querySelectorAll('.field, .process-art').forEach(element => motionObserver.observe(element));
}
