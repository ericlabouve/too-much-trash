# Invite-only onboarding — V1

Approved design, October 9, 2026. This is our own API authorization, **not Apple
App Attest** or a substitute for Apple's app signing/provisioning requirements.

![Approved onboarding diagram](../docs/assets/invite-only-onboarding.png)

## Trust boundaries

Collectors need no Tailscale client. They redeem an administrator-issued code
through the public API and store installation credentials in iOS Keychain.
The public Caddy listener rejects every `/api/v1/admin/*` route. The private
admin listener serves the portal and proxies admin endpoints to the same API
service. API containers must never be published directly.

The portal currently uses the existing **temporary shared admin token**, not a
passkey. Tailnet access is an additional gate, not administrator authentication.
Passkey enrollment, recovery and production admin identity remain separate work.
All hosted credential traffic requires HTTPS. Codes and credentials must never
appear in URLs, analytics, logs, UserDefaults, or committed configuration.

## Client contract

| Request | Body / authorization | Result |
| --- | --- | --- |
| `POST /api/v1/auth/enroll` | `invite_code`, optional `installation_name` (1–80 characters; default `iPhone`) | HTTP 201: `installation_id`, `access_token`, `refresh_token`, `token_type: Bearer`, `expires_in: 900`, `refresh_expires_in: 2592000` |
| `POST /api/v1/auth/token` | `refresh_token` | New access token, `token_type: Bearer`, `expires_in: 900` |
| `GET /api/v1/auth/me` | Bearer access token | Installation ID/name, `media_contract_version: 1`, quota and usage |
| `POST /api/v1/auth/end-session` | `refresh_token` | HTTP200 `{installation_id, revoked: true}`; safe repeat/lost-response retry |
| `POST /api/v1/media` | Bearer; multipart `file`; optional `Idempotency-Key: <client capture UUID>` | HTTP202 receipt for first or identical repeat |
| `GET /api/v1/media/by-client/{client_capture_id}` | Bearer | HTTP200 committed owner receipt, or404 |
| `GET /api/v1/media/{id}` | Bearer access token | Owner-only status and receipt |
| `GET /api/v1/media/{id}/{original,processed}` | Bearer access token | Owner-only asset; processed asset available after processing |

Invite redemption is transactional and single-use, including concurrent
requests. New invites use two independently random words from the pinned official
BIP-39 English list (2048 words, 22 bits); repeats and word order matter. These
are not wallet mnemonics and contain no checksum. Eric explicitly accepted this
small-pilot guessing risk on October 11, 2026. More outstanding invites increase
the probability that a guess matches any valid invite; revocation cannot prevent
first redemption by a guesser. Reassess before public rollout. Global enrollment
throttling admits at most3 attempts in any rolling60 seconds globally, not per
device; invalid requests consume this shared budget too.

Only hashes are stored. Word pairs accept case-insensitive ASCII words and
surrounding/repeated whitespace (including tabs/newlines), normalized to lowercase
`word word`. No typo, punctuation, prefix, hyphen or word-order correction is
performed. As requested later on October11, enrollment requires exactly two valid
words: old opaque invites are no longer redeemable. Historical rows are retained,
and already-enrolled access/refresh credentials are unaffected. The iOS form no
longer asks for a device name; omitting `installation_name` uses default `iPhone`.
Collisions against all historic invite hashes are retried at most16 times using
the DB unique constraint; no historic pair is reused. Exhaustion returns503
`invite_generation_unavailable`, not an invite.

Access/refresh credentials still contain at least256 random bits, and admin tokens
remain unchanged. Access expires after 15 minutes. Refresh credentials have a fixed
30-day lifetime and are reusable rather than rotated on each refresh. Revoking
an installation disables both immediately. A stolen refresh credential remains
usable until expiry or revocation; this scheme does not attest app identity.

Do not automatically retry enrollment: a lost successful response consumes the
invite. Ask the administrator to revoke the resulting installation and issue a
new invite. Uploads without an idempotency key can still create duplicates on
uncertain retries; automatic uploads must use the contract below.

Receipts contain `id`, `client_capture_id` (null for legacy), `status`, `filename`, `content_type`, `size_bytes`, `result`,
`error`, `status_url`, `original_url`, and `processed_url`. URLs are relative;
pending result/error/processed URL fields can be null. Status is `queued`,
`processing`, `completed`, or `failed`. The current worker creates previews/poster
frames, **not SAM3 masks**. Originals survive processing failures.

### Automatic uploads and End Session

Require authenticated `/auth/me` to advertise `media_contract_version: 1` before
automatic keyed uploads; an old API may silently ignore the new header. Persist
the capture UUID, origin, installation ID, original bytes, filename and content
type before first upload. Keep them identical on retry. Exact repeats return202
with the same capture identity, without another quota charge even when quota is
full. Mutable processing status/result may have advanced since the first receipt.
Changed bytes/name/type return409 `idempotency_conflict`; invalid UUIDs return422.
Lookup by client UUID returns200 after original storage and DB acceptance, or404
if not yet committed. Retry404 with the same key. Before marking synced, verify
the receipt echoes the local UUID and matches size/type/name. Sync means accepted
original plus committed receipt, not completed processing. Preserve already
confirmed legacy receipts; old unkeyed uploads cannot be retroactively deduplicated.

End Session authenticates solely with the current strong refresh secret. A known
secret remains accepted after expiry/already-revoked **only for revocation**, not
renewal. Unknown secrets return401 `refresh_invalid`. Every acknowledgement has
the same installation ID; compare it and `revoked:true` before local deletion.
On uncertainty retain the secret and ending journal for retry. Backend media is
retained. End Session and acceptance share the owner row lock: an already-locked
upload may commit before End returns; if End wins, a prevalidated upload is denied.
No new capture is accepted after confirmed revocation. Already-running downloads
are not forcibly terminated; previously downloaded data cannot be retracted.

No migration is needed. Keyed server IDs use the frozen mapping
`uuid5(NAMESPACE_URL, "too-much-trash:capture:<installation UUID>:<client UUID>")`;
clients treat IDs as opaque. The existing original_key stores client UUID/SHA256
metadata; worker keys remain opaque and old rows work unchanged. A keyed DB
failure can leave an orphan blob: never delete its deterministic key as
compensation, which could erase an accepted concurrent retry. Future orphan
collection must prove no accepted record references it. Durability relies on
configured blob/DB volumes, not an HA replication guarantee.

## Errors and client behavior

API errors normally use `{ "detail": { "code": "…", "message": "…" } }`.

| Status / code | Client action |
| --- | --- |
| 400 `invite_invalid` | Code is unknown, expired, used, or revoked; deliberately indistinguishable |
| 401 `access_invalid` | Refresh once, then retry the authenticated request once |
| 401 `access_revoked` | Do not refresh; show revoked access |
| 401 `refresh_invalid` | Re-enrollment required |
| 429 `rate_limited` | Respect `Retry-After`; no retry loop |
| 429 `quota_exceeded` | Retain local media and ask administrator for help |
| 409 `idempotency_conflict` | Retain original; do not silently reassign capture UUID |
| 413 `upload_too_large` | File exceeds 200 MiB or request exceeds proxy limit |
| 415 `media_type_unsupported` / 400 `upload_empty` | Explain invalid media; keep local original |
| 404 `media_not_found` | Missing and another installation's assets look identical |
| 404 `media_not_ready` | Processed asset not available yet |

FastAPI validation errors can have a 422 detail array; proxy failures may not be
JSON. Clients need a generic fallback. Network failures are not revoked access:
retain credentials and the local queue. Bind queued clips and receipts to the
normalized API origin **and installation ID**; never silently reassign them to a
new server or identity. Refuse redirects on credential-bearing requests.

## Administrator operations

The portal unlocks using the development admin token. Mutations require the
session cookie plus `X-TMT-Admin: 1`; no cross-origin API access is enabled.

The visible Logout button calls `DELETE /api/v1/admin/session` and navigates to
`/unlock` only on204; failures keep the page open with an error and allow retry.
This clears the current browser cookie, not copied stateless cookies or other
administrators' sessions. Authn/authz redesign remains explicitly deferred.

* `POST /api/v1/admin/invites`: label, `expires_in_hours` (1–168, default 24),
  `quota_bytes` (default 1 GiB), and `quota_uploads` (default 100). Returns the
  invite code **once**. Losing it requires another invite.
  New codes are the two-word format above; keep short expiry and low quotas.
* `GET /api/v1/admin/invites` and `/installations`: most recent 200 records;
  never return credential hashes or secrets.
* `POST /api/v1/admin/invites/{id}/revoke`: prevents future redemption. Does
  **not** revoke an already enrolled installation.
* `POST /api/v1/admin/installations/{id}/revoke`: disables installed credentials.

`GET /api/v1/admin/reachability` is private-only and returns
`{"service":"too-much-trash-admin","version":1}` without an admin session.
The iPhone shows Admin only after an HTTPS probe to the configured private origin
returns that exact identity without redirects, then opens its root in the system
browser. Recheck on foreground and before opening. This is a UX visibility test,
not proof of administrator authority or a substitute for server access control.

## Abuse limits and remaining risks

Enrollment uses a DB-backed global rolling60-second budget of3 admitted attempts.
The API middleware reserves a permit before JSON/body validation and redemption,
so invalid, expired, redeemed and malformed requests reaching the canonical
enrollment POST all consume it. The fourth request receives429 `rate_limited`;
`Retry-After` is the integer ceiling of seconds until the oldest permit expires.
Rejected retries do not extend the cooldown. This is not a calendar-minute reset
and does not trust client IP headers. A DB advisory transaction lock and DB clock
share the budget across processes. Existing `auth_rate_limits` rows use a separate
`enroll_rolling_us` bucket with microsecond timestamps in bigint `window_id`, so
no new migration or modification of the existing revision is required.

Requests rejected by Caddy before reaching the API (such as oversized bodies) do
not consume API permits and cannot attempt redemption. The other DB-backed global
limits remain fixed-minute:120 refreshes and20 admin logins. Existing installation
validation/media access is not blocked by enrollment cooldown. Caddy caps public requests at 201 MiB and
auth bodies at 16 KiB. Upload authorization precedes multipart parsing in the
API. Installation quotas count lifetime original bytes and accepted uploads;
database locks prevent concurrent overrun. Failed processing still counts.

These controls are for an invite-only prototype, **not DDoS protection**. Global
limits can be exhausted by an outsider; three enrollment attempts temporarily
block registration for every collector, so this is a deliberate availability
tradeoff. Before broader rollout, add trusted
proxy-aware per-client controls, monitoring and edge protections. Derivatives,
worker compute and retained database records are not included in storage quotas.
Legacy captures without installation ownership remain stored but inaccessible to
collector credentials; do not guess ownership or delete them.

## Optional Tailscale deployment

Local listeners bind to localhost. The optional `compose.tailscale.yaml` overlay
removes host port publishing, shares Caddy's network namespace with a userspace
Tailscale node, persists node state, and enables secure admin cookies. Pin a
reviewed Tailscale image version before deployment. It is not activated by default.

Proposed HTTPS ports on the node's `*.ts.net` hostname:

| Port | Route | Intended exposure |
| --- | --- | --- |
| 443 | Public website | Funnel, only after explicit activation |
| 8443 | Admin portal | Serve / tailnet only; **never Funnel** |
| 10000 | Collector API | Funnel, only after explicit activation |

The checked-in serve configuration has **all `AllowFunnel` values false**.
An operator must authenticate the node, configure tailnet grants/HTTPS/Funnel
permissions, and approve activation. No account changes, login or exposure were
performed during implementation. Only 443 and 10000 may later be made public.
Directory-mounted configuration follows [Tailscale's container parameters](https://tailscale.com/docs/features/containers/docker/docker-params).

Validate configuration before using the overlay:

```sh
docker compose -f compose.yaml -f compose.tailscale.yaml config --quiet
```

Back up existing Postgres data before deploying schema changes. The `migrate`
service runs `uv run --no-sync alembic upgrade head` under a database advisory lock and runs
before the API starts, including for an existing volume. Initialization scripts
alone do not update an existing database. Rebuild/redeploy to activate these
changes; editing source does not secure an already-running old container.

Alembic tracks applied revisions in `alembic_version`; repeated upgrades are
no-ops. Keep at most one new revision file per PR. This PR has one revision,
`backend/api/migrations/versions/003_onboarding.py`, adopting the existing pilot
schema without discarding records. The two `postgres/init` SQL files are initial
database setup, not Alembic revisions. Do not stamp a live database without schema
verification. Downgrade removes authentication/ownership records and requires an
explicit recovery plan and backup; it is never part of normal deployment.

Eric will review and test the Simulator app first. Personal iPhone installation
and physical camera/volume-button validation follow that review, not before it.

Backend regression tests use an isolated disposable Postgres database with
`TMT_TEST_ISOLATED=1`, `DATABASE_URL`, and `S3_BUCKET` set. Blob storage is mocked;
run `python -m unittest discover -s tests -v` with API dependencies and `httpx`
installed. They never validate real Apple services or a live Tailscale deployment.

### Verification — October 9, 2026

* 11 API/Postgres integration tests passed; blob storage was mocked.
* 3 checks against an isolated Caddy/API stack passed: public admin isolation,
  private probe versus session authorization, and auth body limits/upload denial.
  Set `TMT_PROXY_TEST_PUBLIC` and `TMT_PROXY_TEST_PRIVATE` to disposable proxy
  origins to run `test_proxy.py`; otherwise those checks skip.
* Actual migration runner applied the migration twice successfully.
* Compose overlay and Caddy configuration validated; frontend TypeScript and
  production build passed. Patched build dependency audit: zero vulnerabilities.
* Admin browser unlock, invitation creation and one-time code dismissal verified
  with disposable credentials and data. The existing running stack was untouched.

### Local deployment — October 10, 2026

The iPhone checkpoint `7d87aeb` was integrated as `a074293`. Before deployment,
a verified Postgres custom-format backup was saved to the ignored, owner-only
`backend/.backups/pre-onboarding-20261010.dump`. The old checkout's admin secret
was unavailable; with explicit approval, a replacement temporary token was saved
privately to `backend/.secrets/admin-token`. Existing database/storage configuration
was preserved in the ignored, owner-only `backend/.env` without displaying values.

API, migration and Caddy images rebuilt successfully. Migration exited zero;
only API/Caddy were replaced, leaving database and media volumes intact. All
published listeners now bind to localhost. The optional Tailscale overlay was
validated but not activated; no Funnel, public HTTPS, passkeys, push or merge.

The live local smoke test passed: public admin isolation, private probe/session
separation, replacement admin login, single-use enrollment, access/refresh,
real blob byte roundtrip, worker processing and derivative retrieval, owner-only
status/downloads, quotas, and revoked access/refresh. Two labelled revoked test
installations and one tiny test image remain as audit records; no real captures
were removed. Physical iPhone testing still requires configured HTTPS origins
and device signing; do not weaken the app's HTTPS-only checks for localhost HTTP.

### Private HTTPS pilot — October 10, 2026

After explicit approval, the laptop's existing macOS Tailscale node was used for
two background Serve proxies: HTTPS port 10000 to Caddy's localhost 8082 collector
listener, and HTTPS port 8443 to localhost 8081 admin listener. The Docker
Tailscale overlay remains inactive. The actual Serve configuration contains only
these two private routes and no Funnel entries. Admin cookies now require HTTPS.

All three proxy checks passed through the actual node FQDN with normal TLS
certificate validation. The complete invite/media/worker/ownership/quota/refresh/
revocation smoke test also passed over HTTPS; two additional revoked labelled
test installations and one tiny image remain as audit records. Initial automatic
certificate provisioning exceeded one probe's timeout; the subsequent checks
passed without TLS exceptions. The verified origins were sent to the Iphone Agent
for Simulator checks. Physical iPhone validation remains separate.

For this private pilot, use the laptop's full MagicDNS FQDN from `tailscale status`
with port 10000 as collector origin and port 8443 as admin origin. Do not use the
bare `mongoose-bonito.ts.net` tailnet suffix as a service hostname. To disable
only these proxies later: `tailscale serve --https=10000 off` and
`tailscale serve --https=8443 off`. Do not run a global Serve reset when other
services may have been added.

The planned Mac mini deployment will have its own node FQDN and Serve setup.
Client origins are configurable; old origin/installation-bound queued clips must
not be silently adopted during that migration. HTTPS certificate renewal and
reachability depend on Tailscale and the host remaining operational.

With explicit approval, a one-hour, 1 MiB / one-upload invite was issued for
native Simulator integration. The real iOS registration flow passed over verified
HTTPS, stored credentials in Keychain, authorized `/auth/me`, and a fresh app
session reused the same installation from Keychain. The private admin probe
passed and normal app relaunch reached Field Camera. No upload was attempted;
Simulator camera availability is not physical capture validation. The exact test
installation was then revoked through the private admin API.
Normal app relaunch correctly rejected the revoked saved access and did not
enter capture. Disposable invite fixtures and the temporary live test harness
were removed; the small Home configuration fix and permanent regression test
were integrated locally. Live iOS upload and physical camera/volume-button
validation remain outstanding.

### Alembic adoption — October 11, 2026

Replaced the custom SQL runner with Alembic 1.20.0, one onboarding revision and
standard `alembic_version` bookkeeping. Twelve disposable-Postgres migration/API
tests passed, covering initialized fresh databases, adoption of the legacy pilot,
preserved invite/installation/capture records, repeat upgrade, and disposable-only
downgrade/re-upgrade. Three private HTTPS proxy checks passed after deployment.
The local database was backed up before adoption; the revision is `003_onboarding`
and counts remained four captures, five invites, five installations and one access
token. A second live upgrade was a successful no-op. No live downgrade or new
invitation was performed; test-container removal did not affect live volumes.

### No-Tailscale local Simulator mode — October 11, 2026

The opt-in `compose.dev.yaml` overlay runs project `too-much-trash-dev` with
separate network, Postgres/blob volumes and privately generated credentials.
Loopback ports18082/18081/18080 serve collector/admin/website; no Tailscale service
or public/LAN listener is involved. Use the explicit project and private env-file
arguments in `backend/README.md` rather than the pilot `.env`.

The dev API allows HTTP admin cookies, while the pilot remains Secure=true.
Host-side configuration isolation and all three local proxy tests passed. HTTP
token exchange, cookie reuse, gated dashboard shell and authenticated empty
invite/installation lists passed without creating any invitation. The browser
unlock page was verified separately. Full native registration/upload testing
requires approval for a fresh bounded dev invite. Local mode is for Debug
Simulator builds only, never physical iPhone or Release; normal enrollment and
credential/ownership checks are unchanged.

### Two-word pilot invites — October 11, 2026

New invitations use the two-word contract above; no migration or token rotation
is required. The vendored list includes its pinned source/checksum and MIT notice
under `backend/api/app/data/`. Seventeen disposable-Postgres migration/API tests
passed, including independent word draws/repeats, normalization/invalid input,
legacy opaque compatibility, bounded historical/concurrent collisions, atomic
normalized redemption, token strength, expiry, revocation, quotas and throttling.
No invitations were generated in the actual local-dev or pilot databases during
this verification. Frontend build and dashboard/unlock/logout regressions passed.

The later two-word-only simplification removed opaque invite redemption, with
the same17 disposable migration/API tests re-run successfully. They now verify
generic rejection of retained opaque invite records, unchanged existing access
and refresh, and default `iPhone` name when enrollment omits `installation_name`.
Only local dev is redeployed; the private pilot remains untouched.

### User-led local Simulator enrollment — October 11, 2026

Eric completed two-word entry/paste and reached Field Camera. Read-only local-dev
API status metadata confirmed enrollment201 and account validation200, with one
redeemed invite and one active installation. No codes, credentials or request
bodies were inspected or printed. This confirms local native enrollment, not
camera capture or media uploads; those remain separate validation steps.

### Global rolling enrollment limit — October 12, 2026

Twenty-three disposable migration/API tests passed, including three-admitted/
fourth-blocked behavior, malformed JSON/model validation, rolling minute-boundary
and exact expiry, rounded Retry-After, blocked retries not extending cooldown,
concurrent HTTP calls with different forwarded IPs, separate Python processes
sharing the same DB budget, and unchanged existing auth during cooldown.
Only the isolated local-dev API is deployed. No schema/revision change, live
invite redemption, credential rotation, user revocation or pilot change is needed.

### Automatic-upload/session contract — October 12, 2026

Thirty-three disposable Postgres/API tests passed with mocked blob storage,
including self-only/repeated/expired-secret End Session, lost End acknowledgement,
backend media retention, keyed retry/lookup/fingerprint conflicts, quota-once,
concurrent deduplication, lost upload acknowledgement, orphan recovery and both
upload/revocation orderings. Two selected checks also passed against a separate
real SeaweedFS blob container: original byte roundtrip with keyed quota-once and
media retained after End Session. These tests do not use the user's installation.
Only local-dev API is redeployed; no schema or revision change is needed.
The real-storage harness is `backend/api/tests/verify_real_storage.py`; run it
only in an explicitly disposable DB/blob environment with `TMT_TEST_ISOLATED=1`,
test dependencies, `/sql/init` fixture mount and the S3 environment configured.
It deliberately reuses the API tests' destructive table resets; never point it
at the pilot or user local-dev database. It is not part of default discovery.

### Real native session integration — October 12, 2026

With Eric's approval, one1-hour/1MiB/2-upload local-dev invitation was created for
`Native session sync integration`, using private mode600 fixtures and a1538-byte
synthetic H264 MOV. Native registration, automatic background URLSession upload
recovery after a deliberately lost acknowledgement, repeated keyed receipt,
and End Session cleanup passed in Simulator. Recovery used a receipt lookup rather
than another automatic POST. An explicit duplicate POST returned the same media
ID. Native cleanup removed the test's synced video, unfinished unsynced file,
queue and unique Keychain item only after matching revocation acknowledgement.
Read-only backend audit confirmed one accepted capture/1538-byte quota charge,
test installation revoked, completed processing and retained matching original.
The prior user installation remains active. This does not validate physical
camera/volume buttons or completion while actually OS-suspended/force-quit.
Temporary secret/video fixtures are removed; backend test audit/media are retained.

### Admin history and dual-stack deployment — October 12, 2026

Recent invitations hide both redeemed and revoked entries by default; unused
expired entries remain visible. History controls read `Expand (<count>)` and use
`aria-expanded` plus a chevron, without the old history helper. Recent installations
hide only revoked entries and use the invitation's tester label as their primary
display name, retaining UUIDs internally for authorization and routing.

Thirty-four disposable DB/API tests passed (four optional host/storage checks
skipped), along with frontend build, dashboard, unlock and logout regressions.
Browser checks with a read-only dummy-data preview confirmed collapsed/expanded
history, counts and tester labels; no live invites or revocations were created.
API and Caddy were rebuilt and deployed to both localdev and the private pilot;
running images match the latest builds. Three proxy-isolation checks passed on
each stack. Both login pages now serve the eye toggle and outer-whitespace trim.
Pilot Secure cookies remain enabled; HTTP cookies are limited to isolated dev.
The pilot now includes the existing rolling enrollment and media/session contract
described above; no schema change or additional migration was required.

Localdev and pilot intentionally use separate admin tokens; each token was
verified against its own mounted hash without printing credentials. A localdev
token cannot unlock pilot. Origin switching selects origin-bound native credentials
and does not call End Session: the saved local installation still validated with
`/auth/me` and reopened Camera/Dashboard in a focused Simulator check. The End
confirmation was cancelled; no user session was revoked or credential rotated.

Eric approved the current UI on October 12 but has not installed the app on his
physical iPhone or verified camera functionality. Simulator checks do not qualify
real camera capture, volume-button events or field hardware; these remain pending.
