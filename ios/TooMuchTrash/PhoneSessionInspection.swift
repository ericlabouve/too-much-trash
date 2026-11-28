#if DEBUG
import Foundation

/// Read-only diagnostics; never bootstraps, signs out, or exports credentials.
@MainActor enum PhoneSessionInspection {
    static func run() {
        let report = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("session-state.json")
        var state: [String: Any] = [:]
        do {
            let configuration = APIConfiguration.initial()
            let credential = try KeychainCredentialVault().load(origin: configuration.publicOrigin)
            state = ["readable": true, "installation_id": credential?.installationID.uuidString.lowercased() as Any? ?? NSNull(), "has_saved_credential": credential != nil,
                     "signout_pending": credential?.endingSession == true,
                     "revocation_confirmed": credential?.revocationConfirmed == true,
                     "last_stage": UserDefaults.standard.string(forKey: "signoutLastStage") ?? "unknown",
                     "last_error": UserDefaults.standard.string(forKey: "signoutLastError") ?? "none",
                     "last_deletion_error": UserDefaults.standard.string(forKey: "lastDeletionError") ?? "none"]
        } catch { state = ["readable": false] }
        try? JSONSerialization.data(withJSONObject: state, options: [.sortedKeys]).write(to: report, options: .atomic)
        if ProcessInfo.processInfo.arguments.contains("-probe-delete-connection") {
            Task { @MainActor in
                var network: [String: Any] = [:]
                let configuration = APIConfiguration.initial()
                let transport = SecureHTTPTransport()
                for (name, path, method) in [("health", "api/v1/health", "GET"),
                    ("delete_route", "api/v1/continuous/00000000-0000-0000-0000-000000000000", "OPTIONS")] {
                    var request = URLRequest(url: configuration.endpoint(path)); request.httpMethod = method; request.timeoutInterval = 8
                    do { let (_, response) = try await transport.data(for: request); network[name] = response.statusCode }
                    catch { let ns = error as NSError; network[name] = "\(ns.domain):\(ns.code)" }
                }
                network["complete"] = true
                let file = report.deletingLastPathComponent().appendingPathComponent("connection-check.json")
                try? JSONSerialization.data(withJSONObject: network, options: [.sortedKeys]).write(to: file, options: .atomic)
            }
        }
    }
}
#endif
