# Physical Apple Watch setup and installation

## Verified outcome — 2026-11-11

Eric confirmed the Too Much Trash dashboard opened on his physical Apple Watch SE (first generation), watchOS 10.6.2, after a USB-relayed developer installation. The companion was an iPhone 15 Pro. Free Personal Team signing worked; paid membership was not needed for this installation. Installation completion and bundle lookup were verified separately before the user confirmed launch. Dashboard launch does not validate every Watch action or synchronization behavior.

## Setup and signing

1. Preserve the user's normal iPhone–Watch pairing and app data. Connect the paired iPhone to the Mac by USB, unlock both devices, keep them nearby, and accept legitimate Trust prompts. Prefer the existing Mac account; do not reset trust, erase devices, or use the production Mac mini as routine setup.
2. Open the active worktree's generated Xcode project. Use `ios/project.yml` as source of truth and regenerate with XcodeGen when configuration changes. Select the **physical Watch**, not a paired Simulator. Xcode 27.2 successfully exposed the physical Watch and enabled its Developer Mode setup in this investigation; do not claim this is the minimum required Xcode version.
3. Enable Developer Mode on both devices. Watch activation requires restarting and then accepting the second **Turn On** confirmation. Recheck that the setting remains enabled. If it disappears, first investigate development discovery rather than cycling resets repeatedly.
4. In the Watch target's Signing & Capabilities, select the existing Personal Team with automatic signing. The GUI had Team **None** even though CLI builds had passed a team. Selecting the team **and physical Watch destination** let Xcode register the Watch and generate a profile including it. Confirm the selected destination actually changed; an accessibility click on the destination label alone previously failed to select it.
5. Build the signed iPhone companion and Watch app for devices. Use the current deployment target compatible with the Watch (10.0 in the successful build). Inspect the embedded Watch provisioning profile locally: its `ProvisionedDevices` must include the Watch UDID, it must be unexpired, and identifiers/signatures must match. An iPhone-only profile inside the Watch bundle is insufficient. Do not print private signing material.
6. Install the companion on the iPhone in place, preserving its bundle ID, signing team and data. Then install the signed Watch `.app` using the route below if ordinary Xcode deployment remains unreliable.

## Verified USB developer relay

This is different from tapping **Install** in the iPhone's Watch app. That consumer route returned `MIInstallerErrorDomain Code=111`: a free provisioning profile was not allowed **from that source**. It did not establish that free-account Watch development was unsupported.

The working route uses pymobiledevice3 **11.52.1**:

- `CompanionProxyService` opens a temporary forward for Watch lockdown port 62078 through the USB iPhone.
- Load the existing Watch pairing record and validate it; never generate another identity as part of the installer.
- Forward each Watch service port requested by lockdown through the same companion proxy, preserving TLS.
- Use `StreamingZipConduitService.install(..., developer=True)` for the signed Watch `.app`.
- Verify the bundle through `InstallationProxyService.lookup`, then confirm launch on the Watch.
- Close temporary forwards when finished. The helper does not change persistent pairing, bypass signing checks, or uninstall the app.

Run from the repository root, substituting discovered device IDs and the newly built Watch app path:

```sh
# Default is a read-only trust / installed-app check.
uv run --with pymobiledevice3==11.52.1 python \
  .agents/skills/iphone-agent/scripts/watch_usb_install.py \
  --phone "$PHONE_UDID" --watch "$WATCH_UDID"

# Installation is explicit. Pass the Watch app, not the parent iPhone app.
uv run --with pymobiledevice3==11.52.1 python \
  .agents/skills/iphone-agent/scripts/watch_usb_install.py \
  --phone "$PHONE_UDID" --watch "$WATCH_UDID" \
  --app "$SIGNED_WATCH_APP" --install
```

Discover physical devices using `xcrun devicectl list devices` and the paired Watch registry using `uvx pymobiledevice3 companion list`. The helper stops on absent/rejected existing trust or a mismatched device. Its successful predecessor installed the actual app; the parameterized helper is additionally checked in read-only mode. An absent bundle during a read-only check is not an installation success.

## What the failures taught us

- Watch Wi-Fi connectivity and cached Bonjour advertisements did not establish a usable Xcode development tunnel. Network timeouts, Bluetooth bring-up fallback and failed DDI mounts persisted even after pairing succeeded.
- The USB relay accepted existing trust and exposed installation services without requiring a successful Xcode network tunnel or DDI mount.
- Generic AFC staging returned `InvalidServiceError` on this Watch; streaming ZIP developer installation succeeded. Do not repeat the AFC path as the default.
- The successful run occurred with iPhone Bluetooth off, USB connected, and the Watch on home Wi-Fi. This does not prove Bluetooth must always be off or that the relay works without Watch Wi-Fi. Restore normal connectivity when troubleshooting is over, and verify rather than prescribe the workaround universally.
- Personal Team provisioning is temporary (normally seven days); renew/rebuild/reinstall when it expires. A successful install does not remove that limit.
- Diagnostic logging profiles were used during investigation, not required by this installation procedure. Remove temporary logging profiles when diagnostics are no longer needed, with user involvement for device settings.
