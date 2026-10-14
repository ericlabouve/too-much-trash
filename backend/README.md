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
which makes website443 and collector10000 public while keeping admin8443 private.
Do not select this configuration on a developer stack. Permission/configuration
does not create a working public endpoint until the production node is initialized.
Ordinary users target production only; environment selection is a developer/admin
tool, not a substitute for backend authentication or private network restrictions.
Release artifacts can be built once and promoted through a future deployment
workflow rather than copying developer data or secrets into production.

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
