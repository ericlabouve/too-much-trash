#if DEBUG
import Foundation
import AVFoundation

enum FullRecordingSyncCheck {
    @MainActor static func run(_ account: AccountSession) async {
        let report = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("full-sync-check.json")
        var stage = "bootstrap"
        do {
            try JSONSerialization.data(withJSONObject: ["stage": "bootstrap", "uploaded": false]).write(to: report, options: .atomic)
            await account.bootstrap(probeAdmin: false)
            stage = "access: \(account.phase), dev=\(account.configuration?.publicOrigin == APIConfiguration.developmentNetwork.publicOrigin), owner=\(account.captureOwner != nil), camera=\(AVCaptureDevice.authorizationStatus(for: .video).rawValue)"
            guard account.phase == .authorized, account.configuration?.publicOrigin == APIConfiguration.developmentNetwork.publicOrigin,
                  let owner = account.captureOwner, AVCaptureDevice.authorizationStatus(for: .video) == .authorized else { throw ClientError.configuration }
            let directory = try account.queue.recordingDirectory(origin: owner.origin, installationID: owner.installationID)
            stage = "checking existing cleanup session"
            guard account.cleanup.activeID == nil else { throw ClientError.configuration }
            let cleanupID = UUID()
            stage = "creating cleanup session"
            try account.cleanup.start(id: cleanupID)
            try account.cleanup.edit(id: cleanupID, name: "Development upload check", description: "Synthetic development test; no GPS collection or field labels.")
            let before = Set(try FileManager.default.contentsOfDirectory(atPath: directory.path))
            stage = "starting camera"
            let engine = try EpisodeCaptureEngine(ownerDirectory: directory)
            engine.setCleanupSession(cleanupID)
            guard engine.start() else { throw ClientError.configuration }
            try await Task.sleep(for: .seconds(3))
            engine.setFullRecording(true)
            try await Task.sleep(for: .seconds(2))
            let press = ProcessInfo.processInfo.systemUptime
            engine.reference(source: "synthetic_development_check", phase: "press", time: press)
            engine.press("synthetic_development_check", at: press)
            try await Task.sleep(for: .seconds(1))
            let release = ProcessInfo.processInfo.systemUptime
            engine.reference(source: "synthetic_development_check", phase: "release", time: release)
            engine.release("synthetic_development_check", at: release)
            try await Task.sleep(for: .seconds(4))
            engine.stop(reason: "synthetic_development_check")
            try account.cleanup.stop(id: cleanupID)
            try await Task.sleep(for: .seconds(3))
            let after = try FileManager.default.contentsOfDirectory(atPath: directory.path)
            guard let name = after.first(where: { $0.hasPrefix("continuous-") && !before.contains($0) }) else { throw ClientError.storage }
            let folder = directory.appendingPathComponent(name)
            stage = "waiting for metadata and video acknowledgements"
            for _ in 0..<40 {
                account.syncTick()
                if FileManager.default.fileExists(atPath: folder.appendingPathComponent("uploaded.json").path),
                   account.cleanup.records.first(where: { $0.id == cleanupID })?.needsSync == false {
                    try JSONSerialization.data(withJSONObject: ["uploaded": true, "recording": name, "cleanup_session": cleanupID.uuidString.lowercased(), "metadata_synced": true, "synthetic_references": true]).write(to: report, options: .atomic)
                    return
                }
                try await Task.sleep(for: .seconds(3))
            }
            throw ClientError.network
        } catch { try? JSONSerialization.data(withJSONObject: ["uploaded": false, "stage": stage, "error": error.localizedDescription, "access_message": account.message]).write(to: report, options: .atomic) }
    }
}
#endif
