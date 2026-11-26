const stages = ["prepare", "research", "evolution", "evaluation", "integrity_review", "audit", "selected"];
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
let evaluationViews = [];
let latestSnapshot;
let evaluationSignature;
let phoneMeasurements;
let phoneSignature;
let laptopNativeMeasurements;
let laptopNativeSignature;

function updateLaptopNativeBenchmark(summary) {
  const signature = JSON.stringify(summary);
  if (signature === laptopNativeSignature) return;
  laptopNativeSignature = signature;
  laptopNativeMeasurements = summary?.status === 'validated' ? summary : null;
  if (latestSnapshot) render(latestSnapshot);
}

function updatePhoneBenchmark(summary) {
  const signature = JSON.stringify(summary);
  if (signature === phoneSignature) return;
  phoneSignature = signature;
  phoneMeasurements = summary?.status === 'validated' ? summary : null;
  if (latestSnapshot) render(latestSnapshot);
}

function updateCandidateEvaluations(views) {
  const settings = typeof roundSettings === 'function' ? roundSettings() : null;
  const signature = JSON.stringify([views, settings]);
  if (signature === evaluationSignature) return;
  evaluationSignature = signature;
  evaluationViews = views;
  if (latestSnapshot) render(latestSnapshot);
}

function currentEvaluation(snapshot) {
  const settings = typeof roundSettings === 'function' ? roundSettings() : {};
  const fields = ['seed', 'clip_limit', 'train_percent', 'validation_percent', 'test_percent',
    'jaw_weight', 'match_seconds', 'full_speed_ms', 'frame_budget_ms'];
  const view = [...evaluationViews].reverse().find(item =>
    fields.every(key => item.settings[key] === settings[key]) &&
    JSON.stringify([...item.settings.datasets].sort()) === JSON.stringify([...(settings.datasets ?? [])].sort()));
  const pool = snapshot.result?.next_pool ?? snapshot.pool;
  const configurations = new Map(pool.map(candidate => [candidate.name, candidate]));
  const entries = (view?.entries ?? []).filter(entry => {
    const original = configurations.get(entry.candidate.name);
    return !original || (Object.keys(original).length === Object.keys(entry.candidate).length &&
      Object.keys(original).every(key => original[key] === entry.candidate[key]));
  }).sort((a, b) => b.fitness - a.fitness);
  const note = document.querySelector('#candidate-score-context');
  note.hidden = !!view;
  note.textContent = view ? '' : 'No matching evaluation for the selected datasets, split and scoring settings.';
  const retainedScores = entries.filter(entry => configurations.has(entry.candidate.name));
  return { ...snapshot, round: view?.round ?? snapshot.round, ranked: retainedScores, pool,
    result: { ...snapshot.result, reporting: 'validation', fit_all_clips: false,
      next_pool: pool, ranked: retainedScores, challengers: entries.filter(entry => !configurations.has(entry.candidate.name)), pruned: [], pruned_scores: [],
      integrity_review: view?.integrity_review,
      evaluation_protocol: view?.evaluation_protocol,
      benchmark_protocol: view?.benchmark_protocol,
      training_histories: view?.training_histories,
      candidate_metadata: { ...snapshot.result?.candidate_metadata, ...view?.candidate_metadata } } };
}
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

function renderWorkflow(phase, state) {
  const current = stages.indexOf(phase);
  for (const node of nodes) {
    const index = stages.indexOf(node.dataset.step);
    const complete = current >= 0 && (index < current || state === 'completed');
    const running = index === current && state === 'running';
    node.dataset.state = index === current && state === 'failed' ? 'failed'
      : running ? 'active' : complete ? 'complete' : 'pending';
    if (running) node.setAttribute('aria-current', 'step');
    else node.removeAttribute('aria-current');
  }
}

document.addEventListener('round-workflow-state', ({detail}) => {
  const phase = detail.phase === 'preparation' ? 'prepare' : detail.phase;
  renderWorkflow(phase ?? (detail.state === 'running' ? 'prepare' : 'selected'), detail.state);
});

function fitExpandedCards() {
  const open = table.querySelector('.candidate-toggle[aria-expanded="true"]');
  table.closest('.table-wrap').classList.toggle('has-expanded-card', !!open);
}

function candidateSplitScores(score, result) {
  const scores = { ...score?.split_scores };
  if (!scores.validation && result?.reporting === 'validation') scores.validation = score?.development;
  if (!scores.train && result?.fit_all_clips && result?.reporting === 'in_sample') scores.train = score?.development;
  return scores;
}

function render(snapshot) {
  latestSnapshot = snapshot;
  snapshot = currentEvaluation(snapshot);
  registerCandidateNames(snapshot);
  const {step, round, active_candidate: active, ranked, pool, result, iphone_benchmark: phone, iphone_timing: phoneTiming} = snapshot;
  const validationRound = result?.reporting === 'validation';
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
  const previousRanked = !validationRound && completed?.round === round - 1 ? completed.ranked : [];
  const leader = step === "selected" ? ranked[0]?.candidate.name : previousRanked[0]?.candidate.name;
  status.textContent = messages[step] ?? "Experiment update";
  if (round) status.textContent = `Round ${round} · ${status.textContent}`;
  if (active) status.textContent += ` · ${candidateLabel(active)}`;
  else if (retained.has(leader)) status.textContent += ` · Leading candidate: ${candidateLabel(leader)}`;
  const phase = { candidates: 'research', replay: 'evaluation', holdout: 'evaluation', review: 'audit' }[step] ?? step;
  renderWorkflow(phase, step === 'selected' ? 'completed' : 'running');
  count.textContent = `${activePool.length} in the pool`;
  const trialScores = result?.challengers ?? [];
  const scores = new Map([...trialScores, ...(result?.pruned_scores ?? []), ...ranked].map((entry) => [entry.candidate.name, entry]));
  const previousScores = new Map(previousRanked.map((entry) => [entry.candidate.name, entry]));
  const candidates = new Set([
    ...(active ? [active] : []),
    ...[...ranked, ...previousRanked].map(({ candidate }) => candidate.name).filter((name) => retained.has(name)),
    ...retained
  ]);
  for (const entry of trialScores) candidates.add(entry.candidate.name);
  const known = new Map([...pool, ...activePool, ...[...scores.values()].map((entry) => entry.candidate)]
    .map((candidate) => [candidate.name, candidate]));
  const expanded = new Set([...table.querySelectorAll(".candidate-toggle[aria-expanded='true']")].map((item) => item.dataset.candidate));
  const pruned = new Set([result?.pruned ?? []].flat().map((candidate) => candidate.name));
  for (const name of pruned) candidates.add(name);
  const rows = [...candidates].flatMap((name, index) => {
    const row = document.createElement("tr");
    const currentScore = scores.get(name);
    const priorScore = name !== active && !currentScore ? previousScores.get(name) : undefined;
    const score = currentScore ?? priorScore;
    if (name === active) row.dataset.state = "running";
    else if (!retained.has(name)) row.dataset.state = "trial";
    else if (pruned.has(name)) row.dataset.state = "pruned";
    else if (name === leader && step === "selected") row.dataset.state = "winner";
    const candidate = known.get(name);
    const created = candidate?.created_round;
    const heading = document.createElement("th");
    heading.scope = "row";
    const toggle = document.createElement("button");
    toggle.type = "button";
    toggle.className = "candidate-toggle";
    toggle.dataset.candidate = name;
    toggle.textContent = candidateLabel(name);
    toggle.setAttribute("aria-expanded", String(expanded.has(name)));
    const detailRow = document.createElement("tr");
    detailRow.className = "candidate-detail-row";
    detailRow.id = `candidate-details-${index}`;
    detailRow.hidden = !expanded.has(name);
    toggle.setAttribute("aria-controls", detailRow.id);
    toggle.addEventListener("click", () => {
      detailRow.hidden = !detailRow.hidden;
      toggle.setAttribute("aria-expanded", String(!detailRow.hidden));
      fitExpandedCards();
    });
    const detailCell = document.createElement("td");
    detailCell.colSpan = 6;
    const details = document.createElement("div");
    details.className = "candidate-card";
    const cardLayout = document.createElement("div");
    cardLayout.className = "candidate-card-layout";
    const metadata = document.createElement("div");
    metadata.className = "candidate-metadata";
    if (!retained.has(name)) {
      const trialLabel = document.createElement('strong');
      trialLabel.textContent = 'Evaluated · not retained';
      metadata.append(trialLabel);
    }
    const diagramCandidate = { ...(candidate ?? { name, method: "unknown", confirm: 1 }),
      presentation: result?.candidate_metadata?.[name] };
    cardLayout.append(metadata, makeCandidateArchitecture(diagramCandidate, result?.feature_parameters));
    details.append(cardLayout);
    const lossCurve = makeCandidateLossCurve(result?.training_histories?.[name], candidate, diagramCandidate.presentation);
    if (lossCurve) details.append(lossCurve);
    detailCell.append(details);
    detailRow.append(detailCell);
    const lane = result?.protected?.find((entry) => entry.name === name);
    const role = result?.roles?.[name];
    if (lane || (role && role !== "deposit specialist")) {
      const note = document.createElement("p");
      note.className = "candidate-metrics";
      note.textContent = lane ? `Protected lineage · ${lane.attempts}/3 mutations` : role;
      const roleTitle = document.createElement("strong");
      roleTitle.textContent = note.textContent;
      metadata.append(roleTitle);
    }
    const stats = document.createElement('dl');
    stats.className = 'candidate-summary-stats';
    const integrityReviewers = (result?.integrity_review?.candidate_reviewers?.[name]
      ?? result?.integrity_review?.reviewers ?? []).length;
    for (const [label, value] of [
      ['Fitness', format(score?.fitness)], ['Created', created ? `Round ${created}` : '—'],
      [validationRound ? 'Selection jaw F1 · validation' : 'Historical jaw F1 · development', format(score?.development?.f1)],
      ['Streaming integrity', result?.integrity_review?.candidate_status?.[name] === 'approved'
        ? `Approved · ${integrityReviewers} reviewer${integrityReviewers === 1 ? '' : 's'}`
        : 'Unreviewed · clip replay'],
      ['Scoring runtime', result?.benchmark_protocol === 'deployment-v1' ? 'Deployment artifact · native CPU' : 'Historical prototype'],
      ['Matched six-clip laptop C++ p95', format(laptopNativeMeasurements?.candidates?.[name]?.laptop_native_p95_ms)],
    ]) {
      const term = document.createElement('dt'); term.textContent = label;
      const description = document.createElement('dd'); description.textContent = value;
      stats.append(term, description);
    }
    metadata.append(stats);
    metadata.append(metricGroup("Jaw events", score?.development, "false triggers", score?.zero_jaw_clips));
    if (score?.jaw_by_event) {
      metadata.append(
        metricGroup("Squeezes", score.jaw_by_event.close, "false triggers"),
        metricGroup("Releases", score.jaw_by_event.open, "false triggers")
      );
    }
    if (score?.withheld) {
      metadata.append(metricGroup(`Withheld jaw events · F1 ${format(score.withheld.jaw.f1)}`,
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
      metadata.append(replayLink);
    }
    heading.append(toggle);
    row.append(heading);
    const measuredPhone = phoneMeasurements?.candidates?.[name];
    const exactPhone = measuredPhone && candidate && Object.keys(candidate).length === Object.keys(measuredPhone.candidate).length &&
      Object.keys(candidate).every(key => candidate[key] === measuredPhone.candidate[key]) ? measuredPhone : null;
    const phoneP95 = exactPhone?.phone_p95_ms ?? (candidate?.signal === "default" && !candidate.deposit_method ? phoneTiming?.methods?.[candidate.method]?.phone_p95_ms : undefined);
    const splits = candidateSplitScores(score, result);
    for (const key of ['train', 'validation', 'test']) {
      const cell = document.createElement('td');
      cell.textContent = key === 'test' && !splits.test ? 'Reserved' : format(splits[key]?.f1);
      cell.title = splits[key] ? (key === 'train' && result?.fit_all_clips
        ? 'Historical fitting/tuning replay; not a newly partitioned training result.'
        : `${key} event F1`)
        : key === 'test' ? 'Reserved; no test evaluation recorded.' : 'No score recorded for this split.';
      row.append(cell);
    }
    const phoneLabel = Number.isFinite(phoneP95) && phoneP95 < 0.001 ? '<0.001' : format(phoneP95);
    const laptopLabel = Number.isFinite(score?.p95_ms) && score.p95_ms < 0.001 ? '<0.001' : format(score?.p95_ms);
    for (const [index, value] of [laptopLabel, phoneLabel].entries()) {
      const cell = document.createElement('td');
      if (index === 0) cell.title = result?.benchmark_protocol === 'deployment-v1' ? 'Final deployment artifact · all validation clips · native CPU features, inference and decoder; excludes capture/decode/resize/loading' : 'Historical prototype latency used by this recorded round';
      if (index === 1 && exactPhone) cell.title = `${phoneMeasurements.device} · six-clip hardware benchmark · ${phoneMeasurements.repeats} serial passes · ${exactPhone.samples} frames · nominal thermal state · ${phoneMeasurements.scope}`;
      cell.textContent = value;
      row.append(cell);
    }
    return [row, detailRow];
  });
  table.replaceChildren(...rows);
  fitExpandedCards();
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
