const replayRound = document.querySelector("#replay-round");
const replayStatus = document.querySelector("#replay-status");
const replayControls = document.querySelector("#replay-controls");
const candidateSelect = document.querySelector("#replay-candidate");
const clipSelect = document.querySelector("#replay-clip");
const video = document.querySelector("#replay-video");
const eventRows = document.querySelector("#replay-events");
let replay;
let activeClip;
let videoRequest;
let videoURL;
let pendingSeek;

function jumpTo(time) {
  if (video.readyState >= 1) video.currentTime = time;
  else pendingSeek = time;
}

function eventRow(label, events, duration) {
  const row = document.createElement("div");
  row.className = "replay-event-row";
  const heading = document.createElement("strong");
  heading.textContent = label;
  const timeline = document.createElement("div");
  timeline.className = "replay-timeline";
  timeline.setAttribute("aria-hidden", "true");
  const timestamps = document.createElement("div");
  timestamps.className = "replay-timestamps";
  if (!events.length) timestamps.textContent = "No events";
  for (const [kind, time] of [...events].sort((a, b) => a[1] - b[1])) {
    const name = kind === "close" ? "Squeeze" : "Release";
    const timestamp = document.createElement("button");
    timestamp.type = "button";
    timestamp.dataset.kind = kind;
    timestamp.textContent = name + " · " + time.toFixed(3) + " s";
    timestamp.addEventListener("click", () => jumpTo(time));
    const marker = document.createElement("button");
    marker.type = "button";
    marker.tabIndex = -1;
    marker.className = "replay-marker";
    marker.dataset.kind = kind;
    marker.title = timestamp.textContent;
    marker.style.left = Math.min(100, Math.max(0, 100 * time / duration)) + "%";
    marker.addEventListener("click", () => jumpTo(time));
    timeline.append(marker);
    timestamps.append(timestamp);
  }
  row.append(heading, timeline, timestamps);
  return row;
}

async function loadClip(clip) {
  activeClip = clip;
  pendingSeek = undefined;
  videoRequest?.abort();
  const request = new AbortController();
  videoRequest = request;
  video.removeAttribute("src");
  video.load();
  if (videoURL) URL.revokeObjectURL(videoURL);
  videoURL = undefined;
  video.setAttribute("aria-label", clip.split + " " + clip.name);
  replayStatus.textContent = "Loading " + clip.name + "…";
  try {
    // Load the complete clip so seeking also works on static servers without byte ranges.
    const response = await fetch("replay/" + clip.video, { signal: request.signal });
    if (!response.ok) throw new Error(response.status);
    const file = await response.blob();
    if (request.signal.aborted) return;
    videoURL = URL.createObjectURL(file);
    video.src = videoURL;
  } catch {
    if (!request.signal.aborted) replayStatus.textContent = "This video could not be loaded.";
  }
}

function updateReplay() {
  const clip = replay.clips[Number(clipSelect.value)];
  if (activeClip !== clip) loadClip(clip);
  else if (video.readyState >= 1) replayStatus.textContent = "";
  const predictions = clip.predictions[candidateSelect.value];
  eventRows.replaceChildren(
    eventRow("Detected", predictions, clip.duration),
    eventRow("Button reference", clip.references, clip.duration)
  );
}

async function loadReplay() {
  try {
    const response = await fetch("replay/events.json", { cache: "no-store" });
    if (!response.ok) throw new Error(response.status);
    replay = await response.json();
    candidateSelect.replaceChildren(...replay.candidates.map((name) => new Option(name, name)));
    clipSelect.replaceChildren(...replay.clips.map((clip, index) => new Option(clip.split + " · " + clip.name, index)));
    const comparisonIndex = replay.clips.findIndex((clip) => clip.split === "Comparison");
    clipSelect.selectedIndex = Math.max(0, comparisonIndex);
    replayRound.textContent = "Round " + replay.round;
    updateReplay();
    replayControls.hidden = false;
  } catch {
    replayStatus.textContent = "Replay files are unavailable.";
  }
}

video.addEventListener("loadedmetadata", () => {
  replayStatus.textContent = "";
  if (pendingSeek !== undefined) {
    video.currentTime = pendingSeek;
    pendingSeek = undefined;
  }
});
video.addEventListener("error", () => {
  if (video.hasAttribute("src")) replayStatus.textContent = "This video could not be played.";
});
candidateSelect.addEventListener("change", updateReplay);
clipSelect.addEventListener("change", updateReplay);
document.addEventListener("jaw-replay-candidate", ({ detail }) => {
  if (!replay?.candidates.includes(detail)) {
    replayStatus.textContent = "Replay is unavailable for this candidate.";
    return;
  }
  candidateSelect.value = detail;
  updateReplay();
});
loadReplay();
