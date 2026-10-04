# Public website

This directory contains the public splash page served by Caddy at `/` in the
hosted stack. `index.html`, `landing.css`, `landing.js`, and `assets/` are
copied into the Caddy image by `backend/caddy/Dockerfile`; no site build step
is needed. The page links to the developer documentation on GitHub Pages.

The same Caddy instance serves the token-gated admin portal from `frontend/`
on a separate site address and proxies `/api/*` to FastAPI on the admin and
API addresses. See `backend/README.md` for the local ports and token setup.

For a standalone preview of just this page from the repository root:

    python3 -m http.server 8001 --directory backend/caddy/public

For a routing check, build the Caddy image from the repository root:

    docker build -f backend/caddy/Dockerfile -t too-much-trash-web .
