# Backend stack

Run from this directory:

```sh
cp .env.example .env
# Replace the sample passwords in .env before starting.
docker compose up --build -d
docker compose ps
```

The API is at `http://localhost:8080` by default. Set `HTTP_PORT` in `.env` to change the host port. Postgres, SeaweedFS blob storage, and Prefect are private to the Compose network. Volumes preserve captures across restarts. The first database startup creates the capture table and Prefect database; existing database volumes need a migration if the schema changes.

For the current Electron shell, set `TMT_SERVER_URL=http://localhost:8080`. A browser client served by this Caddy instance can use the relative `/api/v1/...` URLs directly.

## Client contract

Send one image or video as a multipart field named `file`:

```sh
curl -F 'file=@sample.jpg;type=image/jpeg' http://localhost:8080/api/v1/media
```

The API returns HTTP 202 with an `id`, `status_url`, and `original_url`. Poll `GET /api/v1/media/{id}` until `status` is `completed` or `failed`. A completed capture includes `processed_url`; fetch it with `GET`. The original remains downloadable at `original_url`. This lets Electron and iOS choose whether to fetch the processed result. The worker currently produces a JPEG preview for images and a JPEG poster frame for videos, plus image dimensions or video duration in `result`. It does not infer litter labels yet.

Accepted types: JPEG, PNG, WebP, HEIC, MP4, MOV, and WebM. The upload limit is 200 MiB. All assets are stored in the S3 bucket configured by `S3_BUCKET`. Processing failures retain the original and expose `status: failed` with an error message.

This local stack has no client authentication or TLS. Put it behind an authenticated HTTPS gateway before allowing uploads from untrusted networks. An iPhone on another device needs the host machine's reachable address rather than `localhost`.
