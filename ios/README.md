# iPhone app

New users enter the two-word invite directly on registration, with no redundant Login/Continue button. Returning credentials are validated by the backend before automatically opening capture. Failed saved-credential validation offers Retry connection. An already-validated active session can continue recording through temporary network loss. Session identity is the installation at its original server origin and persists across relaunch and camera/dashboard navigation.

After authorization, the rear camera opens. Hold either volume button (or the onscreen record button) to record; release to finish and save. Camera access is requested when entering capture. Requires iOS 17.2 or later for Apple's `AVCaptureEventInteraction` hardware capture API. Physical button and camera behavior still require iPhone validation.

Video-only MOV originals and the atomic queue manifest live in Application Support/PrivateCaptures, outside Photos and the Files browser. Origin+installation subfolders, backup exclusion and protection available after first device unlock keep session data private while allowing admitted background transfers. Upgrade moves legacy Documents/Captures intact when safe; conflicting locations or corrupt manifests are preserved and block unsafe overwrites. Unowned originals are never silently reassigned to a new installation.

The camera has a Dashboard button, a transparent double-ring record control, and no admin/upload menu or instruction footer. Dashboard has Back to camera, aggregate sync progress/status, two-column inline video players with native scrubbing/fullscreen controls and per-video sync indicators, and End Session. Its Admin dropdown is in the header beside End Session. Synced means the backend accepted the original and committed its receipt, not that processing finished or succeeded. Backend previews are not validated research labels.

Sync starts automatically after queueing completed recordings, connectivity recovery, foreground/relaunch and periodic checks. File-backed background URLSession transfers allow ordinary suspension subject to iOS scheduling; force-quitting pauses delivery until reopening. Multipart MOV uploads are limited to 200 MiB and staged off the UI thread. The persisted capture UUID supplies Idempotency-Key; by-client receipt lookup, UUID echo and original byte size are checked before persisting Synced. Exact retries cannot duplicate accepted captures or charge quota twice. Automatic uploads require authenticated media_contract_version:1; older servers are not assumed to honor idempotency. Failed transfers may restart the whole video, not resume byte offsets. Retry backoff/Retry-After preserve local originals. Progress uses actual sent bytes; ETA uses measured recent speed or explicitly remains unknown.

End Session requires a destructive confirmation. Unsynced or untracked recordings trigger an explicit permanent-loss warning, available ETA and Keep uploading / End & Delete choices. The app journals End intent in Keychain, cancels/waits for owned uploads, requests idempotent self-revocation with its strong refresh proof, and checks the returned installation UUID/revoked flag. Only after matching server acknowledgement does it delete current-session originals/staging/queue and remove credentials, returning to registration. Already-accepted backend originals remain. Failed End retains remaining files/credentials and offers retry; a revocation-confirmed journal resumes cleanup after crashes without auto-login. Other sessions' files are not erased. Deleting the app removes its private local data; offloading retains it. Explicit exports outside the app cannot be cleaned up by the app.

Registration requires two BIP-39 English invite words. Type into the two readable boxes or paste the full phrase into either box to fill both. A space after the first typed word advances focus; pasting never auto-submits. More than two pasted words are retained for correction, not silently discarded. Large accessibility text stacks the boxes. The backend validates the word list and accepts capitalization and repeated whitespace; client parsing preserves case. There is no older-code entry or device-name field. One **Register** button submits without an installation name, allowing the backend's existing default label; errors remain visible after failed attempts, without a redundant introductory status. Keep live invite words out of screenshots and logs. Two words are an explicitly accepted private-pilot guessability tradeoff, not a replacement for strong installation credentials.

## Access and private admin behavior

Older opaque invite codes are no longer accepted for enrollment. Existing installations and their credentials are unchanged; no records are deleted or revoked by this format change.

Access/refresh credentials are persisted in origin-scoped Keychain items using `WhenUnlockedThisDeviceOnly`, without iCloud synchronization. Background uploads also give their authenticated requests to the system-managed URLSession transfer service. No shared secret, App Attest, native passkey registration, or credential logging is used. Only non-secret server origins are stored in preferences. Credential-bearing requests refuse redirects and use normal system TLS validation. Collector and optional private admin settings accept HTTPS root origins only, with no embedded username/password, path, query, or fragment; the two origins must differ, including by port when sharing a hostname.

Registration calls `POST /api/v1/auth/enroll`, saves the returned per-installation credentials, then validates `GET /api/v1/auth/me`. It never automatically retries enrollment. A lost enrollment response or failed Keychain write may mean the single-use invite was consumed: keep the entered invite in the form and ask the administrator for help if retry is rejected. The server alone validates and consumes invites.

Expired access refreshes through `POST /api/v1/auth/token`. An `access_invalid` response gets one refresh retry; `access_revoked` never refreshes, and `refresh_invalid` requires administrator help or a new invite. Network/5xx failures offer retry without deleting credentials or captures. Rate limits respect `Retry-After`. Clock estimates are advisory; the backend decides credential validity.

Collectors do not need Tailscale. **Admin login** and **Server addresses** are hidden until the retained private HTTPS origin returns HTTP 200 JSON `{ "service": "too-much-trash-admin", "version": 1 }` from `/api/v1/admin/reachability`. Public health and localhost admin discovery never grant these controls. Redirects, HTML/captive portals, incorrect identity/version, unreachable hosts, and missing private configuration keep them hidden. The active app reprobes at three-second intervals; suspension hides them and a tap revalidates reachability before opening the private HTTPS root in the external system browser. This is a reachability check, not admin authentication. Authorized tailnet connectivity is required; passkeys do not provide network access. The portal retains its development admin gate; passkey enrollment/recovery and external app distribution remain separate phases.

The initial capture screen uses portrait orientation. Backgrounding the app or a camera interruption ends the held recording. This first version does not implement the project's future rolling pre-grasp buffer or event labels.

## Development

The laptop runs one development stack. Simulator can use `http://localhost:8082`
or `https://too-much-trash-eric-dev.mongoose-bonito.ts.net:10000` for capture.
Admin uses `https://too-much-trash-eric-dev.mongoose-bonito.ts.net:8443` with
either collector route; its cookies require HTTPS. Device/Release collector
access always uses HTTPS. Fresh configuration uses the development Tailscale
preset; saved configuration takes precedence. The settings sheet offers an
explicit development Tailscale preset and a Simulator localhost toggle, requiring
Save before switching. New/unauthenticated Simulator sessions can fall back to
localhost when the designated admin is unreachable; authorized sessions retain
their original collector through network loss. Local HTTP reachability alone
does not grant admin controls. This is a development preset, not a deployed
production service; the future Mac mini environment remains separate.

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

Backend Agent owns the development app node, routing and Compose runtime. Use
its current documentation; enrollment requires a separately approved invitation.
Preserve existing Simulator Keychain/queues and saved origins during updates.

Install XcodeGen (`brew install xcodegen`), run `xcodegen generate` in this directory, and open `TooMuchTrash.xcodeproj` from the same checkout. Edit `project.yml` for project configuration; generated Xcode projects are ignored by Git.

Run the `TooMuchTrash` scheme. Unit tests cover capture hold/release races, Keychain roundtrip and isolation, onboarding validation, revoked/invalid/offline/refresh/enrollment failures, strict admin identity checks, safe HTTPS origins, multipart upload contract, queue durability and identity isolation. UI tests check registration, camera/dashboard navigation, nondestructive End confirmation, admin controls and relaunch. No mock authorization bypass is built into the app. A simulator has no usable rear capture camera, so recording and hardware events require an iPhone. `NativeSessionIntegrationTests` is opt-in: it requires explicitly approved private invite.json/sample.mov fixtures in the app's temporary native-session-fixture directory, a unique Keychain namespace, and isolated private queue. Ordinary runs skip it when fixtures are absent; never provision live user credentials for it.

Real Keychain tests require Xcode's normal simulator ad hoc signing; an entirely unsigned simulator app cannot access Keychain. This uses no paid membership or developer certificate and does not sign or distribute an iPhone build. Example simulator test flags: `CODE_SIGNING_ALLOWED=YES CODE_SIGN_IDENTITY=-`. Hardware compilation can use `CODE_SIGNING_ALLOWED=NO` until device signing is explicitly configured.

## iPhone validation

Select your signing team in Xcode, connect an iPhone, and run the app. Configure administrator-provided URLs and register with a live invite, then verify:

- The rear preview appears immediately after permission is granted.
- Holding either volume button starts recording; releasing stops and saves.
- A quick press/release does not leave recording running.
- Overlapping presses continue recording until both buttons are released.
- The onscreen hold button has the same behavior.
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
