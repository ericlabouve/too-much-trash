const trend = document.querySelector('#leader-trend');
const plot = document.querySelector('#trend-plot');
const scrubber = document.querySelector('#trend-round');
const trendScores = document.querySelector('#trend-scores');
const contextSelector = document.querySelector('#trend-context');
const series = [
  { key: 'fitness', label: 'Fitness' },
  { key: 'jaw', label: 'Validation jaw F1' },
];
let leaderRounds = [];
let leaderContexts = [];
let lastContexts;

function plotElement(tag, attributes, label) {
  const element = document.createElementNS('http://www.w3.org/2000/svg', tag);
  for (const [key, value] of Object.entries(attributes)) element.setAttribute(key, value);
  if (label !== undefined) element.textContent = label;
  return element;
}

function drawLeaderTrend() {
  if (!leaderRounds.length) return;
  const width = Math.max(250, Math.round(plot.clientWidth));
  const height = 180;
  const left = 32;
  const right = width - 18;
  const bottom = height - 26;
  const x = index => leaderRounds.length === 1 ? (left + right) / 2
    : left + (right - left) * index / (leaderRounds.length - 1);
  const y = score => bottom - score * (bottom - 12);
  const selectedIndex = Math.min(Number(scrubber.value), leaderRounds.length - 1);
  const selected = leaderRounds[selectedIndex];
  plot.setAttribute('viewBox', `0 0 ${width} ${height}`);
  const grid = [0, .25, .5, .75, 1].flatMap(score => [
    plotElement('line', { x1: left, x2: right, y1: y(score), y2: y(score), class: 'trend-grid' }),
    plotElement('text', { x: left - 6, y: y(score) + 4, 'text-anchor': 'end' }, String(score)),
  ]);
  const stride = Math.max(1, Math.ceil(leaderRounds.length / Math.max(1, Math.floor(width / 55))));
  const ticks = leaderRounds.flatMap((entry, index) => index % stride === 0 || index === leaderRounds.length - 1
    ? [plotElement('text', { x: x(index), y: height - 6, 'text-anchor': 'middle' }, `R${entry.round}`)] : []);
  const traces = series.flatMap(({ key }) => [
    plotElement('polyline', {
      points: leaderRounds.map((entry, index) => `${x(index)},${y(entry[key])}`).join(' '),
      class: `trend-${key}`,
    }),
    plotElement('circle', { cx: x(selectedIndex), cy: y(selected[key]), r: 4, class: `trend-${key}` }),
  ]);
  plot.replaceChildren(...grid, ...ticks,
    plotElement('line', { x1: x(selectedIndex), x2: x(selectedIndex), y1: y(1), y2: y(0), class: 'trend-cursor' }),
    ...traces);
  scrubber.setAttribute('aria-valuetext', `Round ${selected.round}${selected.isolated ? ', isolated check' : ''}`);
  trendScores.textContent = [`Round ${selected.round}${selected.isolated ? ' · isolated check' : ''} · ${candidateLabel(selected.name)}`,
    ...series.map(({ key, label }) => `${label} ${selected[key].toFixed(3)}`),
    selected.integrity === 'approved' ? 'Final integrity review passed' : 'Continuous-stream integrity unverified'].join(' · ');
}

function showTrendContext(followLatest = true) {
  const context = leaderContexts.find(item => item.id === contextSelector.value);
  leaderRounds = context?.points ?? [];
  trend.hidden = !leaderRounds.length;
  document.querySelector('#trend-empty').hidden = !!leaderRounds.length;
  document.querySelector('#trend-context-summary').textContent = context?.summary ?? '';
  if (!leaderRounds.length) return;
  scrubber.max = leaderRounds.length - 1;
  if (followLatest) scrubber.value = scrubber.max;
  drawLeaderTrend();
}

function updateLeaderContexts(contexts) {
  const serialized = JSON.stringify(contexts);
  if (serialized === lastContexts) return;
  const selected = contextSelector.value;
  const wasLatest = !leaderContexts.length || selected === leaderContexts.at(-1).id;
  const followLatest = !leaderRounds.length || Number(scrubber.value) === leaderRounds.length - 1;
  leaderContexts = contexts;
  lastContexts = serialized;
  contextSelector.replaceChildren(...contexts.map(context => new Option(context.label, context.id)));
  contextSelector.value = wasLatest ? contexts.at(-1)?.id ?? '' : selected;
  showTrendContext(followLatest);
}

contextSelector.addEventListener('change', () => showTrendContext());
scrubber.addEventListener('input', drawLeaderTrend);
document.addEventListener('candidate-labels-updated', drawLeaderTrend);
new ResizeObserver(drawLeaderTrend).observe(plot);
