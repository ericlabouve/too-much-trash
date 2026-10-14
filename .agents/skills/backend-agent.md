---
name: backend-agent
description: Maintain Too Much Trash backend, admin portal, database migrations and deployment decisions; use for backend work and client/server coordination, not iOS implementation or CAD.
---

# Backend Agent

Update this file frequently when Eric states a preference, a decision changes, or
verification reveals a reusable constraint. Replace stale guidance rather than
accumulating contradictory history. Record durable facts, not secrets, temporary
invite codes, or unverified claims. Updating memory does not grant new authority.

## Ownership and workflow

- Backend owns `backend/`, the admin portal in `frontend/`, and related docs/config.
  Iphone Agent owns `ios/` and its memory. Both chats now share the96fa checkout;
  coordinate shared-file edits and serialize Git/branch/deployment operations.
  Exchange contracts/tests and stage explicit owned paths only. Earlier separate
  PRs6/7 were merged; do not assume independent branches in the shared checkout.
- Eric authorized two-way communication with Iphone Agent. Coordinate changes to
  API contracts and report blockers. This permission does not authorize deployment
  exposure, signing changes, new invitations, or merging PRs on its own.
- Use Alembic for DB versioning. At most one new revision file per PR; consolidate
  changes while a revision is unmerged. Never rewrite an applied, merged revision.
  Initial Postgres setup scripts are separate from application revision history.
- Test on Simulator for Eric's own review first; only afterward move to his
  personal iPhone. Simulator success is not camera/button/hardware validation.
- Keep answers concise. State outcomes and distinguish implemented, verified,
  planned and physically unvalidated behavior.

## Architecture and current decisions

- FastAPI/uv API, PostgreSQL, SeaweedFS blob storage, Prefect media worker, Caddy
  reverse proxy and admin portal. API migration startup is `alembic upgrade head`;
  credentials come from environment, not committed Alembic configuration.
- Invite-only access is our own authentication, not Apple App Attest. Admin
  creates short-lived single-use codes; enrollment issues installation-bound
  credentials; refresh, revocation, ownership checks and quotas protect media.
  A shared admin token gate is temporary; passkey enrollment/login remains work.
- Eric accepted two-word invites (22 bits) for the pilot on October11. Draw two
  independent uniform words with replacement from pinned official BIP39 English;
  repeats valid. Normalize only valid ASCII word pairs for case/whitespace;
  Eric later removed legacy-code/device-name UI: backend rejects opaque invites,
  retains historical records/enrolled credentials, and defaults omitted name to
  iPhone. Keep hashed storage, atomic one-time
  redemption, quotas, expiry, throttles and strong installation/admin secrets.
  Bound collision retries across all historical hashes; never reuse a pair.
  This risk acceptance is not permission for public exposure or minting live codes.
- October12: enrollment admits max3 requests per rolling60 seconds globally,
  reserved in middleware before JSON/Pydantic validation. Invalid/expired/used
  words and malformed requests reaching API consume permits; fourth gets429 with
  rounded-up Retry-After until oldest permit expires. Blocked retries don't extend
  cooldown. DB clock/advisory lock and namespaced existing rate-limit table rows
  share state across processes without another migration. Login/refresh limits
  unchanged. Three attempts can deny registration to all users temporarily;
  do not describe this as per-device protection or bypass via forwarded IP.
- Admin dashboard Logout uses existing DELETE `/api/v1/admin/session`, returns
  to `/unlock` only after204, and reports failure without claiming success.
  This clears that browser's cookie; it does not revoke copied stateless cookies
  or implement per-admin offboarding. Eric deferred authn/authz redesign.
- Collector End Session is separate: POST `/auth/end-session` with current
  refresh_token ->200 {installation_id,revoked:true}. Revokes only that secret's
  installation; accepts known expired/revoked secrets for acknowledgement retry
  only. Native confirms identity before cleanup and retains secret/journal on
  uncertainty. Backend originals are retained.
- Automatic media contract1 is advertised by authenticated `/auth/me`.
  POST `/media` uses Idempotency-Key=stable capture UUID; exact retries202,
  lookup `/media/by-client/{UUID}`200, conflict409 on changed bytes/name/type.
  One quota charge per installation/client UUID, serialized with End Session by
  owner row lock. No migration: frozen uuid5 mapping and client/SHA256 metadata in
  original_key. Never delete keyed blobs on uncertain DB failure (could erase a
  committed retry). Missing version1 blocks native automatic retries.
- Keep the admin dashboard compact: only "Admin dashboard", Logout, and the
  "Invitations & installations" card with its controls. No promotional hero,
  workspace, footer or frontend health polling. Public website is separate.
- Hide redeemed/revoked invitations and revoked installations by default.
  History disclosure text is exactly Expand(count), with aria-expanded state.
  Preserve choices during refresh/revoke; expired unused invites remain visible.
  No "Use Show revoked" helper text; installation primary label comes from the
  invitation tester_label, not UUID. Never delete history or alter authorization.
- Show a live storage-only video estimate beside quota, assuming decimal 5 MB
  per video: floor(quotaMiB * 1048576 / 5000000). Upload count remains its own
  limit; do not imply storage estimate grants more uploads.
- Unlock token visibility stays hidden by default, uses an accessible eye toggle,
  preserves autofilled text and re-masks on submit. Test with dummy values only;
  never reveal real secrets in screenshots/logs. Dev and pilot tokens differ;
  wrong saved token or trailing newline can cause invalid-token responses.
- October12: a missing pilot eye toggle was stale Caddy content, not a token
  mismatch within that stack. Rebuild/redeploy both API and Caddy when verifying
  paired admin changes. Each stack's token matches its own mounted hash; never
  share tokens across stacks. Switching native origins selects separate saved
  credentials, not End Session; verify the original origin before re-enrolling.
- Eric confirmed Safari autofill added trailing whitespace. Trim only outer
  whitespace from the generated admin token on client submission; preserve all
  internal characters. This is not a normalization rule for arbitrary passwords.
- Current laptop development uses the active Compose app-node overlay, preserving
  localhost8082 collector and serving the same backend through
  too-much-trash-eric-dev.mongoose-bonito.ts.net HTTPS10000 collector/8443 admin.
  Node is tagged tmt-dev-eric and all its Funnel ports are OFF. One Docker project
  too-much-trash; node name isn't a second backend stack. macOS host Serve routes
  remain temporarily during the explicit client-origin transition, not as the new
  recommended phone endpoint. Admin stays private/Secure; storage/workflows have
  no published ports. Production app node too-much-trash is now live on the mini
  (October14 CD checkpoint below).
- Current host is Eric's MacBook Pro; future host is his Mac mini, with a different
  service FQDN. Clients configure origins; do not silently adopt old queued media
  or credentials across origins. Preserve normal TLS verification.
- Eric's October 11 testing order: co-test no-Tailscale local development, then
  Tailscale mode, then personal iPhone. Local mode is Debug+Simulator-only.
  `compose.dev.yaml` uses project `too-much-trash-dev`, loopback18082 collector,
  18081 admin and18080 website, independent volumes/network/credentials from
  `.secrets/dev/compose.env`. Only the isolated dev API allows HTTP admin cookies;
  never change the pilot's Secure cookies to make local login work. Auth/invites
  remain required. Do not issue new native-test invites without approval.
- October12 clarification supersedes the intended two-stack laptop design above:
  Eric wants ONE development Compose stack on the laptop, reached over localhost
  by Simulator and private Tailscale HTTPS by his physical iPhone. Both routes
  target the same API/database/media, not separate dev and pilot environments.
  Production does not exist yet; it will be a separate stack on the Mac mini,
  possibly deployed through GitHub Actions. Admins may test either environment;
  ordinary users should reach production only. Keep development private through
  network/access controls, not merely a hidden endpoint selector. Production admin
  remains private; public collector exposure still needs explicit authorization.
  The retired project's data/credentials are historical state to preserve.
  Do not delete volumes or merge
  credentials implicitly. Distinguish environment identity from localhost versus
  Tailscale transport; preserve security and origin checks when designing shared
  sessions/queues. Never weaken production HTTPS/cookie security for Simulator.
- October12 authorized consolidation executed: keep `too-much-trash`; removed
  `too-much-trash-dev` containers and network via explicit project down WITHOUT
  volume deletion. All four retired volumes and ignored credentials remain for
  recovery. Retained stack was not restarted and API/Postgres stayed healthy.
  Simulator must support localhost8082 AND private Tailscale HTTPS10000; physical
  iPhone always Tailscale. Admin uses private HTTPS8443 to preserve Secure cookies.
  Old native localhost18081/18082 defaults need iPhone-owned follow-up; never
  pretend retired credentials enroll the retained stack or move queues implicitly.
  Each future developer runs ONE private stack on their Mac with unique Tailscale
  endpoints, separate local secrets/data, and per-user/device network grants.
- October12 CLI/admin-console review: laptop Serve is HTTPS10000->loopback8082,
  HTTPS8443->loopback8081, no Funnel. Mac mini at
  erics-mac-mini.mongoose-bonito.ts.net is online but user-owned/untagged; existing
  policy grants group:admin (Eric) all ports to tag:mac-mini and tag:tenant, plus
  tag:tenant Funnel capability and mac-mini SSH check rules. No developer self
  access exists. Proposed developer group->autogroup:self tcp8443/tcp10000,
  keeping laptops/phones user-owned, and tagging dedicated production server
  with existing tag:mac-mini. Existing infrastructure rules are not authorization
  to expose/deploy production; policy changes remain pending explicit approval.
- Eric confirms Mac mini is physically on a separate router/network and that
  current tailnet policy originated in another project. Tailscale metadata shows
  only the mini's own overlay addresses, no advertised subnet routes; this does
  not independently verify the physical router topology. Keep that network
  separation: no subnet routing/site-to-site bridging needed for app access.
  Project-specific group/tag cleanup is proposed, not yet applied. Check legacy
  consumers before removing tenant/Funnel or management rules; coordinate any
  machine DNS rename with client configuration and Serve/certificate routes.
- October12 implementation supersedes the proposed user-owned self-access above:
  Eric approved per-stack app nodes. Saved policy defines group:tmt-admins and
  group:tmt-developers; only Eric->tag:tmt-dev-eric TCP8443/10000 for development,
  admins->tag:tmt-prod TCP8443/10000 for future prod app, and admins->tag:tmt-prod-host
  TCP22/3283/5900 for physical Mac mini management. Old tenant/Funnel/all-port rules
  retired after Eric confirmed old project retired. Mini now tag:tmt-prod-host,
  name unchanged; personal laptop/phone remain user-owned. Policy tests accepted
  on save. Each additional developer needs their own app tag and explicit grant;
  autogroup:self does not grant access to tagged sidecars.
- Eric explicitly approved production Funnel prep: saved nodeAttrs permits ONLY
  tag:tmt-prod Funnel; production.env.example selects serve.production.json with
  website443/API10000 public and admin8443 PRIVATE. Development serve.json keeps
  all false. No production app node/stack has been initialized; do not describe
  eligibility/configuration as an already-live public endpoint or deploy to mini
  under the network-configuration authorization alone.
- Node uses pinned tailscale/tailscale:v1.102.4, separate persistent Docker node
  state, userspace networking sharing Caddy and ignored .secrets/tailscale.env.
  No reusable auth key created. First interactive sign-in initially raced default
  60s containerboot deadline; TS_BOOT_TIMEOUT20m resolved it without deleting
  state. Retain that timeout for first login; never clone node state between
  instances. Four Compose checks and3 proxy checks eachlocalhost/newHTTPS passed;
  sidecar-only restart verified automatic reconnect with unchanged node ID/DNS/IPs
  and no interactive login. Docker confirms too-much-trash is the only backend
  project; the separate sam3 project is ML tooling, not another backend stack.
  Sidecar/API healthy. Iphone Agent completed matching localhost/app-node presets
  and mixed localhost-collector/HTTPS-admin gating; reported52 passing tests plus
  Debug-device/Release-Simulator builds. Saved origins/credentials/queues are not
  migrated. Eric's Simulator review and real iPhone path/capture remain pending.

## Verification and operational memory

- October14 selected V1 CD: GitHub-hosted ARM64 builds, GHCR digest-pinned images,
  and an automatic hosted deployment job using ordinary SSH over Tailscale to the
  Mac mini. No Arcane agent or self-hosted mini runner; no mini CI/build jobs.
  Eric is sole developer and deploys while present; laptop sleep is not a V1
  requirement. Eric said go and authorized existing/subsequent validation PRs
  to be pushed/merged until Docker backend CD is complete. Components:
  merge-to-main trigger with no separate deployment approval, main-only gate,
  scoped ephemeral Tailnet job
  identity/SSH key/host verification, serialized backup/migration/Compose rollout
  and health checks, failure/restore procedure and initial production bootstrap.
  Keep native SAM3/Cutie separate. Do not assume image rollback undoes a migration.
  Production public website/collector share443 (supersedes public10000 below);
  admin8443 remains private. Development10000 is unchanged. No success claim
  before hosted deployment verification. Native ML is not part of CD.
- October14 read-only main security audit: main is the public repository's default
  branch. Active ruleset24941839 blocks deletion/non-fast-forward updates only;
  no classic branch protection, PR/review requirement, bypass actors or CODEOWNERS
  on main. Only ericlabouve is a collaborator, with admin/write access; ordinary
  public visitors cannot push/merge. Direct pushes by authorized writers remain
  allowed at audit time. Eric subsequently authorized and activated ruleset25122035:
  PRs plus one approval, stale reviews dismissed, CODEOWNERS explicitly deferred,
  RepositoryRole5(admin) bypass only for PR merges. Original24941839 has no bypass
  and continues unconditional deletion/force-push blocking. Effective rules API
  verified all three requirements. Production must never execute untrusted PR code.
- October14 deployment bootstrap in progress: Eric separately approved auth_keys
  write restricted to tag:tmt-deploy and exact backend-cd workflow on main,
  SSH-only grant to tag:tmt-prod-host TCP22, and production node/Funnel443 creation.
  Saved tested policy includes that tag/grant; production admins443 replaces10000.
  GitHub's actual OIDC subject includes immutable IDs:
  repo:ericlabouve@15724471/too-much-trash@1389817769:ref:refs/heads/main
  plus exact workflow_ref claim; no OAuth shared secret. Public clientID/audience
  and verified SSH host key configured as GitHub variables, dedicated private
  SSH key configured as repository secret. No secret values in memory/logs.
  Mini ~/too-much-trash-prod has fresh independent private secrets; no invitations
  or copied dev data. Forced-command key denies shell/PTY/forwarding (tested).
  Fixed control/ receiver verifies merged-main ancestry and locks rollout.
  Initial Docker pull over SSH failed because docker-credential-desktop was not
  on noninteractive PATH; explicitly include Docker.app Resources/bin.
  PR9 merged as4dddf45 (commit54c5621); first hosted run38649082010 successfully
  built all three ARM64 images and published complete478-byte release.json.
  First deploy stopped at OIDC403 before host mutation: legacy name-only subject
  did not match ID-bound subject above. Exact correction retained all scopes/tags
  and workflow_ref; rerunning only failed deploy preserves release digests.
  Tailscale /view/ page is read-only despite editable-looking AX fields; changes
  there do not persist. Use credential Actions->Edit (/edit/), then Save, reload
  and expand the list to verify stored subject. Second retry preceded the actual
  edit and failed too; third retry follows verified persistence.
  Dedicated temporary node-bootstrap container removed before Compose ownership;
  node state volume remains. Eric explicitly approved Google sign-in for his
  existing account; browser confirmed production too-much-trash node authorized.
  Third hosted retry passed OIDC but stopped before pulling/host mutation:
  isolated DOCKER_CONFIG hides Desktop's user-installed Compose plugin. Verified
  cliPluginsExtraDirs restores v5.0.2 without copying host registry credentials;
  follow-up validation PR adds this and backup-failure recovery coverage.
  PR10/11 merged plugin fix, safe diagnostic categories, and disposable restore
  utility. Subsequent host login failed before any mutation: docker login auto-
  detects the macOS credential helper, unusable from unattended SSH. Use only the
  expiring job token in a mode-private temporary config auths entry, preserving
  cliPluginsExtraDirs; remove config on exit and never copy host Keychain auth.
  Ten CD unit/config checks pass; first production rollout still pending.
  Registry workaround verified by hosted run38651246877: all images pulled,
  Postgres/blob healthy, Alembic003_onboarding applied with0 captures/installations.
  Rollout blocked at bucket probe: plain Python lacks uv-managed application
  packages. `uv run --no-sync python` imports/read-only bucket check passed on
  mini; no new revision needed. Preserve failed recovery marker before explicit
  operator resume, never automatically ignore it. Public Funnel checks must run
  on a separate no-VPN hosted job: Tailscale action enables DNS by default and
  deployment tag intentionally cannot reach private app443/8443.
  First complete hosted CD run38651734607 passed at main b5666e1: three ARM64
  builds, GHCR release, forced SSH rollout, Alembic and independent no-VPN public
  verification all succeeded. Production node too-much-trash.mongoose-bonito.ts.net
  is Running/tag:tmt-prod, Funnel443 true/admin8443 false. Actual sidecar needed
  reauthorization while online because the stopped bootstrap had not persisted
  the authorization response; the same node/IP was retained, not duplicated.
  All7 production containers running; sampled idle aggregate~0.69GiB (not peak,
  excludes Docker VM/macOS/native ML). Private admin probe from laptop HTTPS8443
  passed normal TLS. Bounded synthetic image/video Prefect/S3 poster processing
  passed and removed only its generated source/poster objects; no invitations or
  installation/capture records created. Native ML/iPhone validation still pending.
- October14 Arcane retirement executed at Eric's request: removed only the
  tmt-arcane-trial manager/socket-proxy containers and management network. Retained
  two trial named volumes and ignored credentials for recovery; main backend's
  seven services remain running with API/Postgres/Tailscale healthy. Arcane source
  remains historical trial tooling, not the selected deployment architecture.
- October14 final compute decision supersedes the earlier shared-CI acceptance:
  reserve the Mac mini for production backend and ML inference. Do not register
  it as a GitHub Actions CI runner; CI setup/execution is deferred for now, not
  local verification or deployment smoke checks. The selected deployment design
  is recorded above; do not install a mini runner. Inspect combined
  model/processing/backend/VM/OS peaks before
  claiming enough memory. macOS SSH user is ericlabouve. No runner/production
  deployment has been configured yet. Eric confirmed SAM2 was a typo: the models
  are SAM3 plus Cutie. Quoted7GB is not a verified combined host peak.
- Eric prefers portable container-based CD over a custom launchd deployment job.
  SAM3/Cutie will run natively on macOS. GitHub Actions plus SSH is now selected;
  implementation is authorized/in progress. Earlier comparison of existing controllers
  led to a laptop-only Arcane read-only trial (single manager/SQLite, ARM64,
  Git pull and failure-blocking predeploy hooks), now retired. No persistent
  bespoke deployment daemon, Arcane agent or mini runner is planned.
  Komodo adds Core/Periphery/database;
  Rust alone does not prove lowest RAM. Dockhand currently uses BSL with production
  restrictions, not an unrestricted open-source license. Reverify versions/licenses
  when selecting. Build/publish is proposed on GitHub-hosted ARM64 Linux, not the
  mini. CD must consume complete immutable releases, serialize backup/migration/
  rollout/checks, preserve volumes/secrets and avoid updating its controller mid-
  deployment. Docker still needs host startup supervision; native ML lifecycle is
  separately managed. Domain-specific migration/backup hooks are still needed.
- October14 laptop Arcane trial: ops/arcane uses manager:v2.16.0 and documented
  wollomatic/socket-proxy:1.13.1, project tmt-arcane-trial. Loopback3552 only,
  independent SQLite/project volumes, no existing backend files/volumes imported.
  Proxy permits read methods only; tested Docker GET200/POST405. No manager direct
  socket, no published proxy port, analytics disabled. Unique password stored in
  ignored .secrets/arcane-trial/compose.env; default login rejected. Use session
  auth for check_trial.py, no static admin API key configured. Four auth/inventory
  checks and three read-only configuration tests pass; dashboard visually verified.
  Initial manager145.7MiB/proxy10.2MiB, later dashboard sample270.7/12.1MiB;
  these are laptop snapshots excluding VM and optional hook/scan/backup peaks.
  Main backend and mini untouched. Git deployment/hooks/backup-restore/passkeys/
  notifications are documented candidates, not verified by this read-only trial.
  On Docker Desktop, shown resource limits describe Linux VM, not native host or
  MPS jobs. Arcane infrastructure auth does not authenticate the TMT admin API.
  Avoid auto patch/prune/heal/tag updates outside digest-pinned release workflow.
- October14 read-only Mac mini capacity audit over operator-authenticated SSH:
  Apple M4 / Mac16,10,16GiB unified RAM. Data volume available357.4GiB (~383.8GB).
  Docker engine has7.65GiB usable VM memory/10 CPUs; no running containers or
  images, ~7.73GB build cache. Docker.raw is sparse (~460GiB apparent/~9.9GiB
  allocated), not an additional460GiB of free physical disk. Host snapshot:
  ~13GiB used/~2.4GiB unused, including caches; zero swap. Virtualization process
  RSS~1.13GiB; Ollama/openclaw-gateway also running, not stopped by this audit.
  Existing laptop backend's seven containers total~0.80GiB idle, excluding VM
  overhead; not a measured production load budget. ML agent's quoted allocations
  are input estimates, not a simultaneous SAM3/Cutie/CI benchmark on this mini.
  Start with one inference job at a time and measure combined production peaks.
  CI on this host is now deferred. No resource settings were changed.
- October14 later request supersedes keeping Ollama: Eric requested uninstalling
  OpenClaw and stopping Ollama. OpenClaw service/app uninstaller succeeded, npm
  removed only global openclaw with ignore-scripts, and CLI/package/launch plist
  are verified absent. Preserved its1.7MiB state/workspace and launch plist in
  Mac mini Trash as OpenClaw-state-20261014 / ai.openclaw.gateway-20261014.plist;
  outside workspaces were not deleted. Ollama app/server terminated gracefully,
  verified absent; its software/models remain installed. Docker/Tailscale intact.
  Fresh top samples:2924/2942MiB unused (~2.87GiB), file-backed pages~6.30GiB,
  swap0. Unused RAM is not total allocatable RAM: caches may be reclaimed, while
  file-backed pages also include mapped files; do not label them all free.
  Eric intends remote subscription-backed LLM use instead of local Ollama;
  authentication/integration not verified or implemented here. SAM3/Cutie still
  need their own local runtime and memory; Ollama isn't their serving engine.
- Back up before live schema changes; test migrations on disposable databases
  first. Verify fresh initialized DB, legacy pilot adoption, repeated upgrade,
  version bookkeeping, and preservation of captures/invitations/ownership.
- API integration tests truncate tables: run only with an isolated DB and
  `TMT_TEST_ISOLATED=1`. Never run them against the live Compose database.
- Preserve volumes on rebuild/redeploy. Confirm migration exit0, API health,
  running image IDs and HTTPS route isolation. Do not infer worker processing
  success merely from a running container.
- Keep `.env`, `.secrets`, backups, invitations and credentials out of Git, build
  contexts and logs. Do not rotate tokens or issue live invites without authority.
- Verified pilot: backend ownership/quota/media processing over HTTPS; Simulator
  registration, Keychain reuse, private admin reachability and revoked-access
  rejection. Physical capture remains unverified; see the later native checkpoint.
- October11 user-led local Simulator two-word enrollment reached Field Camera;
  backend logs confirmed enroll201/me200 and one active installation. Do not
  revoke this user's installation as disposable agent-test cleanup. That checkpoint
  only verified enrollment; no credential/request-body inspection was needed.
- October12 approved real native Simulator test used one bounded temporary
  installation and synthetic MOV. Automatic upload/lost-ack lookup recovery,
  duplicate receipt and End Session local-file/Keychain cleanup passed. Backend
  independently verified one1538-byte charge/capture, revoked test installation,
  retained matching original and prior user installation still active. Physical
  capture and actual OS-suspended/force-quit completion remain separate checks.
  Remove private temporary fixtures after use; retain labelled backend audit/media.
- October12: Eric approved the UI but has not installed the app on a physical
  iPhone or confirmed camera functionality. Keep hardware testing pending;
  Simulator checks do not qualify real camera capture or volume-button events.
- Read `backend/onboarding.md` for the auth contract and verification details;
  `backend/README.md` for setup and `backend/compose.yaml` for deployed services.
