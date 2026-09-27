import "./style.css";

const root = document.querySelector<HTMLDivElement>("#app");
if (!root) throw new Error("App root missing");

root.innerHTML = `
  <main class="shell">
    <div class="eyebrow">TOO MUCH TRASH / FIELD STUDIO</div>
    <header>
      <div class="mark" aria-hidden="true">↗</div>
      <h1>Teach robots to pick up what we leave behind.</h1>
      <p>Collect real grasp attempts, learn from each outcome, and build toward cleaner shared spaces.</p>
    </header>
    <section class="panel" aria-labelledby="workspace-title">
      <div>
        <span class="section-label">WORKSPACE</span>
        <h2 id="workspace-title">A place for every pickup attempt</h2>
        <p>Capture, review, and learning tools will grow here as the first hardware prototypes take shape.</p>
      </div>
      <div class="status" role="status" aria-live="polite">
        <span class="status-dot"></span>
        <span id="api-status">Checking service…</span>
      </div>
    </section>
    <footer>Observe the approach. Mark the grasp. Learn from the outcome.</footer>
  </main>
`;

const status = document.querySelector<HTMLSpanElement>("#api-status");
const statusDot = document.querySelector<HTMLSpanElement>(".status-dot");

async function checkService(): Promise<void> {
  try {
    const response = await fetch("/api/v1/health", { cache: "no-store" });
    if (!response.ok) throw new Error("Service unavailable");
    if (status) status.textContent = "Service connected";
    statusDot?.classList.add("online");
  } catch {
    if (status) status.textContent = "Service offline";
  }
}

void checkService();
