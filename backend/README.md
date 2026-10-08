# Backend stack

The proposed sensor-ingestion and dataset interoperability plan is in
[data-contract.md](data-contract.md). It is a design proposal, not the current
upload API contract.

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

The public site is at `http://localhost:8080`, the gated admin portal is at `http://localhost:8081`, and the iPhone API is at `http://localhost:8082` by default. The portal calls `/api/v1/...` on its own origin. Postgres, SeaweedFS blob storage, and Prefect are private to the Compose network. Volumes preserve captures across restarts. The first database startup creates the capture table and Prefect database; existing database volumes need a migration if the schema changes.

The token is saved at `backend/.secrets/admin-token`; only its SHA-256 hash is mounted in the API container. The directory is ignored by Git. Open the portal and paste the token on `/unlock`. To rotate it, run the tool with `--rotate` and recreate the API container with `docker compose up -d --force-recreate api`. Rotation ends existing sessions. This is a temporary shared admin gate, not user accounts. Anonymous iPhone clients can upload and poll captures using the API port.

## Client contract

Send one image or video as a multipart field named `file`:

```sh
curl -F 'file=@sample.jpg;type=image/jpeg' http://localhost:8082/api/v1/media
```

The API returns HTTP 202 with an `id`, `status_url`, and `original_url`. Poll `GET /api/v1/media/{id}` until `status` is `completed` or `failed`. A completed capture includes `processed_url`; fetch it with `GET`. The original remains downloadable at `original_url`. The iPhone app can choose whether to fetch the processed result. The worker currently produces a JPEG preview for images and a JPEG poster frame for videos, plus image dimensions or video duration in `result`. It does not infer litter labels yet.

Accepted types: JPEG, PNG, WebP, HEIC, MP4, MOV, and WebM. The upload limit is 200 MiB. All assets are stored in the S3 bucket configured by `S3_BUCKET`. Processing failures retain the original and expose `status: failed` with an error message.

This local stack allows anonymous iPhone uploads and uses HTTP. Caddy can terminate public HTTPS when real DNS names and ports 80/443 are configured. Before exposing anonymous uploads to the internet, add rate limits and abuse controls. An iPhone on another device needs the host machine's reachable address rather than `localhost`.

For hosted HTTPS, set `SITE_ADDRESS` to the apex hostname, `ADMIN_SITE_ADDRESS` to `admin.portal.<domain>.ai`, `API_SITE_ADDRESS` to `api.<domain>.ai`, `HTTP_PORT=80`, `HTTPS_PORT=443`, and `ADMIN_COOKIE_SECURE=true`. Point all three DNS names to the host and allow inbound ports 80 and 443. Caddy then provisions and renews public certificates automatically. The local high-port routes are for development only.
