# Public website

This directory contains the public splash page served by Caddy at `/` in the
hosted stack. `index.html`, `landing.css`, `landing.js`, and `assets/` are
copied into the Caddy image by `backend/caddy/Dockerfile`; no site build step
is needed. The page links to the developer documentation on GitHub Pages.

The same Caddy instance serves the browser workspace at `/app/` and proxies
`/api/*` to FastAPI. The workspace is built from `frontend/` with a `/app/`
asset base. See `docs/development.md` for the full local stack.

For a standalone preview of just this page from the repository root:

    python3 -m http.server 8001 --directory backend/caddy/public

For a routing check, build the Caddy image from the repository root:

    docker build -f backend/caddy/Dockerfile -t too-much-trash-web .
