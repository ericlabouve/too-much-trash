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
const alternateSignals = {
  angle: "Measures the angle between lines near the jaw hinge",
  patch: "Tracks the lower jaw relative to a fixed shaft patch",
  gradient: "Compares local edge directions with the open reference",
  occupancy: "Counts changes concentrated between the jaws",
  imu: "Looks for spikes in the phone’s accelerometer samples"
};
const status = document.querySelector("#status");
const fitnessNote = document.querySelector("#fitness-note");
const table = document.querySelector("#candidates");
const count = document.querySelector("#pool-count");
const holdout = document.querySelector("#holdout");
const phoneResult = document.querySelector("#phone-result");
const nodes = document.querySelectorAll("[data-step]");
const format = (value) => Number.isFinite(value) ? value.toFixed(3) : "—";
let previous;

function render(snapshot) {
  const {step, round, active_candidate: active, ranked, pool, result, iphone_benchmark: phone, iphone_timing: phoneTiming} = snapshot;
  const topScore = ranked[0];
  if (Number.isFinite(topScore?.pooled_accuracy)) {
    fitnessNote.textContent = "Fitness weights accuracy and laptop speed equally. False triggers cost twice a miss, and the weakest clip contributes 25% of accuracy.";
    if (phoneTiming) {
      fitnessNote.textContent += " iPhone p95 uses prepared-frame feature extraction and is shared by candidates using the same extractor.";
      if (Number.isFinite(phoneTiming.champion_detector_p95_ms)) {
        fitnessNote.textContent += ` The winner's complete prepared-frame detector measured ${format(phoneTiming.champion_detector_p95_ms)} ms p95 on iPhone.`;
      }
    }
    if (result?.phone_target_fps) {
      const budget = (1000 * result.detector_frame_share / result.phone_target_fps).toFixed(2);
      fitnessNote.textContent += ` Full speed credit at or below ${budget} ms per sampled frame, with headroom for ${result.phone_target_fps} fps capture.`;
    }
  } else if (Number.isFinite(topScore?.worst_clip_f1)) {
    fitnessNote.textContent = "Fitness gives accuracy and laptop speed equal weight. Accuracy averages mean and weakest development-clip F1.";
  } else {
    fitnessNote.textContent = "Fitness gives mean development-clip F1 and laptop speed equal weight.";
  }
  const activePool = result?.next_pool ?? pool;
  status.textContent = messages[step] ?? "Experiment update";
  if (round) status.textContent = `Round ${round} · ${status.textContent}`;
  if (active) status.textContent += ` · ${active}`;
  const current = stages.indexOf(step);
  for (const node of nodes) {
    const index = stages.indexOf(node.dataset.step);
    const complete = index < current || (step === "selected" && index === current);
    const phoneNode = node.dataset.step === "iphone" && phone;
    const running = phoneNode ? phone.state === "running" : index === current && step !== "selected";
    node.dataset.state = running ? "active" : complete || (phoneNode && phone.state === "complete") ? "complete" : "pending";
    if (running) node.setAttribute("aria-current", "step");
    else node.removeAttribute("aria-current");
  }
  count.textContent = `${activePool.length} / 10 in the pool`;
  const trialScores = result?.challengers ?? [];
  const scores = new Map([...trialScores, ...(result?.pruned_scores ?? []), ...ranked].map((entry) => [entry.candidate.name, entry]));
  const candidates = new Set([...ranked.map((entry) => entry.candidate.name),
    ...activePool.map((candidate) => candidate.name),
    ...trialScores.map((entry) => entry.candidate.name)]);
  if (active) candidates.add(active);
  const retained = new Set(activePool.map((candidate) => candidate.name));
  const known = new Map([...pool, ...activePool, ...[...scores.values()].map((entry) => entry.candidate)]
    .map((candidate) => [candidate.name, candidate]));
  const expanded = new Set([...table.querySelectorAll("details[open]")].map((item) => item.dataset.candidate));
  const pruned = new Set([result?.pruned ?? []].flat().map((candidate) => candidate.name));
  for (const name of pruned) candidates.add(name);
  const admitted = new Set((result?.admitted ?? [result?.offspring]).filter(Boolean).map((candidate) => candidate.name));
  const rows = [...candidates].map((name) => {
    const row = document.createElement("tr");
    const score = scores.get(name);
    let state = score ? (score.parent ? "Trial scored" : "Scored") : "Queued";
    if (name === active) state = "Running";
    else if (result) {
      if (pruned.has(name)) state = "Pruned";
      else if (name === ranked[0]?.candidate.name) state = "Winner";
      else if (admitted.has(name)) state = score ? "Admitted" : "New variant";
      else if (retained.has(name)) state = "Retained";
      else state = "Trial only";
    }
    row.dataset.state = state.toLowerCase();
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
    const description = document.createElement("p");
    description.className = "candidate-detail";
    const attributes = [];
    if (candidate) {
      if (alternateSignals[candidate.method]) attributes.push(alternateSignals[candidate.method]);
      if (candidate.parent) attributes.push(`Parent: ${candidate.parent}`);
      attributes.push(`Threshold ${candidate.threshold}`, `${candidate.confirm} confirming frames`);
      if (candidate.smoothing > 1) attributes.push(`Smoothing over ${candidate.smoothing} frames`);
      if (candidate.cooldown > 0) attributes.push(`${candidate.cooldown}-frame cooldown`);
      if (candidate.signal === "opposed") attributes.push("Requires opposing motion on both sides");
      if (candidate.signal === "shaft") attributes.push("Crop aligned to the shaft");
    }
    if (score) {
      attributes.push(`${score.development.matched} matched, ${score.development.missed} missed, ${score.development.false_positives} false triggers`);
      if (Number.isInteger(score.development.clean_clips)) {
        attributes.push(`${score.development.clean_clips} of ${score.clip_f1.length} clips with one matched squeeze and release and zero false triggers`);
      }
      if (score.clip_f1) attributes.push(`F1 by clip: ${score.clip_f1.map(format).join(", ")}`);
      if (Number.isFinite(score.worst_clip_f1)) attributes.push(`Weakest clip F1: ${format(score.worst_clip_f1)}`);
    }
    description.textContent = attributes.join(" · ") || "Candidate details will appear after scoring.";
    details.append(description);
    if (score) {
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
    const values = [state, created ? `Round ${created}` : "—",
      format(score?.development.f1), score?.development.matched ?? "—",
      score?.development.missed ?? "—", score?.development.false_positives ?? "—", format(score?.p95_ms), format(candidate?.signal === "default" ? phoneTiming?.methods?.[candidate.method]?.phone_p95_ms : undefined), format(score?.fitness)];
    for (const value of values) {
      const cell = document.createElement("td");
      cell.textContent = value;
      row.append(cell);
    }
    return row;
  });
  table.replaceChildren(...rows);
  const evaluation = result?.winner_holdout;
  holdout.hidden = !evaluation && !result?.fit_all_clips;
  if (result?.fit_all_clips) {
    const fit = result.ranked[0].development;
    holdout.textContent = `Fit on all five clips · ${fit.matched} of ${fit.matched + fit.missed} matched · ${fit.false_positives} false triggers · ${fit.clean_clips} clean clips`;
  } else if (evaluation) {
    holdout.textContent = `Comparison clips · ${evaluation.matched} of ${evaluation.matched + evaluation.missed} reference events matched · ${evaluation.false_positives} false triggers. The press reference is 3 s from the start of the recording window. Release is typically 3 s before the end. Both references come from recorded button timestamps.`;
  }
  phoneResult.hidden = phone?.state !== "complete";
  if (!phoneResult.hidden) {
    phoneResult.textContent = `iPhone replay of original bilateral flow · ${format(phone.p95_ms)} ms p95 detector time · ${phone.matched} of ${phone.matched + phone.missed} reference events matched · ${phone.false_positives} false triggers.`;
  }
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
