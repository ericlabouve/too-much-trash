# iPhone app

The app opens to Home with **User login / Continue** and **Register with invite**. Configure the public collector HTTPS origin in **Server addresses**; no server address is guessed or activated by the app. Register with a manually distributed single-use invite, or continue with credentials already stored in Keychain. Returning credentials are validated by the backend before opening capture; their presence alone does not authorize access.

After authorization, the rear camera opens. Hold either volume button (or the onscreen record button) to record; release to finish and save. Camera access is requested when entering capture. Requires iOS 17.2 or later for Apple's `AVCaptureEventInteraction` hardware capture API. Physical button and camera behavior still require iPhone validation.

Recordings are video only, stored as `.mov` files in the app's `Documents/Captures` directory. The share button exports the last successful recording in the current camera session; older clips are accessible through Files. Keep the app installed to retain local files. Failed recording files are preserved for diagnosis.

Successful recordings enter a disk-backed upload queue bound to the original public origin and installation UUID. **Upload queued videos** sends authorized multipart MOV files up to 200 MiB. Upload receipts persist, **Check status** updates backend processing state, and local videos are retained after successful uploads as well as auth/network/quota failures. Backend processing currently provides previews, not validated segmentation labels. Files belonging to another installation or server are retained and never silently reassigned; recovery requires administrator coordination. Clips recorded before onboarding was added remain local and are not automatically imported.

Uploads are manual and occur in the foreground. If a response is lost after the server accepts an upload, explicit retry may create a duplicate; V1 has no upload idempotency contract. Unreadable queue metadata is preserved without overwriting it. Keep `upload-queue.json` intact when browsing the Captures folder.

## Access and private admin behavior

Access/refresh credentials are stored only in origin-scoped Keychain items using `WhenUnlockedThisDeviceOnly`, without iCloud synchronization. No shared secret, App Attest, native passkey registration, or credential logging is used. Only non-secret server origins are stored in preferences. Credential-bearing requests refuse redirects and use normal system TLS validation. Collector and optional private admin settings accept HTTPS root origins only, with no embedded username/password, path, query, or fragment; the two origins must differ, including by port when sharing a hostname.

Registration calls `POST /api/v1/auth/enroll`, saves the returned per-installation credentials, then validates `GET /api/v1/auth/me`. It never automatically retries enrollment. A lost enrollment response or failed Keychain write may mean the single-use invite was consumed: keep the entered invite in the form and ask the administrator for help if retry is rejected. The server alone validates and consumes invites.

Expired access refreshes through `POST /api/v1/auth/token`. An `access_invalid` response gets one refresh retry; `access_revoked` never refreshes, and `refresh_invalid` requires administrator help or a new invite. Network/5xx failures offer retry without deleting credentials or captures. Rate limits respect `Retry-After`. Clock estimates are advisory; the backend decides credential validity.

Collectors do not need Tailscale. **Admin login** is hidden until the separately configured private origin returns HTTP 200 JSON `{ "service": "too-much-trash-admin", "version": 1 }` from `/api/v1/admin/reachability`. Public health is never used. Redirects, HTML/captive portals, incorrect identity/version, unreachable hosts, and missing private configuration keep the button hidden. Home reprobes every 15 seconds; suspension hides it and a tap revalidates reachability before opening the private root in the external system browser. This is a reachability check, not admin authentication. Authorized tailnet connectivity is required; passkeys do not provide network access. The portal retains its development admin gate; passkey enrollment/recovery and external app distribution remain separate phases.

The initial capture screen uses portrait orientation. Backgrounding the app or a camera interruption ends the held recording. This first version does not implement the project's future rolling pre-grasp buffer or event labels.

## Development

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
