const stages = ["prepare", "candidates", "replay", "holdout", "selected", "review", "iphone", "live"];
const messages = {
  prepare: "Preparing replay clips",
  replay: "Scoring candidates on the laptop",
  holdout: "Checking held-out clips",
  selected: "Laptop round complete · ready for the next laptop round",
  iphone: "Benchmarking on iPhone",
  live: "Validating live pickups",
  failed: "Experiment stopped. See the runner output."
};
const status = document.querySelector("#status");
const table = document.querySelector("#candidates");
const count = document.querySelector("#pool-count");
const nodes = document.querySelectorAll("[data-step]");
const flow = document.querySelector(".flow");
new ResizeObserver(([entry]) => {
  const gap = parseFloat(getComputedStyle(flow).columnGap);
  const columns = Math.max(1, Math.min(nodes.length, Math.floor((entry.contentRect.width + gap) / (132 + gap))));
  flow.style.setProperty("--step-columns", columns);
  nodes.forEach((node, index) => {
    const row = Math.floor(index / columns);
    const offset = index % columns;
    const forward = row % 2 === 0;
    node.style.gridRow = row + 1;
    node.style.gridColumn = forward ? offset + 1 : columns - offset;
    node.dataset.next = index === nodes.length - 1 ? "" :
      offset === columns - 1 ? "down" : forward ? "right" : "left";
  });
}).observe(flow);

const format = (value) => Number.isFinite(value) ? value.toFixed(3) : "—";
let previous;
const completedKey = "jaw-dashboard:completed";
let completed;
try {
  completed = JSON.parse(sessionStorage.getItem(completedKey));
} catch {
  // The current pool still renders when browser storage is unavailable.
}

function metricGroup(label, metrics, falseLabel, zeroClips) {
  const group = document.createElement("div");
  group.className = "candidate-metrics";
  const title = document.createElement("strong");
  title.textContent = label;
  const counts = document.createElement("p");
  counts.textContent = metrics
    ? `${metrics.matched} matched · ${metrics.missed} missed · ${metrics.false_positives} ${falseLabel}`
    : "Awaiting scores";
  if (Number.isInteger(zeroClips)) counts.textContent += ` · ${zeroClips} clips with no matches`;
  group.append(title, counts);
  return group;
}

function render(snapshot) {
  if (typeof updateLeaderTrend === "function") updateLeaderTrend(snapshot);
  const {step, round, active_candidate: active, ranked, pool, result, iphone_benchmark: phone, iphone_timing: phoneTiming} = snapshot;
  const activePool = result?.next_pool ?? pool;
  const retained = new Set(activePool.map((candidate) => candidate.name));
  if (step === "selected" && ranked.length) {
    completed = { round, ranked: ranked.filter(({ candidate }) => retained.has(candidate.name)) };
    try {
      sessionStorage.setItem(completedKey, JSON.stringify(completed));
    } catch {
      // Keep the latest completed round in memory.
    }
  }
  const previousRanked = completed?.round === round - 1 ? completed.ranked : [];
  const leader = step === "selected" ? ranked[0]?.candidate.name : previousRanked[0]?.candidate.name;
  status.textContent = messages[step] ?? "Experiment update";
  if (round) status.textContent = `Round ${round} · ${status.textContent}`;
  if (active) status.textContent += ` · ${active}`;
  else if (retained.has(leader)) status.textContent += ` · Leading candidate: ${leader}`;
  const current = stages.indexOf(step);
  for (const node of nodes) {
    const index = stages.indexOf(node.dataset.step);
    const complete = index < current || (step === "selected" && index === current);
    const phoneNode = node.dataset.step === "iphone" && phone;
    const running = (index === current && step !== "selected") || (phoneNode && phone.state === "running");
    node.dataset.state = running ? "active" : complete || (phoneNode && phone.state === "complete") ? "complete" : "pending";
    if (running) node.setAttribute("aria-current", "step");
    else node.removeAttribute("aria-current");
  }
  count.textContent = `${activePool.length} / 10 in the pool`;
  const trialScores = result?.challengers ?? [];
  const scores = new Map([...trialScores, ...(result?.pruned_scores ?? []), ...ranked].map((entry) => [entry.candidate.name, entry]));
  const previousScores = new Map(previousRanked.map((entry) => [entry.candidate.name, entry]));
  const candidates = new Set([
    ...(active ? [active] : []),
    ...[...ranked, ...previousRanked].map(({ candidate }) => candidate.name).filter((name) => retained.has(name)),
    ...retained
  ]);
  const known = new Map([...pool, ...activePool, ...[...scores.values()].map((entry) => entry.candidate)]
    .map((candidate) => [candidate.name, candidate]));
  const expanded = new Set([...table.querySelectorAll("details[open]")].map((item) => item.dataset.candidate));
  const pruned = new Set([result?.pruned ?? []].flat().map((candidate) => candidate.name));
  for (const name of pruned) candidates.add(name);
  const rows = [...candidates].map((name) => {
    const row = document.createElement("tr");
    const currentScore = scores.get(name);
    const priorScore = name !== active && !currentScore ? previousScores.get(name) : undefined;
    const score = currentScore ?? priorScore;
    if (name === active) row.dataset.state = "running";
    else if (pruned.has(name)) row.dataset.state = "pruned";
    else if (name === leader && step === "selected") row.dataset.state = "winner";
    const candidate = known.get(name);
    const created = candidate?.created_round;
    const heading = document.createElement("th");
    heading.scope = "row";
    const details = document.createElement("details");
    details.dataset.candidate = name;
    details.open = expanded.has(name);
    const summary = document.createElement("summary");
    summary.textContent = name;
    details.append(summary);
    const lane = result?.protected?.find((entry) => entry.name === name);
    const role = result?.roles?.[name];
    if (lane || (role && role !== "deposit specialist")) {
      const note = document.createElement("p");
      note.className = "candidate-metrics";
      note.textContent = lane ? `Protected lineage · ${lane.attempts}/3 mutations` : role;
      details.append(note);
    }
    details.append(metricGroup("Jaw events", score?.development, "false triggers", score?.zero_jaw_clips));
    if (score?.jaw_by_event) {
      details.append(
        metricGroup("Squeezes", score.jaw_by_event.close, "false triggers"),
        metricGroup("Releases", score.jaw_by_event.open, "false triggers")
      );
    }
    if (score?.withheld) {
      details.append(metricGroup(`Withheld jaw events · F1 ${format(score.withheld.jaw.f1)}`,
        score.withheld.jaw, "false triggers"));
    }
    if (score && !candidate?.deposit_method) {
      const replayLink = document.createElement("a");
      replayLink.className = "candidate-replay-link";
      replayLink.href = "#video-replay";
      replayLink.textContent = "Watch detections";
      replayLink.addEventListener("click", () => {
        document.dispatchEvent(new CustomEvent("jaw-replay-candidate", { detail: name }));
      });
      details.append(replayLink);
    }
    heading.append(details);
    row.append(heading);
    const phoneP95 = candidate?.signal === "default" && !candidate.deposit_method ? phoneTiming?.methods?.[candidate.method]?.phone_p95_ms : undefined;
    const values = [format(score?.fitness), created ? `Round ${created}` : "—",
      format(score?.development.f1), format(score?.p95_ms), format(phoneP95)];
    for (const value of values) {
      const cell = document.createElement("td");
      cell.textContent = value;
      if (priorScore && row.cells.length === 1) cell.title = `Fitness from Round ${completed.round}`;
      row.append(cell);
    }
    return row;
  });
  table.replaceChildren(...rows);
}

async function refresh() {
  try {
    const response = await fetch("progress.json", {cache: "no-store"});
    if (!response.ok) throw new Error("Dashboard data unavailable");
    const body = await response.text();
    if (body !== previous) {
      render(JSON.parse(body));
      previous = body;
    }
  } catch {
    if (previous === undefined) status.textContent = "Waiting for the runner to publish progress";
  } finally {
    window.setTimeout(refresh, 500);
  }
}

refresh();
