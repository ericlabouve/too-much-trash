# Backend stack

The proposed sensor-ingestion and dataset interoperability plan is in
[data-contract.md](data-contract.md). It is a design proposal, not the current
upload API contract.

The implemented invite-only authorization contract, client behavior, trust
boundaries, and optional Tailscale deployment are in [onboarding.md](onboarding.md).

From this directory, mint a local admin token and start the stack:

```sh
cp .env.example .env
# Replace the sample passwords in .env before starting.
cd api
uv run --no-sync python tools/mint_admin_token.py
cd ..
docker compose up --build -d
docker compose ps
```

The public site is at `http://localhost:8080`, the gated admin portal is at `http://localhost:8081`, and the iPhone API is at `http://localhost:8082` by default. Listeners bind only to localhost. The portal calls `/api/v1/...` on its own origin. Postgres, SeaweedFS blob storage, and Prefect are private to the Compose network. Volumes preserve captures across restarts. Back up existing data before deploying changes; the migration service updates existing databases before API startup.

The token is saved at `backend/.secrets/admin-token`; only its SHA-256 hash is mounted in the API container. The directory is ignored by Git. Open the portal and paste the token on `/unlock`. To rotate it, run the tool with `--rotate` and recreate the API container with `docker compose up -d --force-recreate api`. Rotation ends existing sessions. This is a temporary shared admin gate, not passkey authentication. The portal issues single-use invites and revokes installation access. Collector uploads, status and downloads require enrollment credentials; the public API rejects admin routes.

## One development stack, two access routes

The laptop's `too-much-trash` project is development, not production. Simulator
collector testing uses `http://localhost:8082` or the laptop's private Tailscale
HTTPS collector address. Physical iPhones use Tailscale HTTPS, never localhost.
Both routes reach the same API, database and media volumes. HTTP collector access
is restricted to Debug Simulator builds; device and Release builds require HTTPS.

Current app-node collector:
`https://too-much-trash-eric-dev.mongoose-bonito.ts.net:10000`.
Current app-node admin portal:
`https://too-much-trash-eric-dev.mongoose-bonito.ts.net:8443`.
The admin token is `backend/.secrets/admin-token`. Keep Secure admin cookies:
use the HTTPS admin portal even when testing the collector via localhost; plain
HTTP admin login is not supported by the current Secure-cookie configuration.
Client configuration changes must not silently transfer saved credentials or
upload queues between origins.

The Tailscale container is an extra service in this SAME `too-much-trash` project,
not a second backend stack. It shares Caddy's network namespace and proxies into
the existing API/database/media. Its `-eric-dev` hostname distinguishes the node
from the reserved production hostname; it is not the retired Compose project.

Start the existing project with the app-node overlay, preserving all volumes:

```sh
docker compose -p too-much-trash --env-file .env --env-file .secrets/tailscale.env -f compose.yaml -f compose.tailscale.yaml up -d --wait
```

Ignored `.secrets/tailscale.env` selects this developer's unique hostname/tag and
pinned image. First node sign-in is interactive; no reusable auth key is committed.
`TS_BOOT_TIMEOUT=20m` allows first-login approval without a 60-second restart loop;
subsequent restarts reuse the `too-much-trash_tailscale_state` volume. Never copy
that private node-state volume to another developer or production. The app node
must be reachable from the client under the saved tailnet grants; being connected
alone does not prove application authorization.

Legacy physical-laptop Serve routes remain temporarily for origin-safe transition.
New policy targets the app node, not the personal laptop. New clients should use
the app-node addresses above; existing origin-bound credentials/queues are not
automatically moved. Remove old host routes only after the client transition has
been checked, using the targeted commands in `onboarding.md`, not a global reset.

The former `too-much-trash-dev` project's containers/network were removed on
October 12, 2026 without deleting its four named volumes or ignored credentials.
They are retained for recovery, not merged into the active database. The old
`compose.dev.yaml` and initialization tool are historical recovery resources;
do not launch that second project as the normal development workflow.

### Multiple developers and future production

Each developer runs one independent stack on their own Mac, with local `.env`,
admin token, database and media volumes. Localhost ports can be the same across
different Macs. Each Mac's unique Tailscale hostname identifies its remote
collector/admin endpoints; developer iPhones connect to the selected Mac over
Tailscale. Configure each developer's endpoints locally rather than hardcoding
Eric's hostname into team builds. Tailnet grants should explicitly limit which
users/devices may reach each development server and its service ports.

Production does not exist yet. A future Mac mini deployment has separate secrets,
database and media, a public authenticated collector, and private admin access.
Its physical host keeps `erics-mac-mini.mongoose-bonito.ts.net` and is tagged
`tag:tmt-prod-host` for narrow management access. Its future app node uses
`too-much-trash.mongoose-bonito.ts.net` / `tag:tmt-prod` independently of that host.
Production Funnel eligibility is now authorized only for `tag:tmt-prod`.
The explicit `tailscale/production.env.example` selects `serve.production.json`,
which makes website and collector443 public while keeping admin8443 private.
Do not select this configuration on a developer stack. Permission/configuration
does not create a working public endpoint until the production node is initialized.
Ordinary users target production only; environment selection is a developer/admin
tool, not a substitute for backend authentication or private network restrictions.
Release artifacts can be built once and promoted through a future deployment
workflow rather than copying developer data or secrets into production.

## Production CD

V1 uses `.github/workflows/backend-cd.yaml`: a merge into protected `main`
builds API/worker/Caddy on GitHub-hosted Linux ARM64, publishes digest-pinned
GHCR images and a complete `backend-<commit>` release manifest, then deploys
automatically. No second deployment approval, mini runner or Arcane agent.
CI tests remain deferred; local verification and deployment smoke checks remain
required. The API image also runs the explicit Alembic migration container.

The deployment job uses Tailscale OIDC constrained to this repository, `main`
and this exact workflow. `tag:tmt-deploy` can reach only the mini's TCP22.
Ordinary SSH runs over the VPN; this is not macOS Tailscale SSH server mode.
The dedicated SSH key permits only the forced deployment receiver, no arbitrary
shell, PTY or forwarding. Host keys are pinned from the authenticated host.
GitHub variables: `TS_DEPLOY_CLIENT_ID`, `TS_DEPLOY_AUDIENCE`,
`TMT_DEPLOY_KNOWN_HOSTS`; secret: `TMT_DEPLOY_SSH_KEY`.

Production is image-only `compose.production.yaml`, with separate secrets and
persistent volumes at the Mac mini. Public website and collector share
`https://too-much-trash.mongoose-bonito.ts.net` on443. Admin8443 is private;
public admin/docs/unlock paths are denied. Native SAM3/Cutie run separately.
First registration requires fresh node authorization; later restarts reuse
`tailscale_state`. Do not clone developer data, credentials or node state.

Host layout: `~/too-much-trash-prod/{control,secrets,releases,backups}`.
`current.json` records the last locally verified release. The one-shot receiver
checks main ancestry, rejects out-of-order deployments, serializes host changes,
and loads deployment code only from approved main commits. The job-scoped GHCR
token is streamed over SSH, used in a private temporary Docker config and never
included in manifests/backups. Production credentials stay on the host.

For updates, pull all images before maintenance. Pause application writers,
dump application/Prefect databases and roles, stop blob storage and snapshot its
volume, then mark recovery state before infrastructure/schema mutations. Run
Alembic explicitly; only on success roll out the app and reconnect its sidecar
to the new Caddy namespace. Validate local routes/inventory and external Funnel
isolation on a separate GitHub runner with no Tailscale/MagicDNS. Both GitHub
concurrency and a host lock prevent overlapping rollouts.
Build/pull failures leave the existing app running; pre-migration backup failure
resumes the old release. Partial migration/rollout failures block subsequent CD.

Recovery is operator-controlled, never automatic database downgrade. Inspect
`recovery-required.json` and its backup directory; confirm `complete.json` before
using a snapshot. Test SQL/media restore into a separate disposable stack first.
`python3 backend/ops/cd/verify_restore.py /absolute/path/to/completed/backup`
checks both databases and all blob bytes in new network-isolated containers,
then removes only its uniquely named disposable containers/volumes.
Only after verifying schema compatibility may the operator restart prior images;
otherwise restore DB and blob together during an explicitly authorized outage.
Preserve the failed release, backups and secrets; clear the recovery marker only
after successful checks. An initial empty bootstrap has no previous data snapshot.
Backups here are same-host recovery, not an off-machine disaster recovery service.

`python3 backend/ops/cd/verify_worker.py` is a bounded production smoke check for
image/video extraction, Prefect and S3 poster output. It creates no invitations
or installation/capture records and removes only its uniquely named synthetic
source/poster objects. This is not native SAM3/Cutie or real iPhone validation.

## Retired laptop Arcane evaluation

The trial containers/network were removed on October 14. Named trial volumes and
ignored credentials are retained for recovery. Do not restart it as part of normal
development: V1 CD will use GitHub Actions, GHCR and SSH over Tailscale, with no
Arcane agent or self-hosted runner on the Mac mini. The trial tooling below is
historical; the CD workflow and initial production deployment are not implemented.

`ops/arcane/compose.yaml` starts a separate **management trial**, not another
backend instance. It is loopback-only at `http://localhost:3552`, uses its own
SQLite/project volumes, disables analytics, and exposes only read methods through
a Docker socket proxy. Stop/update/deploy/backup buttons cannot mutate Docker in
this mode. The application stack and Mac mini are not adopted or redeployed.

From the repository root:

```sh
python3 backend/ops/arcane/init_trial.py
docker compose -p tmt-arcane-trial --env-file backend/.secrets/arcane-trial/compose.env -f backend/ops/arcane/compose.yaml up -d --wait
python3 backend/ops/arcane/check_trial.py
```

The check bootstraps a unique password only while the new account still accepts
the documented default. Username is `arcane`; the generated password is stored
privately in the ignored trial env file. Never commit it or copy developer secrets
into production. The trial checks login, inventory and denied anonymous access;
it does not qualify Git deployment, migrations, backups/restore, passkeys or alerts.
Do not enable Docker writes, scheduled cleanup or automatic image updates against
the development backend as an implied part of this read-only evaluation.

## Client contract

Enroll using an administrator-issued invite (see the full contract above). Send
one image or video as a multipart field named `file`, with the resulting access
token supplied from secure storage:

```sh
curl -H "Authorization: Bearer ${TMT_ACCESS_TOKEN}" \
  -F 'file=@sample.jpg;type=image/jpeg' http://localhost:8082/api/v1/media
```

The API returns HTTP 202 with an `id`, `status_url`, and `original_url`. Poll `GET /api/v1/media/{id}` until `status` is `completed` or `failed`. A completed capture includes `processed_url`; fetch it with `GET`. All these requests need the owner's Bearer token. The original remains downloadable at `original_url`. The iPhone app can choose whether to fetch the processed result. The worker currently produces a JPEG preview for images and a JPEG poster frame for videos, plus image dimensions or video duration in `result`. It does not infer litter labels yet.

Accepted types: JPEG, PNG, WebP, HEIC, MP4, MOV, and WebM. The upload limit is 200 MiB. All assets are stored in the S3 bucket configured by `S3_BUCKET`. Processing failures retain the original and expose `status: failed` with an error message.

Local HTTP is for Debug Simulator development only. The Tailscale overlay keeps
the admin listener private. Development `serve.json` disables Funnel on every port;
only the explicit production serve configuration enables website/API Funnel. See
[onboarding.md](onboarding.md) before any hosted deployment; never publish the
admin listener or the API container directly.
