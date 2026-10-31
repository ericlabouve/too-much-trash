# Documentation site

This directory is the **developer documentation** site. GitHub Pages can serve
it directly from `docs/` on the repository's default branch. There is no build
step or package dependency. The public splash site lives in
`backend/caddy/public/` and is served by the hosted Caddy stack.

## Preview locally

From the repository root, run `python3 -m http.server 8000 --directory docs`.
Open <http://localhost:8000/>. Stop the server with Ctrl-C.

## Publish with GitHub Pages

In the repository's **Settings → Pages**, set **Build and deployment** to
**Deploy from a branch**, select the default branch and `/docs`, then save.
The expected URL is <https://ericlabouve.github.io/too-much-trash/>.
GitHub Pages must be enabled before that address resolves. Changes publish
after they reach the selected branch.

`index.html` is the developer docs landing page; `development.html` is the
technical guide. They share `style.css`. Keep `development.md` in sync with
the website when setup details change. For the public site, run the Compose
stack and open its configured address at `/`.
