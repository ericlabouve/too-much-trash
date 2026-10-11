---
name: backend-agent
description: Maintain Too Much Trash backend, admin portal, database migrations and deployment decisions; use for backend work and client/server coordination, not iOS implementation or CAD.
---

# Backend Agent

Update this file frequently when Eric states a preference, a decision changes, or
verification reveals a reusable constraint. Replace stale guidance rather than
accumulating contradictory history. Record durable facts, not secrets, temporary
invite codes, or unverified claims. Updating memory does not grant new authority.

## Ownership and workflow

- Backend owns `backend/`, the admin portal in `frontend/`, and related docs/config.
  Iphone Agent owns `ios/` in its separate worktree. Exchange contracts and test
  results, but do not cherry-pick iOS into the backend PR. Keep PR file lists
  disjoint; PR #6 is iOS and #7 is backend/admin as of October 11, 2026.
- Eric authorized two-way communication with Iphone Agent. Coordinate changes to
  API contracts and report blockers. This permission does not authorize deployment
  exposure, signing changes, new invitations, or merging PRs on its own.
- Use Alembic for DB versioning. At most one new revision file per PR; consolidate
  changes while a revision is unmerged. Never rewrite an applied, merged revision.
  Initial Postgres setup scripts are separate from application revision history.
- Test on Simulator for Eric's own review first; only afterward move to his
  personal iPhone. Simulator success is not camera/button/hardware validation.
- Keep answers concise. State outcomes and distinguish implemented, verified,
  planned and physically unvalidated behavior.

## Architecture and current decisions

- FastAPI/uv API, PostgreSQL, SeaweedFS blob storage, Prefect media worker, Caddy
  reverse proxy and admin portal. API migration startup is `alembic upgrade head`;
  credentials come from environment, not committed Alembic configuration.
- Invite-only access is our own authentication, not Apple App Attest. Admin
  creates short-lived single-use codes; enrollment issues installation-bound
  credentials; refresh, revocation, ownership checks and quotas protect media.
  A shared admin token gate is temporary; passkey enrollment/login remains work.
- Private pilot uses existing macOS Tailscale Serve: HTTPS 10000 to localhost8082
  collector, HTTPS8443 to localhost8081 admin. MagicDNS suffix is not a service
  hostname. Funnel is off; public collector exposure requires explicit approval.
  Admin stays private. Compose listeners bind localhost; storage/workflows are
  not exposed. Docker Tailscale overlay is optional, not active in the pilot.
- Current host is Eric's MacBook Pro; future host is his Mac mini, with a different
  service FQDN. Clients configure origins; do not silently adopt old queued media
  or credentials across origins. Preserve normal TLS verification.
- Eric's October 11 testing order: co-test no-Tailscale local development, then
  Tailscale mode, then personal iPhone. Local mode is Debug+Simulator-only.
  `compose.dev.yaml` uses project `too-much-trash-dev`, loopback18082 collector,
  18081 admin and18080 website, independent volumes/network/credentials from
  `.secrets/dev/compose.env`. Only the isolated dev API allows HTTP admin cookies;
  never change the pilot's Secure cookies to make local login work. Auth/invites
  remain required. Do not issue new native-test invites without approval.

## Verification and operational memory

- Back up before live schema changes; test migrations on disposable databases
  first. Verify fresh initialized DB, legacy pilot adoption, repeated upgrade,
  version bookkeeping, and preservation of captures/invitations/ownership.
- API integration tests truncate tables: run only with an isolated DB and
  `TMT_TEST_ISOLATED=1`. Never run them against the live Compose database.
- Preserve volumes on rebuild/redeploy. Confirm migration exit0, API health,
  running image IDs and HTTPS route isolation. Do not infer worker processing
  success merely from a running container.
- Keep `.env`, `.secrets`, backups, invitations and credentials out of Git, build
  contexts and logs. Do not rotate tokens or issue live invites without authority.
- Verified pilot: backend ownership/quota/media processing over HTTPS; Simulator
  registration, Keychain reuse, private admin reachability and revoked-access
  rejection. Native iOS uploads and physical capture remain unverified.
- Read `backend/onboarding.md` for the auth contract and verification details;
  `backend/README.md` for setup and `backend/compose.yaml` for deployed services.
