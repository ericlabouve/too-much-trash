# Development notes

The repository has five areas: `backend/` for the hosted stack and admin portal, `frontend/` for the portal interface, `ios/` for the SwiftUI field app, `ml/` for model research, and `cad/` for physical design.

From `backend/`, copy `.env.example` to `.env`, replace the sample passwords, mint a local admin token with `cd api && uv run --no-sync python tools/mint_admin_token.py`, and run `docker compose up --build -d`. The public splash page is at `http://localhost:8080`, the token-gated admin portal at `http://localhost:8081`, and the anonymous iPhone API at `http://localhost:8082`. Open `/unlock` on the portal address and paste the token stored in `backend/.secrets/admin-token`.

Postgres, SeaweedFS S3-compatible blob storage, and Prefect stay on the private Compose network. The API accepts image and video uploads, queues them for a Prefect flow, and serves originals and generated previews. See `backend/README.md` for the client contract. GitHub Pages serves these developer docs from `docs/`.

The iOS project is described by `ios/project.yml` for XcodeGen; generate the Xcode project from that directory, then open it in Xcode. Native capture, account authentication, resumable upload, review tooling, and model training remain work in progress.
