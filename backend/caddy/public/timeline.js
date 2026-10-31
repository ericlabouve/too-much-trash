(() => {
  const trail = document.querySelector('.trail');
  if (!trail) return;
  const nodes = [...trail.querySelectorAll('.trail-node')];
  const details = [...trail.querySelectorAll('.trail-detail article')];
  function select(node) {
    trail.dataset.active = node.dataset.node;
    nodes.forEach(item => item.setAttribute('aria-pressed', String(item === node)));
    details.forEach(item => { item.hidden = item.id !== node.getAttribute('aria-controls'); });
  }
  nodes.forEach((node, index) => {
    node.addEventListener('pointerenter', event => {
      if (event.pointerType !== 'touch') select(node);
    });
    node.addEventListener('focus', () => select(node));
    node.addEventListener('click', () => select(node));
    node.addEventListener('keydown', event => {
      const order = [0, 1, 2, 3, 4, 5];
      const position = order.indexOf(index);
      let next;
      if (event.key === 'ArrowRight') next = order[(position + 1) % order.length];
      if (event.key === 'ArrowLeft') next = order[(position + order.length - 1) % order.length];
      if (event.key === 'Home') next = 0;
      if (event.key === 'End') next = 5;
      if (next !== undefined) {
        event.preventDefault();
        nodes[next].focus();
      }
    });
  });
  select(nodes[0]);
})();
