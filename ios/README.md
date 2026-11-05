# iPhone app

New users enter the two-word invite directly on registration, with no redundant Login/Continue button. Returning credentials are validated by the backend before automatically opening capture. Failed saved-credential validation offers Retry connection. An already-validated active session can continue recording through temporary network loss. Session identity is the installation at its original server origin and persists across relaunch and camera/dashboard navigation.

After authorization, the app uses an ARKit rear-camera session. The intended episode spans three seconds before a press, the hold, and three seconds after release; consecutive presses create separate, potentially overlapping episodes. Camera and motion access may be requested. Requires iOS 17.2 or later. On 2026-11-01 the user reported that the physical volume button showed a recording cue and an episode uploaded on an iPhone 15 Pro; timing, stream completeness, and repeatability still require validation. Apple documents capture-button events for apps actively using an AVCaptureSession; compatibility with an ARKit-only session is not guaranteed. The onscreen hold control is diagnostic, not a substitute for the mounted harness. Capture-event callbacks have no hardware-edge timestamp, so recorded button times are callback times with unmeasured latency.

Legacy video-only MOV originals and new episode folders live in Application Support/PrivateCaptures, outside Photos and the Files browser. Each episode contains a video-only MP4, timestamped IMU and pose JSONL files, and a manifest with calibration, clock, tracking and gap metadata. Origin+installation subfolders, backup exclusion and protection available after first device unlock keep session data private while allowing admitted background transfers. Upgrade moves legacy Documents/Captures intact when safe; conflicting locations or corrupt manifests are preserved and block unsafe overwrites. Unowned originals are never silently reassigned to a new installation.

The camera has a Dashboard button, a transparent double-ring record control, and no admin/upload menu or instruction footer. Dashboard has Back to camera, aggregate sync progress/status, two-column inline video players with native scrubbing/fullscreen controls and per-video sync indicators, and End Session. Its Admin dropdown is in the header beside End Session. Synced means the backend accepted the original and committed its receipt, not that processing finished or succeeded. Backend previews are not validated research labels.

Sync starts automatically after queueing completed recordings, connectivity recovery, foreground/relaunch and periodic checks. File-backed background URLSession transfers allow ordinary suspension subject to iOS scheduling; force-quitting pauses delivery until reopening. When the server advertises `resumable_episode_contract_version:1`, episodes use independently acknowledged 1 MiB chunks; after interruption the app asks which chunks are retained and retries only missing chunks. Chunks are retried whole, not by byte offset. Server staging expires after seven days without activity, after which upload restarts from the retained phone originals. Older episode servers use the original whole-request upload. Both paths currently have a 200 MiB aggregate episode limit; oversized episodes remain locally blocked for attention. The persisted capture UUID supplies Idempotency-Key; by-client receipt lookup, UUID echo, original byte size and the digest of all four files are checked before persisting Synced. Exact retries cannot duplicate accepted captures or charge quota twice. Automatic uploads require authenticated media_contract_version:1, and episodes also require episode_contract_version:1. Retry backoff/Retry-After preserve local originals. iPhone background/relaunch and network-interruption behavior still requires physical validation.

End Session requires a destructive confirmation. Unsynced or untracked recordings trigger an explicit permanent-loss warning, available ETA and Keep uploading / End & Delete choices. The app journals End intent in Keychain, cancels/waits for owned uploads, requests idempotent self-revocation with its strong refresh proof, and checks the returned installation UUID/revoked flag. Only after matching server acknowledgement does it delete current-session originals/staging/queue and remove credentials, returning to registration. Already-accepted backend originals remain. Failed End retains remaining files/credentials and offers retry; a revocation-confirmed journal resumes cleanup after crashes without auto-login. Other sessions' files are not erased. Deleting the app removes its private local data; offloading retains it. Explicit exports outside the app cannot be cleaned up by the app.

Registration requires two BIP-39 English invite words. Type into the two readable boxes or paste the full phrase into either box to fill both. A space after the first typed word advances focus; pasting never auto-submits. More than two pasted words are retained for correction, not silently discarded. Large accessibility text stacks the boxes. The backend validates the word list and accepts capitalization and repeated whitespace; client parsing preserves case. There is no older-code entry or device-name field. One **Register** button submits without an installation name, allowing the backend's existing default label; errors remain visible after failed attempts, without a redundant introductory status. Keep live invite words out of screenshots and logs. Two words are an explicitly accepted private-pilot guessability tradeoff, not a replacement for strong installation credentials.

## Access and private admin behavior

Older opaque invite codes are no longer accepted for enrollment. Existing installations and their credentials are unchanged; no records are deleted or revoked by this format change.

Access/refresh credentials are persisted in origin-scoped Keychain items using `WhenUnlockedThisDeviceOnly`, without iCloud synchronization. Background uploads also give their authenticated requests to the system-managed URLSession transfer service. No shared secret, App Attest, native passkey registration, or credential logging is used. Only non-secret server origins are stored in preferences. Credential-bearing requests refuse redirects and use normal system TLS validation. Collector and optional private admin settings accept HTTPS root origins only, with no embedded username/password, path, query, or fragment; the two origins must differ, including by port when sharing a hostname.

Registration calls `POST /api/v1/auth/enroll`, saves the returned per-installation credentials, then validates `GET /api/v1/auth/me`. It never automatically retries enrollment. A lost enrollment response or failed Keychain write may mean the single-use invite was consumed: keep the entered invite in the form and ask the administrator for help if retry is rejected. The server alone validates and consumes invites.

Expired access refreshes through `POST /api/v1/auth/token`. An `access_invalid` response gets one refresh retry; `access_revoked` never refreshes, and `refresh_invalid` requires administrator help or a new invite. Network/5xx failures offer retry without deleting credentials or captures. Rate limits respect `Retry-After`. Clock estimates are advisory; the backend decides credential validity.

Production collectors do not need Tailscale. **Admin login** and **Server addresses**
appear only after a private HTTPS endpoint returns the exact approved admin
service/version identity. The app checks its configured/retained origins plus
the known production and development app nodes concurrently, so a stale saved
collector address cannot by itself hide a reachable admin menu. This never
changes the capture server, credentials or queue owner. Public health and HTTP
localhost discovery cannot grant admin controls. Foreground probes repeat every
three seconds after each check; suspension hides the menu, and login revalidates
the private endpoint. On the camera screen, open Dashboard to access Admin.
Tailnet reachability reveals controls; the browser still requires admin sign-in.

The settings sheet lists reachable Too Much Trash app servers. It requests the
curated `/api/v1/admin/servers` catalog from a verified private HTTPS admin, accepts
only bounded compatible same-tailnet HTTPS app-node records, and separately checks
each node's admin identity. This is an app-server directory, not arbitrary tailnet
peer enumeration or a Tailscale credential embedded in the client. Catalog failure
keeps valid admin access and known-node choices available; manual addresses remain
editable. Refresh checks again. Selecting a row only fills the fields; Save makes
the explicit switch, preserving other origins' sessions and videos. The catalog
requires the corresponding backend Caddy deployment and is blocked on public
collector listeners.

The capture screen supports portrait and landscape orientations. Episode windows stop at 30 seconds including pre- and post-roll; a truncated hold or post-roll is marked incomplete. During recording, finalized video-segment sizes and written sensor bytes trigger an earlier safe shared cutoff before the 80,000,000-byte bundle budget is exceeded. Whole-segment charging and a packaging reserve make the cutoff conservative; detection waits for segment finalization, and overflow is retained privately. Passthrough export preserves encoded frames, and a final exact bundle-size guard prevents publishing oversized output. If export cannot satisfy the limit, partial source data remains on the phone and needs attention. Backgrounding or a camera interruption preserves available data as incomplete; crash recovery remains to be validated. The sensor overlay appears only for backend-verified development installations and is not part of exported video. No inference or labeling runs on the phone. ARKit poses are estimates and can be limited or unavailable. Until clock alignment and coverage are validated on actual hardware, episode manifests mark recordings incomplete/unverified.

## Development

The approved production collector origin is
`https://too-much-trash.mongoose-bonito.ts.net` on standard HTTPS 443, shared
with the website. Its private admin origin remains the same hostname on port
8443. The client supports this pair through its existing HTTPS configuration;
the API paths are appended to the collector root. Fresh installations now default
to production. Existing saved configuration wins; changing environments requires
an explicit choice and separate origin-scoped enrollment.

The laptop runs one development stack. Simulator can use `http://localhost:8082`
or `https://too-much-trash-eric-dev.mongoose-bonito.ts.net:10000` for capture.
Admin uses `https://too-much-trash-eric-dev.mongoose-bonito.ts.net:8443` with
either collector route; its cookies require HTTPS. Device/Release collector
access always uses HTTPS. The server picker offers reachable development and
production choices plus the Simulator's explicit localhost toggle, requiring
Save before switching. The app no longer automatically falls back to localhost
when Tailscale is unreachable; it retains the selected collector. Local HTTP
reachability alone does not grant admin controls. Laptop development data and
Mac mini production data remain separate.

Local mode permits HTTP only for localhost in Debug Simulator. A private HTTPS
admin can be paired with that HTTP collector. Legacy localhost admin settings
remain readable, but cannot establish the designated HTTPS admin identity.
Physical/Release builds retain normal TLS and have no localhost ATS exception.
Credentials and queued files remain origin-scoped even when two routes reach the
same backend: selecting a new origin requires its own enrollment and never adopts
old credentials/videos. Switching does not End Session; returning to an old
origin can reuse its credentials after validation. Retired development volumes
and credentials are preserved by the backend and were not migrated into the
remaining stack. Authn/authz redesign remains separate.

Use the backend documentation for the development app node, routing and Compose runtime. Regular enrollment requires an invitation; development enrollment uses its separate scoped key.
Preserve existing Simulator Keychain/queues and saved origins during updates.

Install XcodeGen (`brew install xcodegen`), run `xcodegen generate` in this directory, and open `TooMuchTrash.xcodeproj` from the same checkout. Edit `project.yml` for project configuration; generated Xcode projects are ignored by Git.

Run the `TooMuchTrash` scheme. Unit tests cover capture hold/release races, Keychain roundtrip and isolation, onboarding validation, revoked/invalid/offline/refresh/enrollment failures, strict admin identity checks, safe HTTPS origins, multipart upload contract, queue durability and identity isolation. UI tests check registration, camera/dashboard navigation, nondestructive End confirmation, admin controls and relaunch. No mock authorization bypass is built into the app. A simulator has no usable rear capture camera, so recording and hardware events require an iPhone. `NativeSessionIntegrationTests` is opt-in: it requires explicitly approved private invite.json/sample.mov fixtures in the app's temporary native-session-fixture directory, a unique Keychain namespace, and isolated private queue. Ordinary runs skip it when fixtures are absent; never provision live user credentials for it.

Real Keychain tests require Xcode's normal simulator ad hoc signing; an entirely unsigned simulator app cannot access Keychain. This uses no paid membership or developer certificate and does not sign or distribute an iPhone build. Example simulator test flags: `CODE_SIGNING_ALLOWED=YES CODE_SIGN_IDENTITY=-`. Hardware compilation can use `CODE_SIGNING_ALLOWED=NO` until device signing is explicitly configured.

## iPhone validation

Use Xcode's paired wireless device deployment when available, configure administrator-provided URLs, and register with a live invite. Verify the physical trigger with the phone mounted in the harness:

- The rear preview appears immediately after permission is granted.
- Holding the harness-actuated volume button starts an episode; releasing it starts the three-second post-roll. Confirm both events are detected reliably in the ARKit preview. This is a release requirement, not yet validated.
- A quick press/release does not leave recording running.
- A second press during post-roll creates a separate overlapping episode.
- The onscreen hold button exercises the same episode logic for diagnostics only; it cannot replace the harness trigger.
- Backgrounding or locking during recording ends it; foregrounding restores the preview.
- Review the saved clip on Dashboard and check playback, fullscreen controls, portrait orientation, and duration.
- Denying camera permission shows an Open Settings action and disables recording.
- Relaunch validates saved credentials without requiring another invite.
- Disconnecting the network offers retry and retains credentials and queued videos.
- Revoking the installation blocks access and requires administrator help/new invite.
- Record offline, reconnect and verify automatic upload, per-video Synced, aggregate progress and relaunch durability.
- On a test installation, verify End Session's unsynced warning and scoped cleanup after backend acknowledgement.
- Without tailnet connectivity, Admin login stays hidden. With authorized connectivity, it opens only the private browser portal.

Simulator checks and injected API contract tests do not establish live backend integration, deployment exposure, physical capture, or hardware button behavior. No signing/distribution or live Funnel activation is performed by this implementation.

### Private HTTPS integration checkpoint — 2026-10-10

The Simulator app accepted the private pilot's configurable collector/admin HTTPS origins. Its native private-admin identity probe passed using normal TLS, revealed **Admin login**, and handed off to Safari, where the private admin gate rendered without a certificate warning. No admin sign-in was attempted. With an approved short-lived, low-quota invite, a temporary native XCTest passed real `AccountSession.register`, `LiveCollectorAPI`, Keychain storage, and fresh-session `/me` validation. Normal app relaunch reached capture using saved credentials; after backend revocation, another relaunch showed rejected/revoked access and did not open capture. The temporary harness and Simulator invite file were removed; credentials were not printed. Live app upload and physical camera/button behavior remain unverified. The private pilot requires authorized tailnet connectivity on test devices; Funnel remains disabled. A future server migration must use explicit configuration and preserve existing queues' origin/installation ownership.

### Local native session checkpoint — 2026-10-12

The approved native Simulator test passed real enrollment/Keychain, automatic file-backed background upload, deliberately lost acknowledgement recovery through by-client lookup without retransmission, an explicit keyed duplicate returning the same media ID, and End Session revocation/local cleanup including an unfinished unsynced file. Backend audit confirmed one quota charge, retained byte-identical original and untouched operator installation. Private secret/video fixtures were removed. This is a temporary test identity, not a separate product concept. Real cellular outages, OS suspension scheduling, camera capture and physical buttons remain iPhone validation.

## Timing reference collection

Dashboard offers a guided reference recording for later independent camera–IMU analysis. It preserves raw clocks, records device/OS metadata, and applies no correction. Collect varied gentle rotations against a stationary textured target. ARKit pose is already fused, so pose-versus-gyro agreement cannot independently validate synchronization. Button delay requires a separate observable reference; the screen does not claim to measure an electrical button edge. Numerical estimation and physical per-device validation remain pending.

Segment joins preserve exact container discrepancies and accepted source-frame timestamps. A sub-frame join with continuous source cadence is reported separately from a missing-frame gap; unknown cadence remains unverified. This classification does not establish cross-sensor clock alignment.
