const roundForm = document.querySelector('#round-form');
const startRoundButton = document.querySelector('#start-round');
const roundMessage = document.querySelector('#round-message');
const roundProgressWrap = document.querySelector('#round-progress-wrap');
const roundProgress = document.querySelector('#round-progress');
const roundProgressLabel = document.querySelector('#round-progress-label');
const roundFamily = document.querySelector('#round-family');
const roundFields = () => [...roundForm.elements].filter(field => ['INPUT', 'SELECT', 'TEXTAREA'].includes(field.tagName));
const datasetOptions = document.querySelector('#round-datasets');
let availableDatasets = [];
let roundDefaultsLoaded = false;
let roundServiceAvailable = false;
let roundSubmitting = false;
let roundRunning = false;
let roundNumber;
let latestRoundResult;
let familyCandidateCounts = {};
let retainedCandidateCount = 0;
let familyOptionsSignature;
let roundConnectionLost = false;

function updateAgentCounts() {
  const newFamily = roundFamily.value === 'new_family';
  const available = roundFamily.value === 'all'
    ? retainedCandidateCount
    : familyCandidateCounts[roundFamily.value] ?? 0;
  const evolution = newFamily ? 0 : available;
  const research = Number(roundForm.elements.research_slots.value);
  const review = Number(newFamily);
  const reviewersPerCandidate = Number(roundForm.elements.review_agents.value);
  const finalReviewers = (evolution + research) * reviewersPerCandidate;
  document.querySelector('#review-agent-count').value = String(review);
  document.querySelector('#review-agent-setting').hidden = !newFamily;
  document.querySelector('#flow-parents').textContent = newFamily ? 'No parent evolution' : `${evolution} parents`;
  document.querySelector('#flow-research').textContent = `${research} research agent${research === 1 ? '' : 's'}`;
  document.querySelector('#flow-architecture').textContent = newFamily ? '+ 1 architecture reviewer' : 'Independent proposals';
  document.querySelector('#flow-children').textContent = `${evolution} children`;
  document.querySelector('#flow-fresh').textContent = `${research} fresh candidate${research === 1 ? '' : 's'}`;
  document.querySelector('#flow-reviewers').textContent = `${finalReviewers} fresh reviewer${finalReviewers === 1 ? '' : 's'}`;
  document.querySelector('#flow-review-detail').textContent = `${reviewersPerCandidate} per candidate · each reviews only one`;
  document.querySelector('#flow-selection').textContent = `Select up to ${roundForm.elements.pool_size.value} survivors`;
}

function selectedDatasets() {
  return [...datasetOptions.querySelectorAll('input:checked')].map(input => input.value);
}

function labelName(label) {
  return { confirmed: 'Deposited', not_deposited: 'Not deposited', unresolved: 'Unresolved',
    uncertain: 'Uncertain', unlabeled: 'Unlabeled' }[label] ?? label.replaceAll('_', ' ');
}

function labelCountsText(counts) {
  return Object.entries(counts).sort(([a], [b]) => a.localeCompare(b))
    .map(([label, count]) => `${labelName(label)} ${count}`).join(' · ');
}

function renderDatasets(datasets, selected) {
  availableDatasets = datasets;
  const selection = new Set(selected ?? datasets.map(dataset => dataset.name));
  datasetOptions.replaceChildren(...datasets.map(dataset => {
    const entry = document.createElement('div');
    entry.className = 'dataset-entry';
    const label = document.createElement('label');
    label.dataset.help = dataset.previously_fitted
      ? 'Include this collection in the random split. Existing models have already fitted or tuned on these clips, so learned candidates must be refitted using only the new training partition.'
      : 'Include this frozen collection in the next shuffled training, validation and test split. Clips from one outing can share conditions or overlapping intervals.';
    const input = document.createElement('input');
    input.type = 'checkbox';
    input.name = 'datasets';
    input.value = dataset.name;
    input.checked = selection.has(dataset.name);
    input.setAttribute('aria-label', dataset.name);
    const count = document.createElement('span');
    count.className = 'dataset-count';
    const rates = Object.keys(dataset.frame_rate?.counts ?? {});
    count.textContent = `${dataset.clip_count} clips${rates.length ? ` · ${rates.join('/')} fps` : ''}`;
    if (rates.length) count.title = 'Nominal source cadence from recorded frame intervals; 57–63 fps is treated as 60 fps.';
    label.append(input, document.createTextNode(dataset.name), count);
    const labels = document.createElement('p');
    labels.className = 'dataset-labels';
    labels.textContent = labelCountsText(dataset.label_counts ?? {});
    entry.append(label, labels);
    return entry;
  }));
}

function updateSplitSummary() {
  const selected = new Set(selectedDatasets());
  const checked = availableDatasets.filter(dataset => selected.has(dataset.name));
  updateDatasetFrameRate(checked);
  const total = checked.reduce((sum, dataset) => sum + dataset.clip_count, 0);
  const labels = Object.fromEntries(availableDatasets.flatMap(dataset => Object.keys(dataset.label_counts ?? {})).map(label => [label, 0]));
  for (const dataset of checked) {
    for (const [label, count] of Object.entries(dataset.label_counts ?? {})) labels[label] += count;
  }
  const totalHeading = document.createElement('strong');
  totalHeading.textContent = `Checked datasets · ${total} clips total`;
  const totalLabels = document.createElement('span');
  totalLabels.textContent = labelCountsText(labels);
  document.querySelector('#dataset-totals').replaceChildren(totalHeading, totalLabels);
  const limit = Number(roundForm.elements.clip_limit.value);
  const used = limit > 0 ? Math.min(limit, total) : total;
  const train = Number(roundForm.elements.train_percent.value);
  const validation = Number(roundForm.elements.validation_percent.value);
  const test = Number(roundForm.elements.test_percent.value);
  const valid = train + validation + test === 100;
  roundForm.elements.test_percent.setCustomValidity(valid ? '' : 'Split percentages must add to 100.');
  roundForm.elements.clip_limit.setCustomValidity(used >= 3 ? '' : 'Select at least three clips for training, validation and test.');
  document.querySelector('#split-summary').textContent = valid
    ? `${used} selected clips · shuffled ${train}/${validation}/${test} split`
    : 'Split percentages must add to 100.';
}

function updateDatasetFrameRate(checked) {
  const rates = new Set(checked.map(dataset => dataset.frame_rate?.nominal_fps));
  const common = checked.length && rates.size === 1 && !rates.has(null) && !rates.has(undefined) ? [...rates][0] : null;
  const input = roundForm.elements.target_fps;
  document.querySelector('#target-fps-setting').hidden = common !== null;
  input.readOnly = common !== null;
  const observed = [...new Set(checked.flatMap(dataset => Object.keys(dataset.frame_rate?.counts ?? {})))].sort((a,b) => Number(a)-Number(b));
  if (common !== null) input.value = common;
  document.querySelector('#dataset-fps-note').textContent = common !== null
    ? `Dataset rate: ${common} fps${common === 60 ? ' (±5%)' : ''}`
    : observed.length > 1 ? `Mixed source rates: ${observed.join(' / ')} fps. Choose a scoring rate.`
      : 'A common source rate is not established. Choose a scoring rate.';
}

function constrainSpeedHandles(changed) {
  const full = roundForm.elements.full_speed_frame_fraction;
  const zero = roundForm.elements.zero_speed_frame_fraction;
  if (changed === full) full.value = Math.max(0.01, Math.min(Number(full.value), Number(zero.value) - 0.01)).toFixed(2);
  if (changed === zero) zero.value = Math.max(Number(zero.value), Number(full.value) + 0.01).toFixed(2);
}

function updateFitnessEquation() {
  const tolerance = Number(roundForm.elements.match_seconds.value);
  const target = Number(roundForm.elements.target_f1.value);
  const toleranceLabel = Number.isFinite(tolerance) ? `±${tolerance} s` : '—';
  document.querySelector('#jaw-squeeze-window').textContent = toleranceLabel;
  document.querySelector('#jaw-release-window').textContent = toleranceLabel;
  document.querySelector('#jaw-target-label').textContent = `Target F1 ≥ ${Number.isFinite(target) ? target.toFixed(2) : '—'}`;
  document.querySelector('#jaw-graphic-title').textContent = `Illustrative squeeze and release matching within ${toleranceLabel} of each button cue; target validation F1 ${target}.`;
  const jawWeight = Number(roundForm.elements.jaw_weight.value) / 100;
  document.querySelector('#speed-weight').value = `${100 - Number(roundForm.elements.jaw_weight.value)}`;
  document.querySelector('#formula-jaw-weight').textContent = jawWeight.toFixed(2);
  document.querySelector('#formula-speed-weight').textContent = (1 - jawWeight).toFixed(2);
  document.querySelector('#compact-jaw-weight').textContent = jawWeight.toFixed(2);
  document.querySelector('#compact-speed-weight').textContent = (1 - jawWeight).toFixed(2);
  const rate = Number(roundForm.elements.target_fps.value);
  const full = Number(roundForm.elements.full_speed_frame_fraction.value);
  const zero = Number(roundForm.elements.zero_speed_frame_fraction.value);
  const interval = 1000 / rate;
  const fullCredit = full * interval;
  const budget = zero * interval;
  const validRate = Number.isFinite(rate) && rate >= 1 && rate <= 240;
  const validBounds = full > 0 && zero > full && budget <= 1000;
  roundForm.elements.target_fps.setCustomValidity(validRate ? '' : 'Use a target frame rate from 1 to 240 fps.');
  roundForm.elements.zero_speed_frame_fraction.setCustomValidity(validBounds ? '' : 'Zero credit must follow full credit, with a maximum bound of 1000 ms.');
  roundForm.elements.full_speed_ms.value = validRate && validBounds ? String(fullCredit) : '';
  roundForm.elements.frame_budget_ms.value = validRate && validBounds ? String(budget) : '';
  const bound = value => Number.isFinite(value) ? value.toFixed(3) : '—';
  document.querySelector('#formula-budget').textContent = bound(budget);
  document.querySelector('#formula-budget-denominator').textContent = bound(budget);
  document.querySelector('#formula-full-credit').textContent = bound(fullCredit);
  document.querySelector('#formula-tolerance').textContent = roundForm.elements.match_seconds.value;
  document.querySelector('.speed-curve').dataset.invalid = String(!validRate || !validBounds);
  if (!validRate || !validBounds) {
    document.querySelector('#speed-bound-summary').textContent = 'Choose a positive full-credit fraction below the zero-credit fraction and a valid frame rate.';
    return;
  }
  const ms = value => value >= 0.1 ? value.toFixed(2) : value.toPrecision(2);
  document.querySelector('#speed-full-fraction-value').textContent = full.toFixed(2);
  document.querySelector('#speed-zero-fraction-value').textContent = zero.toFixed(2);
  document.querySelector('#speed-full-credit-time').textContent = `${ms(fullCredit)} ms`;
  document.querySelector('#speed-zero-credit-time').textContent = `${ms(budget)} ms`;
  document.querySelector('#speed-frame-rate').textContent = `1 frame = ${ms(interval)} ms`;
  document.querySelector('#speed-bound-summary').textContent = `Full credit ≤${full.toFixed(2)} frame → decreasing credit → zero credit ≥${zero.toFixed(2)} frame`;
  const slider = document.querySelector('#speed-range');
  slider.style.setProperty('--full-stop', `${full / 2 * 100}%`);
  slider.style.setProperty('--zero-stop', `${zero / 2 * 100}%`);
  document.querySelector('#speed-range-curve-line').setAttribute('d', `M0 22 H${full * 300} L${zero * 300} 72 H600`);
  document.querySelector('#speed-range-curve-fill').setAttribute('d', `M0 72 V22 H${full * 300} L${zero * 300} 72 H600 Z`);
  document.querySelector('#speed-range-curve-title').textContent = `Full speed credit through ${full.toFixed(2)} frame, decreasing to zero at ${zero.toFixed(2)} frame.`;
  roundForm.elements.full_speed_frame_fraction.setAttribute('aria-valuetext', `${full.toFixed(2)} frame, ${ms(fullCredit)} milliseconds, full speed credit`);
  roundForm.elements.zero_speed_frame_fraction.setAttribute('aria-valuetext', `${zero.toFixed(2)} frame, ${ms(budget)} milliseconds, zero speed credit`);
}

function showRoundMessage(message, error = false) {
  roundMessage.textContent = message;
  roundMessage.dataset.error = String(error);
}

function updateRoundButton() {
  startRoundButton.disabled = !roundServiceAvailable || roundSubmitting || roundRunning;
  startRoundButton.textContent = roundRunning
    ? `Round ${roundNumber ?? '…'} running…`
    : `Start Round ${roundNumber ?? '…'}`;
  for (const field of roundFields()) field.disabled = roundRunning || roundSubmitting;
}

function applyRoundState(state) {
  const reconnected = roundConnectionLost;
  roundConnectionLost = false;
  if (typeof updateLeaderContexts === 'function') updateLeaderContexts(state.leader_contexts ?? []);
  familyCandidateCounts = state.family_candidate_counts ?? familyCandidateCounts;
  retainedCandidateCount = state.retained_candidate_count ?? retainedCandidateCount;
  roundServiceAvailable = state.mode === 'agent_guided' && state.agent_readiness?.ready === true;
  roundRunning = state.state === 'running';
  if (roundRunning || state.state === 'failed' || state.state === 'completed') document.dispatchEvent(new CustomEvent('round-workflow-state', { detail: state }));
  roundNumber = roundRunning ? (state.round ?? state.next_round) : state.next_round;
  const familySignature = JSON.stringify(state.families);
  if (Array.isArray(state.families) && familySignature !== familyOptionsSignature) {
    const selected = roundFamily.value;
    roundFamily.replaceChildren(...state.families.map(family => new Option(family.label, family.value)));
    roundFamily.value = state.families.some(family => family.value === selected) ? selected : 'all';
    familyOptionsSignature = familySignature;
  }
  if (!roundDefaultsLoaded) {
    if (Array.isArray(state.datasets)) renderDatasets(state.datasets, state.defaults?.datasets);
    for (const [name, value] of Object.entries(state.defaults ?? {})) {
      const field = roundForm.elements.namedItem(name);
      if (field && name !== 'datasets') field.value = name === 'jaw_weight' ? Number(value) * 100 : value;
    }
    const fps = state.defaults.target_fps ?? 60;
    roundForm.elements.target_fps.value = fps;
    roundForm.elements.full_speed_frame_fraction.value = state.defaults.full_speed_frame_fraction ?? state.defaults.full_speed_ms / (1000 / fps);
    roundForm.elements.zero_speed_frame_fraction.value = state.defaults.zero_speed_frame_fraction ?? state.defaults.frame_budget_ms / (1000 / fps);
    roundDefaultsLoaded = true;
    updateSplitSummary();
    updateFitnessEquation();
    scheduleResearchPreview();
  }
  const progress = Math.max(0, Math.min(1, Number(state.progress) || 0));
  if (typeof updateCandidateEvaluations === 'function') updateCandidateEvaluations(state.evaluation_views ?? []);
  if (typeof updatePhoneBenchmark === 'function') updatePhoneBenchmark(state.phone_timing ?? null);
  if (typeof updateLaptopNativeBenchmark === 'function') updateLaptopNativeBenchmark(state.laptop_native_timing ?? null);
  roundProgressWrap.hidden = !roundRunning;
  roundProgress.value = progress;
  roundProgressLabel.value = `${Math.round(progress * 100)}%`;
  if (state.state === 'failed') {
    showRoundMessage(state.message || 'The round failed. Review the server output before retrying.', true);
  } else if (roundRunning) {
    showRoundMessage(state.message || 'Preparing the selected candidates…');
  } else if (state.state === 'completed' && state.result) {
    const key = JSON.stringify([state.id ?? '', state.result]);
    if (key !== latestRoundResult || roundMessage.dataset.error === 'true') {
      showRoundMessage('');
      latestRoundResult = key;
    }
  } else if (!roundSubmitting) {
    showRoundMessage(roundServiceAvailable ? '' : state.agent_readiness?.message || 'Agent workflow service is not ready.');
  }
  updateRoundButton();
  updateAgentCounts();
  if (reconnected) scheduleResearchPreview();
}

async function readRoundResponse(response) {
  let body;
  try {
    body = await response.json();
  } catch {
    throw new Error('Round controls need the RSI dashboard server. The current server only serves files.');
  }
  if (!response.ok) throw new Error(body.error || body.message || `Round request failed (${response.status}).`);
  return body;
}

async function refreshRoundState() {
  try {
    const state = await readRoundResponse(await fetch('/api/round', { cache: 'no-store' }));
    applyRoundState(state);
  } catch (error) {
    roundServiceAvailable = false;
    roundConnectionLost = true;
    showRoundMessage(error instanceof TypeError
      ? 'Cannot reach the local experiment server. Reconnecting…'
      : error.message || 'The round service is unavailable.', true);
    updateRoundButton();
  } finally {
    window.setTimeout(refreshRoundState, 1000);
  }
}

function roundSettings() {
  const settings = Object.fromEntries(roundFields().filter(field => field.name !== 'datasets').map(field => [field.name,
    ['family', 'agent_prompt'].includes(field.name) ? field.value : Number(field.value)]));
  settings.datasets = selectedDatasets();
  settings.jaw_weight /= 100;
  settings.full_speed_ms = settings.full_speed_frame_fraction * (1000 / settings.target_fps);
  settings.frame_budget_ms = settings.zero_speed_frame_fraction * (1000 / settings.target_fps);
  settings.target_basis = 'validation';
  settings.mode = 'agent_guided';
  return settings;
}

let researchTimer;
let researchRequest;
function scheduleResearchPreview() {
  clearTimeout(researchTimer);
  researchRequest?.abort();
  researchTimer = setTimeout(refreshResearchPreview, 250);
}

async function refreshResearchPreview() {
  const request = new AbortController();
  researchRequest = request;
  const state = document.querySelector('#research-status');
  state.textContent = 'Updating the prompt preview…';
  try {
    const response = await fetch('/api/round/preview', {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(roundSettings()), signal: request.signal,
    });
    const disclosure = await readRoundResponse(response);
    if (request.signal.aborted) return;
    const entries = [
      ['Harness', disclosure.harness], ['Configured tools', disclosure.tools.join(' · ')],
      ['Permissions and configuration', disclosure.permissions],
      ['Project instructions', disclosure.instructions.join(' · ')],
      ['Saved evidence', disclosure.artifacts],
    ];
    document.querySelector('#research-harness').replaceChildren(...entries.flatMap(([label, value]) => {
      const heading = document.createElement('dt');
      heading.textContent = label;
      const text = document.createElement('dd');
      text.textContent = value;
      return [heading, text];
    }));
    document.querySelector('#research-prompt').textContent = disclosure.prompt;
    state.textContent = disclosure.preview_note;
  } catch (error) {
    if (!request.signal.aborted) {
      state.textContent = error.message;
      document.querySelector('#research-prompt').textContent = '';
      document.querySelector('#research-harness').replaceChildren();
    }
  }
}

document.addEventListener('input', event => {
  if (event.target.form !== roundForm) return;
  constrainSpeedHandles(event.target);
  updateAgentCounts();
  updateSplitSummary();
  updateFitnessEquation();
  if (typeof updateCandidateEvaluations === 'function') updateCandidateEvaluations(evaluationViews);
  scheduleResearchPreview();
});
roundForm.addEventListener('submit', async event => {
  event.preventDefault();
  updateFitnessEquation();
  if (!roundForm.reportValidity() || roundSubmitting || roundRunning) return;
  const settings = roundSettings();
  roundSubmitting = true;
  showRoundMessage('Starting the selected round…');
  updateRoundButton();
  try {
    const state = await readRoundResponse(await fetch('/api/round', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(settings),
    }));
    applyRoundState(state);
  } catch (error) {
    showRoundMessage(error.message, true);
  } finally {
    roundSubmitting = false;
    updateRoundButton();
  }
});

const speedRange = document.querySelector('#speed-range');
let draggedSpeedHandle;
function moveSpeedHandle(event) {
  if (!draggedSpeedHandle || draggedSpeedHandle.disabled) return;
  const rect = speedRange.getBoundingClientRect();
  const value = Math.max(0.01, Math.min(2, (event.clientX - rect.left - 11) / (rect.width - 22) * 2));
  draggedSpeedHandle.value = (Math.round(value * 100) / 100).toFixed(2);
  draggedSpeedHandle.dispatchEvent(new Event('input', { bubbles: true }));
}
speedRange.addEventListener('pointerdown', event => {
  if (event.target.tagName === 'INPUT' || roundRunning || roundSubmitting) return;
  const rect = speedRange.getBoundingClientRect();
  const value = (event.clientX - rect.left - 11) / (rect.width - 22) * 2;
  const full = roundForm.elements.full_speed_frame_fraction;
  const zero = roundForm.elements.zero_speed_frame_fraction;
  draggedSpeedHandle = Math.abs(value - Number(full.value)) < Math.abs(value - Number(zero.value)) ? full : zero;
  draggedSpeedHandle.focus({ preventScroll: true });
  speedRange.setPointerCapture(event.pointerId);
  moveSpeedHandle(event);
});
speedRange.addEventListener('pointermove', moveSpeedHandle);
speedRange.addEventListener('pointerup', () => { draggedSpeedHandle = null; });
speedRange.addEventListener('pointercancel', () => { draggedSpeedHandle = null; });

updateFitnessEquation();
refreshRoundState();

const parameterHelp = {
  family: 'All families produces one child for every current pool candidate. A specific family evolves all candidates in that scope, including evaluated proposals available for re-entry. New Family runs research only.',
  clip_limit: 'Maximum recordings included before the random split. Zero includes all clips from the checked datasets.',
  pool_size: 'Maximum survivors retained after this round, up to ten. Every current pool member first produces a child. Reducing this limit shrinks the next pool and therefore the following rounds’ reproduction count.',
  jaw_weight: 'Percentage of fitness assigned to jaw event F1. Speed receives the remaining percentage.',
  protected_slots: 'Maximum exploration lineages temporarily retained to get more mutation opportunities. Zero disables protection. At most one fresh proposal gains protection per round; the effective limit leaves one pool slot for the champion. Entry favors underrepresented families, then complementary clip performance, then fitness.',
  mutation_attempts: 'Protection expires after this many actual children are evaluated. Every current pool member receives one child per completed ordinary All families round, so low-ranked protected lineages receive their mutation opportunities too. Family-scoped checks can exclude a lineage.',
  family_limit: 'Preferred maximum per family; exceptions keep champions, protected candidates, specialists, or a full pool.',
  target_f1: 'Desired jaw-event F1 on validation clips. Training accuracy does not satisfy this goal.',
  seed: 'Reproduces the clip shuffle and stochastic candidate choices. Use the same seed to compare runs on the same split.',
  match_seconds: 'Maximum timing error allowed when matching a squeeze or release to a button cue of the same type. Extra detections count as false positives.',
  full_speed_frame_fraction: 'Fraction of one frame interval allowed for full speed credit. 0.25 means 25% of a frame. Drag the left dot. Slower p95 reduces the speed contribution until the selected zero-credit fraction.',
  zero_speed_frame_fraction: 'Detector p95 in frame fractions at which speed credit reaches zero. At 60 fps, 1.0 frame is 16.67 ms. Drag the right dot to change this bound.',
  target_fps: 'Automatically derived and hidden when selected datasets share one nominal source rate. Rates within 5% of 60 fps count as 60. For mixed or unknown rates, choose the scoring frame-rate basis; this does not resample videos.',
};
for (const field of roundFields()) {
  if (parameterHelp[field.name]) {
    const label = field.closest('label') ?? document.querySelector(`label[for="${field.id}"]`);
    if (label) label.dataset.help = parameterHelp[field.name];
    field.setAttribute('aria-description', parameterHelp[field.name]);
  }
}
document.querySelector('#speed-weight').closest('label').dataset.help = 'The remaining fitness percentage, calculated as 100 minus the jaw weight. Speed credit saturates below the full-credit budget.';
