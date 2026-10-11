import "./style.css";
import { logoutAdmin } from "./admin-session";

const root = document.querySelector<HTMLDivElement>("#app");
if (!root) throw new Error("App root missing");

root.innerHTML = `
  <main class="shell">
    <div class="admin-toolbar">
      <h1>Admin dashboard</h1>
      <button id="logout" type="button">Logout</button>
    </div>
    <p id="logout-feedback" role="alert"></p>
    <section class="panel onboarding" aria-labelledby="invites-title">
      <h2 id="invites-title">Invitations & installations</h2>
      <p>Create a single-use code and share it privately. Credentials are unique per installation.</p>
      <form id="invite-form">
        <label>Tester label <input name="label" maxlength="80" required></label>
        <label>Expires in hours <input name="hours" type="number" min="1" max="168" value="24" required></label>
        <label>Upload quota (MiB)
          <input id="quota-mib" name="mib" type="number" min="1" max="102400" value="1024" aria-describedby="video-estimate" required>
          <small id="video-estimate" aria-live="polite"></small>
        </label>
        <label>Upload count <input name="uploads" type="number" min="1" max="10000" value="100" required></label>
        <button type="submit">Create invite</button>
      </form>
      <div id="new-code" hidden>
        <p>Copy now: this code is shown only once. Closing or reloading this page hides it.</p>
        <code id="invite-code"></code>
        <button id="copy-code" type="button">Copy code</button>
        <button id="dismiss-code" type="button">Hide code</button>
      </div>
      <p id="invite-feedback" role="status" aria-live="polite"></p>
      <button id="refresh-access" type="button">Refresh access lists</button>
      <h3>Recent invitations</h3><ul id="invites-list"></ul>
      <h3>Recent installations</h3><ul id="installations-list"></ul>
      <p>Revoke an unused invite to stop enrollment. Revoke an installation to stop its access.
      </p>
    </section>
  </main>
`;

type Invite = { id: string; label: string; expires_at: string; redeemed_at: string | null; revoked_at: string | null };
type Installation = { id: string; installation_name: string; revoked_at: string | null; used_bytes: number; quota_bytes: number; used_uploads: number; quota_uploads: number };
const feedback = document.querySelector<HTMLParagraphElement>("#invite-feedback")!;
const form = document.querySelector<HTMLFormElement>("#invite-form")!;
const codePanel = document.querySelector<HTMLDivElement>("#new-code")!;
const codeElement = document.querySelector<HTMLElement>("#invite-code")!;

const quotaInput = document.querySelector<HTMLInputElement>("#quota-mib")!;
const videoEstimate = document.querySelector<HTMLElement>("#video-estimate")!;
function updateVideoEstimate(): void {
  const mib = quotaInput.valueAsNumber;
  if (!quotaInput.value || !quotaInput.validity.valid || !Number.isFinite(mib)) {
    videoEstimate.textContent = "Enter a valid quota to estimate videos.";
    return;
  }
  // The quota is binary MiB; the assumed video size is decimal MB.
  const videos = Math.floor(mib * 1048576 / 5_000_000);
  videoEstimate.textContent = `≈ ${videos.toLocaleString()} videos at 5 MB each; upload count also applies.`;
}
quotaInput.addEventListener("input", updateVideoEstimate);
quotaInput.addEventListener("change", updateVideoEstimate);
updateVideoEstimate();

const logoutButton = document.querySelector<HTMLButtonElement>("#logout")!;
const logoutFeedback = document.querySelector<HTMLParagraphElement>("#logout-feedback")!;
logoutButton.addEventListener("click", async () => {
  logoutButton.disabled = true;
  logoutFeedback.textContent = "Logging out…";
  try {
    await logoutAdmin(fetch, path => {
      codeElement.textContent = "";
      codePanel.hidden = true;
      window.location.replace(path);
    });
  } catch {
    logoutFeedback.textContent = "Could not confirm logout. Check your connection and retry.";
    logoutButton.disabled = false;
  }
});

async function adminApi<T>(path: string, body?: unknown): Promise<T> {
  const response = await fetch(`/api/v1/admin/${path}`, {
    method: body === undefined ? "GET" : "POST", credentials: "same-origin",
    cache: "no-store", redirect: "error",
    headers: { "Content-Type": "application/json", "X-TMT-Admin": "1" },
    body: body === undefined ? undefined : JSON.stringify(body),
  });
  if (response.status === 401) throw new Error("Admin session expired. Open /unlock to sign in again.");
  if (!response.ok) throw new Error(`Request failed (${response.status}). Check the form or retry.`);
  return response.status === 204 ? undefined as T : await response.json() as T;
}

function revokeButton(path: string, refresh: () => Promise<void>): HTMLButtonElement {
  const button = document.createElement("button");
  button.type = "button"; button.textContent = "Revoke";
  button.addEventListener("click", async () => {
    if (!window.confirm("Revoke this access? This cannot be undone; a new invite will be needed.")) return;
    button.disabled = true;
    try { await adminApi(path, {}); await refresh(); feedback.textContent = "Access revoked."; }
    catch (error) { feedback.textContent = String(error); button.disabled = false; }
  });
  return button;
}

async function refreshLists(): Promise<void> {
  const [invites, installations] = await Promise.all([
    adminApi<Invite[]>("invites"), adminApi<Installation[]>("installations"),
  ]);
  const inviteList = document.querySelector<HTMLUListElement>("#invites-list")!;
  const installationList = document.querySelector<HTMLUListElement>("#installations-list")!;
  inviteList.replaceChildren(); installationList.replaceChildren();
  for (const invite of invites) {
    const item = document.createElement("li");
    const state = invite.revoked_at ? "Revoked" : invite.redeemed_at ? "Redeemed" : Date.parse(invite.expires_at) <= Date.now() ? "Expired" : "Available";
    item.textContent = `${invite.label} · ${state} · expires ${new Date(invite.expires_at).toLocaleString()} `;
    if (state === "Available") item.append(revokeButton(`invites/${invite.id}/revoke`, refreshLists));
    inviteList.append(item);
  }
  for (const installation of installations) {
    const item = document.createElement("li");
    item.textContent = `${installation.installation_name} · ${installation.id} · ${installation.revoked_at ? "Revoked" : "Active"} · ${installation.used_uploads}/${installation.quota_uploads} uploads · ${(installation.used_bytes / 1048576).toFixed(1)}/${(installation.quota_bytes / 1048576).toFixed(1)} MiB `;
    if (!installation.revoked_at) item.append(revokeButton(`installations/${installation.id}/revoke`, refreshLists));
    installationList.append(item);
  }
}

form.addEventListener("submit", async (event) => {
  event.preventDefault();
  if (!codePanel.hidden) { feedback.textContent = "Copy and hide the current code before creating another."; return; }
  const data = new FormData(form);
  const button = form.querySelector<HTMLButtonElement>('button[type="submit"]')!;
  button.disabled = true; feedback.textContent = "Creating invite…";
  try {
    const invite = await adminApi<{ invite_code: string }>("invites", {
      label: String(data.get("label")).trim(), expires_in_hours: Number(data.get("hours")),
      quota_bytes: Number(data.get("mib")) * 1048576, quota_uploads: Number(data.get("uploads")),
    });
    codeElement.textContent = invite.invite_code; codePanel.hidden = false;
    feedback.textContent = "Invite created. Share privately with the intended tester.";
    await refreshLists();
  } catch (error) { feedback.textContent = `${String(error)} If the response was lost, an invite may have been created; check the list before retrying.`; }
  finally { button.disabled = false; }
});
document.querySelector("#dismiss-code")!.addEventListener("click", () => { codeElement.textContent = ""; codePanel.hidden = true; });
document.querySelector("#copy-code")!.addEventListener("click", async () => {
  try { await navigator.clipboard.writeText(codeElement.textContent || ""); feedback.textContent = "Copied. Share privately, then hide the code."; }
  catch { feedback.textContent = "Copy unavailable. Select the code and copy manually."; }
});
document.querySelector("#refresh-access")!.addEventListener("click", () => { void refreshLists().catch(error => { feedback.textContent = String(error); }); });
void refreshLists().catch(error => { feedback.textContent = String(error); });
