// Recorded losses are training diagnostics, separate from deployment event F1.
function makeCandidateLossCurve(history, candidate, presentation) {
  const iterative = /mlp|temporal state/i.test(presentation?.family ?? '') ||
    /^(temporal47|motion48|motion47)$/.test(candidate?.method ?? '');
  if (!history && !iterative) return null;
  const figure = document.createElement('figure');
  figure.className = 'candidate-loss';
  const caption = document.createElement('figcaption');
  caption.textContent = 'Training & validation loss';
  figure.append(caption);
  if (!history || !candidate || Object.keys(history.candidate ?? {}).length !== Object.keys(candidate).length ||
      Object.keys(candidate).some(key => history.candidate[key] !== candidate[key])) {
    const missing = document.createElement('p');
    missing.textContent = 'Loss history was not saved for this model.';
    figure.append(missing);
    return figure;
  }
  const points = history.points;
  const series = [
    { key: 'train_loss', label: 'Training', color: '#a6e8bc' },
    { key: 'validation_loss', label: 'Validation', color: '#f5b66c' },
  ];
  const finite = value => typeof value === 'number' && Number.isFinite(value);
  const values = points.flatMap(point => series.map(line => point[line.key])).filter(finite);
  if (!points.length || !values.length) return figure;
  const ns = 'http://www.w3.org/2000/svg';
  const svg = document.createElementNS(ns, 'svg');
  svg.setAttribute('viewBox', '0 0 640 240');
  svg.setAttribute('role', 'img');
  svg.setAttribute('aria-label', `${history.metric} by epoch for ${candidateLabel(candidate.name)}`);
  const add = (tag, attrs, text) => {
    const element = document.createElementNS(ns, tag);
    for (const [key, value] of Object.entries(attrs)) element.setAttribute(key, value);
    if (text !== undefined) element.textContent = text;
    svg.append(element); return element;
  };
  const first = points[0].epoch, last = points.at(-1).epoch;
  const maximum = Math.max(...values, 0.000001) * 1.08;
  const x = epoch => first === last ? 340 : 65 + (epoch - first) / (last - first) * 550;
  const y = loss => 194 - loss / maximum * 170;
  for (let index = 0; index <= 4; index++) {
    const value = maximum * index / 4;
    add('line', { x1: 65, x2: 615, y1: y(value), y2: y(value), class: 'loss-grid' });
    add('text', { x: 56, y: y(value) + 4, 'text-anchor': 'end' }, value < .001 && value > 0 ? value.toExponential(1) : value.toFixed(3));
  }
  for (const epoch of [...new Set([first, Math.round((first + last) / 2), last])]) {
    add('text', { x: x(epoch), y: 213, 'text-anchor': 'middle' }, epoch);
  }
  add('text', { x: 340, y: 235, 'text-anchor': 'middle' }, 'Epoch');
  if (Number.isInteger(history.selected_epoch) && history.selected_epoch >= first && history.selected_epoch <= last) {
    add('line', { x1: x(history.selected_epoch), x2: x(history.selected_epoch), y1: 20, y2: 194,
      stroke: '#d5b6ff', 'stroke-width': 2, 'stroke-dasharray': '5 4' });
    add('text', { x: x(history.selected_epoch), y: 14, 'text-anchor': 'middle' }, `Selected epoch ${history.selected_epoch}`);
  }
  const legend = document.createElement('ul');
  legend.className = 'loss-legend';
  for (const line of series) {
    const available = points.filter(point => finite(point[line.key]));
    const item = document.createElement('li');
    item.style.color = line.color;
    item.textContent = `${line.label}${available.length ? '' : ' · not recorded'}`;
    legend.append(item);
    let drawing = '', connected = false;
    for (const point of points) {
      if (!finite(point[line.key])) { connected = false; continue; }
      drawing += `${connected ? 'L' : 'M'}${x(point.epoch)},${y(point[line.key])} `;
      connected = true;
      const dot = add('circle', { cx: x(point.epoch), cy: y(point[line.key]), r: 3, fill: line.color, class: 'loss-point' });
      const title = document.createElementNS(ns, 'title');
      title.textContent = `Epoch ${point.epoch} · ${line.label}: ${point[line.key].toPrecision(5)}`;
      dot.append(title);
    }
    if (drawing) add('path', { d: drawing, fill: 'none', stroke: line.color, 'stroke-width': 2, 'pointer-events': 'none' });
  }
  const metric = document.createElement('p'); metric.textContent = `${history.metric} · lower is better`;
  figure.append(metric, legend, svg);
  if (history.possible_overfitting) {
    const warning = document.createElement('p');
    warning.textContent = 'Possible overfitting: training loss decreased while validation loss increased.';
    figure.append(warning);
  }
  if (history.note) { const note = document.createElement('p'); note.textContent = history.note; figure.append(note); }
  return figure;
}
