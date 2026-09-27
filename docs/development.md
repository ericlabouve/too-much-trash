# Development notes

The repository has five areas: `backend/` for the hosted stack, `frontend/` for the browser and Electron UI, `ios/` for the dedicated SwiftUI app, `ml/` for model research, and `cad/` for physical design.

For a local stack, copy `.env.example` to `.env`, replace the example passwords, and run `docker compose up --build`. Caddy serves the browser UI on port 80 and proxies `/api/*` to FastAPI. The health endpoint is `/api/v1/health`. Postgres, MinIO, and Prefect stay on the private Compose network. The MinIO bucket is created by the one-shot `minio-init` service.

For a desktop preview, run `npm install` and `npm run desktop` in `frontend/` while the stack is running. Set `TMT_SERVER_URL` to the hosted URL when connecting to a remote stack. The iOS project is described by `ios/project.yml` for XcodeGen; generate the Xcode project from that directory, then open it in Xcode.

This is an initial scaffold. Capture, authentication, media upload, processing flows, and model training are planned work.
