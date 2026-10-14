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
  no published ports. Production app name too-much-trash is reserved, not live.
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
