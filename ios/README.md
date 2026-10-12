# iPhone app

The app opens to collector Home with **User login / Continue** and **Register with invite**. **Server addresses** and **Admin login** are visible only while the designated private HTTPS admin endpoint is reachable. Register with a manually distributed single-use invite, or continue with credentials already stored in Keychain. Returning credentials are validated by the backend before opening capture; their presence alone does not authorize access.

After authorization, the rear camera opens. Hold either volume button (or the onscreen record button) to record; release to finish and save. Camera access is requested when entering capture. Requires iOS 17.2 or later for Apple's `AVCaptureEventInteraction` hardware capture API. Physical button and camera behavior still require iPhone validation.

Recordings are video only, stored as `.mov` files in the app's `Documents/Captures` directory. The share button exports the last successful recording in the current camera session; older clips are accessible through Files. Keep the app installed to retain local files. Failed recording files are preserved for diagnosis.

Successful recordings enter a disk-backed upload queue bound to the original public origin and installation UUID. **Upload queued videos** sends authorized multipart MOV files up to 200 MiB. Upload receipts persist, **Check status** updates backend processing state, and local videos are retained after successful uploads as well as auth/network/quota failures. Backend processing currently provides previews, not validated segmentation labels. Files belonging to another installation or server are retained and never silently reassigned; recovery requires administrator coordination. Clips recorded before onboarding was added remain local and are not automatically imported.

Uploads are manual and occur in the foreground. If a response is lost after the server accepts an upload, explicit retry may create a duplicate; V1 has no upload idempotency contract. Unreadable queue metadata is preserved without overwriting it. Keep `upload-queue.json` intact when browsing the Captures folder.

Registration requires two BIP-39 English invite words. Type into the two readable boxes or paste the full phrase into either box to fill both. A space after the first typed word advances focus; pasting never auto-submits. More than two pasted words are retained for correction, not silently discarded. Large accessibility text stacks the boxes. The backend validates the word list and accepts capitalization and repeated whitespace; client parsing preserves case. There is no older-code entry or device-name field. One **Register** button submits without an installation name, allowing the backend's existing default label; errors remain visible after failed attempts, without a redundant introductory status. Keep live invite words out of screenshots and logs. Two words are an explicitly accepted private-pilot guessability tradeoff, not a replacement for strong installation credentials.

## Access and private admin behavior

Older opaque invite codes are no longer accepted for enrollment. Existing installations and their credentials are unchanged; no records are deleted or revoked by this format change.

Access/refresh credentials are stored only in origin-scoped Keychain items using `WhenUnlockedThisDeviceOnly`, without iCloud synchronization. No shared secret, App Attest, native passkey registration, or credential logging is used. Only non-secret server origins are stored in preferences. Credential-bearing requests refuse redirects and use normal system TLS validation. Collector and optional private admin settings accept HTTPS root origins only, with no embedded username/password, path, query, or fragment; the two origins must differ, including by port when sharing a hostname.

Registration calls `POST /api/v1/auth/enroll`, saves the returned per-installation credentials, then validates `GET /api/v1/auth/me`. It never automatically retries enrollment. A lost enrollment response or failed Keychain write may mean the single-use invite was consumed: keep the entered invite in the form and ask the administrator for help if retry is rejected. The server alone validates and consumes invites.

Expired access refreshes through `POST /api/v1/auth/token`. An `access_invalid` response gets one refresh retry; `access_revoked` never refreshes, and `refresh_invalid` requires administrator help or a new invite. Network/5xx failures offer retry without deleting credentials or captures. Rate limits respect `Retry-After`. Clock estimates are advisory; the backend decides credential validity.

Collectors do not need Tailscale. **Admin login** and **Server addresses** are hidden until the retained private HTTPS origin returns HTTP 200 JSON `{ "service": "too-much-trash-admin", "version": 1 }` from `/api/v1/admin/reachability`. Public health and localhost admin discovery never grant these controls. Redirects, HTML/captive portals, incorrect identity/version, unreachable hosts, and missing private configuration keep them hidden. The active app reprobes at three-second intervals; suspension hides them and a tap revalidates reachability before opening the private HTTPS root in the external system browser. This is a reachability check, not admin authentication. Authorized tailnet connectivity is required; passkeys do not provide network access. The portal retains its development admin gate; passkey enrollment/recovery and external app distribution remain separate phases.

The initial capture screen uses portrait orientation. Backgrounding the app or a camera interruption ends the held recording. This first version does not implement the project's future rolling pre-grasp buffer or event labels.

## Development

Debug Simulator builds automatically use the isolated `http://localhost:18082` collector when the designated HTTPS admin service is unreachable. Admin login and Server Addresses are hidden, and an open settings sheet dismisses. Local HTTP admin discovery does not reveal those menus. The retained HTTPS probe configuration allows reconnection to reveal them later. Reachability is polled throughout the active app (three-second intervals plus request latency); loss is detected on a failed probe, not instantaneously. Any in-flight enrollment/upload finishes before the origin switch. Selecting **Local backend (no Tailscale)** is independent of connectivity: it fills both localhost fields, keeps the sheet open, and waits for **Save addresses**. Connected admins retain their admin view and may open the selected local admin portal after both network and local identity checks.

Local mode explicitly permits HTTP `localhost` root origins only; it does not bypass enrollment, Keychain validation, quotas, or admin authentication. Its localhost ATS exception is included only in Debug Simulator builds. Physical iPhone and Release builds have neither the local-mode UI nor HTTP acceptance/ATS exceptions, and retain their HTTPS collector configuration. Credentials and queued files remain scoped to their original origin; switching to localhost does not adopt earlier captures. Authn/authz redesign is deferred: this user/admin view distinction does not revoke browser sessions or change backend permissions.

Validate the isolated local development backend first, then the Tailscale pilot. Backend Agent owns the separate Compose dev project/data/credentials and its HTTP development cookies; the HTTPS pilot's secure cookies remain unchanged. Start that stack using its current backend documentation. Registration/upload there still require a separately approved dev invite. No hardcoded tailnet hostname is supplied: preserve/provision the designated non-secret HTTPS network configuration before expecting admin menus on reconnection.

Install XcodeGen (`brew install xcodegen`), run `xcodegen generate` in this directory, and open `TooMuchTrash.xcodeproj` from the same checkout. Edit `project.yml` for project configuration; generated Xcode projects are ignored by Git.

Run the `TooMuchTrash` scheme. Unit tests cover capture hold/release races, Keychain roundtrip and isolation, onboarding validation, revoked/invalid/offline/refresh/enrollment failures, strict admin identity checks, safe HTTPS origins, multipart upload contract, queue durability and identity isolation. UI tests check Home, absent admin/capture before authorization, relaunch, and unsafe-address rejection. No mock authorization bypass is built into the app. A simulator has no usable rear capture camera, so recording and hardware events require an iPhone.

Real Keychain tests require Xcode's normal simulator ad hoc signing; an entirely unsigned simulator app cannot access Keychain. This uses no paid membership or developer certificate and does not sign or distribute an iPhone build. Example simulator test flags: `CODE_SIGNING_ALLOWED=YES CODE_SIGN_IDENTITY=-`. Hardware compilation can use `CODE_SIGNING_ALLOWED=NO` until device signing is explicitly configured.

## iPhone validation

Select your signing team in Xcode, connect an iPhone, and run the app. Configure administrator-provided URLs and register with a live invite, then verify:

- The rear preview appears immediately after permission is granted.
- Holding either volume button starts recording; releasing stops and saves.
- A quick press/release does not leave recording running.
- Overlapping presses continue recording until both buttons are released.
- The onscreen hold button has the same behavior.
- Backgrounding or locking during recording ends it; foregrounding restores the preview.
- Export the saved clip and check playback, portrait orientation, and duration.
- Denying camera permission shows an Open Settings action and disables recording.
- Relaunch validates saved credentials without requiring another invite.
- Disconnecting the network offers retry and retains credentials and queued videos.
- Revoking the installation blocks access and requires administrator help/new invite.
- Upload, relaunch, and inspect processing status; verify local videos remain.
- Without tailnet connectivity, Admin login stays hidden. With authorized connectivity, it opens only the private browser portal.

Simulator checks and injected API contract tests do not establish live backend integration, deployment exposure, physical capture, or hardware button behavior. No signing/distribution or live Funnel activation is performed by this implementation.

### Private HTTPS integration checkpoint — 2026-10-10

The Simulator app accepted the private pilot's configurable collector/admin HTTPS origins. Its native private-admin identity probe passed using normal TLS, revealed **Admin login**, and handed off to Safari, where the private admin gate rendered without a certificate warning. No admin sign-in was attempted. With an approved short-lived, low-quota invite, a temporary native XCTest passed real `AccountSession.register`, `LiveCollectorAPI`, Keychain storage, and fresh-session `/me` validation. Normal app relaunch reached capture using saved credentials; after backend revocation, another relaunch showed rejected/revoked access and did not open capture. The temporary harness and Simulator invite file were removed; credentials were not printed. Live app upload and physical camera/button behavior remain unverified. The private pilot requires authorized tailnet connectivity on test devices; Funnel remains disabled. A future server migration must use explicit configuration and preserve existing queues' origin/installation ownership.
