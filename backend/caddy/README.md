# Public website

This directory contains the public splash page served by Caddy at `/` in the
hosted stack. `index.html`, `participation.html`, `timeline.html`, `landing.css`, `landing.js`, and `assets/` are
copied into the Caddy image by `backend/caddy/Dockerfile`; no site build step
is needed. Public links point to the project repository; the unavailable GitHub
Pages documentation links have been removed.

The dark splash page introduces an egocentric data capture and manipulation lab,
then its first project: a printable reacher harness for trash collection. Its
animated point cloud is illustrative, not live or measured capture data. Motion
respects reduced-motion preferences and pauses when the hero is offscreen or the
tab is hidden. Points use eight batched fills, a capped canvas pixel ratio, and
fewer particles on mobile. Decorative CSS animations also pause offscreen;
animated blur/shadow effects have been removed. The robot arm logo and matching
favicon are editable SVGs in `assets/`.

The separate `participation.html` page, linked from the navigation menu, keeps
the community vision and reskilling goals off the splash page. It describes three
proposed participation models: employer-provided phone and service in exchange
for capture with an employer data stake; employee-provided phone with employee
and employer sharing a portion of data ownership; and independent contribution
with partial data ownership. Too Much Trash retains a share in every model.
Ownership percentages and revenue terms remain unspecified. Worker reskilling
and fleet coordination are aspirations; the hardware remains a fit prototype
pending physical validation.

`timeline.html` is the public Project Timeline tab. It distinguishes platform
capture capabilities from implemented app features, ranks proposed dataset
products, and describes measurement, real-video, simulation, and physical-trial
validation gates. Its interactive phase graph has no time commitments; hover,
focus, or tap reveals concise details and feedback paths. Capability claims link
to Apple documentation; simulation
and research claims link to primary sources. Update the research date when
rechecking those claims.

Public pricing is explicitly separated into vendor production benchmarks,
sample-access listings, and unavailable custom quotes. Research usage is not
evidence of a purchase. The backend interoperability proposal is recorded in
`backend/data-contract.md`; exporters are not implemented yet.

The same Caddy instance serves the token-gated admin portal from `frontend/`
on a separate site address and proxies `/api/*` to FastAPI on the admin and
API addresses. See `backend/README.md` for the local ports and token setup.

For a standalone preview of just this page from the repository root:

    python3 -m http.server 8001 --directory backend/caddy/public

For a routing check, build the Caddy image from the repository root:

    docker build -f backend/caddy/Dockerfile -t too-much-trash-web .
