import Foundation
import WatchConnectivity

/// The phone remains the source of truth for capture, account, and deletion.
@MainActor
final class WatchBridge: NSObject, WCSessionDelegate {
    private weak var account: AccountSession?
    private let session: WCSession? = WCSession.isSupported() ? .default : nil
    private var timer: Timer?
    private var lastQuotaRefresh = Date.distantPast
    private var lastPayload: NSDictionary?

    private func sendContext(_ values: [String: Any], session: WCSession) {
        guard lastPayload?.isEqual(to: values) != true else { return }
        var context = values
        context["updated"] = Date().timeIntervalSince1970
        do { try session.updateApplicationContext(context); lastPayload = values as NSDictionary }
        catch { lastPayload = nil }
    }

    static func scoreKey(_ owner: AccountSession.CaptureOwner) -> String {
        "watchScore." + owner.origin.absoluteString + "." + owner.installationID.uuidString
    }

    static func record(_ captures: [QueuedCapture], owner: AccountSession.CaptureOwner) {
        _ = WatchScore(defaults: .standard, key: scoreKey(owner)).observe(captures.map(\.id))
    }

    func start(account: AccountSession) {
        guard self.account == nil, let session else { return }
        self.account = account
        session.delegate = self
        session.activate()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            Task { @MainActor in self?.publish() }
        }
        publish()
    }

    private func publish() {
        guard let account, let session, session.activationState == .activated else { return }
        guard account.phase == .authorized, let owner = account.captureOwner, let installation = account.installation else {
            sendContext(["authorized": false], session: session)
            return
        }
        let key = Self.scoreKey(owner)
        let score = WatchScore(defaults: .standard, key: key).observe(account.currentCaptures.map(\.id))
        let synced = WatchScore(defaults: .standard, key: key + ".synced").observe(account.currentCaptures.filter { $0.receipt != nil }.map(\.id))
        let clips = account.currentCaptures
        let latest = clips.max { ($0.createdAt ?? .distantPast) < ($1.createdAt ?? .distantPast) }
        var payload: [String: Any] = ["authorized": true, "score": score,
            "pending": account.pendingCaptures.count, "synced": synced, "uploading": account.isUploading,
            "progress": score == 0 ? 1.0 : min(1.0, (Double(synced) + account.uploadProgress.values.reduce(0, +)) / Double(score)),
            "message": account.uploadMessage, "dev": account.supportsBackendVideoDeletion,
            "unlimited": installation.developmentSession == true]
        if let latest {
            payload["latestID"] = latest.id.uuidString
            payload["latestSynced"] = latest.receipt?.clientCaptureID == latest.id
            if let created = latest.createdAt { payload["latestAt"] = created.timeIntervalSince1970 }
        }
        if let reachable = account.watchServerReachable { payload["serverReachable"] = reachable }
        if installation.developmentSession != true, installation.quotaBytes > 0, installation.quotaUploads > 0 {
            let bytes = max(0, Double(installation.quotaBytes - installation.usedBytes) / Double(installation.quotaBytes))
            let count = max(0, Double(installation.quotaUploads - installation.usedUploads) / Double(installation.quotaUploads))
            payload["quota"] = min(1, bytes, count)
        }
        sendContext(payload, session: session)
        if Date().timeIntervalSince(lastQuotaRefresh) > 60 {
            lastQuotaRefresh = Date()
            Task { await account.refreshWatchQuota() }
        }
    }

    nonisolated func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        Task { @MainActor in self.lastPayload = nil; self.publish() }
    }
    nonisolated func sessionDidBecomeInactive(_ session: WCSession) {}
    nonisolated func sessionDidDeactivate(_ session: WCSession) { session.activate() }
    nonisolated func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        Task { @MainActor in
            guard let account = self.account, account.phase == .authorized else { replyHandler(["error": "Open the iPhone app first."]); return }
            if message["action"] as? String == "sync" {
                account.requestWatchSync(); self.publish(); replyHandler(["ok": true]); return
            }
            guard message["action"] as? String == "undo", let raw = message["id"] as? String,
                  let id = UUID(uuidString: raw), let owner = account.captureOwner,
                  let latest = account.currentCaptures.max(by: { ($0.createdAt ?? .distantPast) < ($1.createdAt ?? .distantPast) }), latest.id == id else {
                replyHandler(["error": "The latest video changed. Please try again."]); return
            }
            let backend = message["backend"] as? Bool == true
            let error: String?
            if backend { error = await account.deleteCaptureHereAndBackend(id) }
            else { error = await account.deleteLocalCapture(id) ? nil : "Wait for uploads to finish, then try again." }
            if let error { replyHandler(["error": error]); return }
            let key = Self.scoreKey(owner)
            WatchScore(defaults: .standard, key: key).undo(id)
            WatchScore(defaults: .standard, key: key + ".synced").undo(id)
            self.publish(); replyHandler(["ok": true])
        }
    }
}
