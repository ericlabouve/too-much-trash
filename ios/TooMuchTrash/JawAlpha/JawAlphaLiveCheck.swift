#if DEBUG
import Foundation
import AVFoundation

enum JawAlphaLiveCheck {
    @MainActor static func run() async {
        let folder = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("AlphaLiveCheck")
        do {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else { throw ClientError.configuration }
            let engine = try EpisodeCaptureEngine(ownerDirectory: folder)
            guard engine.start() else { throw ClientError.configuration }
            try await Task.sleep(for: .seconds(2))
            engine.setFullRecording(true)
            try await Task.sleep(for: .seconds(14))
            engine.stop(reason: "isolated_live_check")
            try await Task.sleep(for: .seconds(3))
            try Data("complete".utf8).write(to: folder.appendingPathComponent("check-complete.txt"))
        } catch { try? Data(error.localizedDescription.utf8).write(to: folder.appendingPathComponent("check-error.txt")) }
    }
}
#endif
