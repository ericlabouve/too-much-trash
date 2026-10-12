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

## Simulator-only local development (no Tailscale)

Run from `backend/`:

```sh
python3 api/tools/init_local_dev.py
docker compose -p too-much-trash-dev --env-file .secrets/dev/compose.env -f compose.yaml -f compose.dev.yaml up --build -d --wait
```

Use `http://localhost:18082` for the Simulator collector and
`http://localhost:18081` for its admin browser. The website uses port 18080.
All published ports bind loopback, with no Tailscale/Funnel dependency. Enable the
app's explicit local-development option only in a Debug Simulator build.
Physical iPhone and Release builds still require HTTPS.

This Compose project has its own network, database/blob volumes, admin token and
storage credentials. It does not reuse the pilot `.env` or its volumes. The local
admin token is `backend/.secrets/dev/admin-token`; only its hash reaches the API.
HTTP admin cookies are allowed only in this dev project; the pilot retains Secure
HTTPS cookies. Authentication/invites/quotas remain enforced, not bypassed. A
working reachability probe is not authenticated dashboard access.

Keep the explicit project/env-file/overlay arguments for all dev commands. To
stop it without deleting data:

```sh
docker compose -p too-much-trash-dev --env-file .secrets/dev/compose.env -f compose.yaml -f compose.dev.yaml stop
```

Do not combine dev and Tailscale overlays or expose these listeners to LAN/public
interfaces. Creating a test invite remains a separate authorized admin action.

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

Local HTTP is for development only. The optional Tailscale overlay keeps the
admin listener private and proposes separate HTTPS ports for website and API
Funnel access. Funnel remains disabled in the checked-in configuration. See
[onboarding.md](onboarding.md) before any hosted deployment; never publish the
admin listener or the API container directly.
