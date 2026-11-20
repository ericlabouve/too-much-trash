const trend = document.querySelector("#leader-trend");
const plot = document.querySelector("#trend-plot");
const scrubber = document.querySelector("#trend-round");
const trendScores = document.querySelector("#trend-scores");
const series = [
  { key: "fitness", label: "Fitness" },
  { key: "jaw", label: "Development jaw F1" },
];
const trendStorageKey = "jaw-dashboard:leader-trend";
let leaderRounds = [];
let lastTrend;

function plotElement(tag, attributes, label) {
  const element = document.createElementNS("http://www.w3.org/2000/svg", tag);
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
  const first = leaderRounds[0].round;
  const last = leaderRounds.at(-1).round;
  const x = (round) => first === last ? (left + right) / 2 : left + (right - left) * (round - first) / (last - first);
  const y = (score) => bottom - score * (bottom - 12);
  const selected = leaderRounds[Number(scrubber.value)];
  plot.setAttribute("viewBox", `0 0 ${width} ${height}`);
  const grid = [0, .25, .5, .75, 1].flatMap((score) => [
    plotElement("line", { x1: left, x2: right, y1: y(score), y2: y(score), class: "trend-grid" }),
    plotElement("text", { x: left - 6, y: y(score) + 4, "text-anchor": "end" }, String(score)),
  ]);
  const step = Math.max(1, Math.ceil((last - first + 1) / Math.floor(width / 55)));
  const ticks = leaderRounds.filter(({ round }) => round === first || round === last ||
    ((round - first) % step === 0 && last - round >= step));
  const traces = series.flatMap(({ key }) => [
    plotElement("polyline", {
      points: leaderRounds.map((entry) => `${x(entry.round)},${y(entry[key])}`).join(" "),
      class: `trend-${key}`,
    }),
    plotElement("circle", { cx: x(selected.round), cy: y(selected[key]), r: 4, class: `trend-${key}` }),
  ]);
  plot.replaceChildren(...grid,
    ...ticks.map(({ round }) => plotElement("text", { x: x(round), y: height - 6, "text-anchor": "middle" }, `R${round}`)),
    plotElement("line", { x1: x(selected.round), x2: x(selected.round), y1: y(1), y2: y(0), class: "trend-cursor" }),
    ...traces);
  scrubber.setAttribute("aria-valuetext", `Round ${selected.round}`);
  trendScores.textContent = [`Round ${selected.round} · ${selected.name}`,
    ...series.map(({ key, label }) => `${label} ${selected[key].toFixed(3)}`)].join(" · ");
}

function showLeaderTrend(points) {
  if (!points.length) return;
  const followLatest = !leaderRounds.length || Number(scrubber.value) === leaderRounds.length - 1;
  leaderRounds = points;
  lastTrend = JSON.stringify(points);
  trend.hidden = false;
  document.querySelector("#trend-empty").hidden = true;
  scrubber.max = points.length - 1;
  if (followLatest) scrubber.value = scrubber.max;
  drawLeaderTrend();
}

function updateLeaderTrend(snapshot) {
  const history = snapshot.result?.history;
  const points = snapshot.leader_trend ?? history?.flatMap(({ round, ranked }) => {
    const top = ranked[0];
    if (!top?.deposit) return [];
    return [{ round, name: top.candidate.name, fitness: top.fitness, jaw: top.development.f1 }];
  });
  if (!points?.length || JSON.stringify(points) === lastTrend) return;
  showLeaderTrend(points);
  try {
    sessionStorage.setItem(trendStorageKey, JSON.stringify(points));
  } catch {
    // Keep the chart available in the current page.
  }
}

scrubber.addEventListener("input", drawLeaderTrend);
new ResizeObserver(drawLeaderTrend).observe(plot);
try {
  showLeaderTrend(JSON.parse(sessionStorage.getItem(trendStorageKey)) ?? []);
} catch {
  // The next dashboard snapshot can populate the chart.
}
