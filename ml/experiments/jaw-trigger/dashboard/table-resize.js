const candidatePanel = document.querySelector('.candidate-panel');
const candidateViewport = candidatePanel.querySelector('.table-wrap');
for (const handle of candidatePanel.querySelectorAll('.resize-handle')) {
  const side = handle.dataset.corner;
  let drag;
  handle.addEventListener('pointerdown', (event) => {
    if (event.button !== 0) return;
    const rect = candidatePanel.getBoundingClientRect();
    drag = { x: event.clientX, y: event.clientY, width: rect.width, height: rect.height };
    handle.setPointerCapture(event.pointerId);
    event.preventDefault();
  });
  function resize(width, height) {
    // Keep the opposite edge anchored while staying within the viewport.
    const rect = candidatePanel.getBoundingClientRect();
    const available = side === 'left' ? rect.right - 12 : window.innerWidth - rect.left - 12;
    const nextWidth = Math.max(Math.min(360, available), Math.min(width, available));
    if (side === 'left') {
      candidatePanel.style.marginLeft = `${(parseFloat(candidatePanel.style.marginLeft) || 0) + rect.width - nextWidth}px`;
    }
    candidatePanel.style.width = `${nextWidth}px`;
    candidateViewport.style.height = `${Math.max(120, height)}px`;
    candidateViewport.style.maxHeight = 'none';
  }
  handle.addEventListener('pointermove', (event) => {
    if (!drag) return;
    resize(drag.width + (event.clientX - drag.x) * (side === 'left' ? -1 : 1),
      drag.height + event.clientY - drag.y);
  });
  handle.addEventListener('lostpointercapture', () => { drag = undefined; });
  handle.addEventListener('keydown', (event) => {
    if (!['ArrowLeft', 'ArrowRight', 'ArrowUp', 'ArrowDown'].includes(event.key)) return;
    const rect = candidatePanel.getBoundingClientRect();
    const dx = event.key === 'ArrowRight' ? 24 : event.key === 'ArrowLeft' ? -24 : 0;
    const dy = event.key === 'ArrowDown' ? 24 : event.key === 'ArrowUp' ? -24 : 0;
    resize(rect.width + dx * (side === 'left' ? -1 : 1), rect.height + dy);
    event.preventDefault();
  });
  handle.addEventListener('pointerup', (event) => {
    handle.releasePointerCapture(event.pointerId);
  });
}

const candidateTable = candidatePanel.querySelector('table');
const columns = [...candidateTable.querySelectorAll('col')];
for (const [index, header] of [...candidateTable.querySelectorAll('thead th')].entries()) {
  const grip = document.createElement('button');
  grip.type = 'button';
  grip.className = 'column-resize';
  grip.setAttribute('aria-label', `Resize ${header.textContent} column`);
  grip.title = 'Drag to change column width. Left and right arrows also resize.';
  header.append(grip);
  let drag;
  function applyWidths(widths) {
    columns.forEach((column, i) => { column.style.width = `${widths[i]}px`; });
    candidateTable.style.width = `${widths.reduce((total, width) => total + width, 0)}px`;
  }
  function currentWidths() {
    return [...candidateTable.querySelectorAll('thead th')].map(cell => cell.getBoundingClientRect().width);
  }
  grip.addEventListener('pointerdown', event => {
    if (event.button !== 0) return;
    drag = { x: event.clientX, widths: currentWidths() };
    grip.setPointerCapture(event.pointerId);
    event.preventDefault();
  });
  grip.addEventListener('pointermove', event => {
    if (!drag) return;
    const widths = [...drag.widths];
    widths[index] = Math.max(64, widths[index] + event.clientX - drag.x);
    applyWidths(widths);
  });
  grip.addEventListener('pointerup', event => { grip.releasePointerCapture(event.pointerId); });
  grip.addEventListener('lostpointercapture', () => { drag = undefined; });
  grip.addEventListener('keydown', event => {
    if (!['ArrowLeft', 'ArrowRight'].includes(event.key)) return;
    const widths = currentWidths();
    widths[index] = Math.max(64, widths[index] + (event.key === 'ArrowRight' ? 16 : -16));
    applyWidths(widths);
    event.preventDefault();
  });
}
