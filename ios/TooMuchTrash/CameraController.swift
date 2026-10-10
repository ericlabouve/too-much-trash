import AVFoundation
import Combine
import Foundation

// AVFoundation state is confined to `queue`; UI state is confined to MainActor.
// The immutable session reference is shared with AVFoundation's preview layer.
final class CameraController: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate, @unchecked Sendable {
    @MainActor @Published private(set) var isReady = false
    @MainActor @Published private(set) var isFinishing = false
    @MainActor @Published private(set) var permissionDenied = false
    @MainActor @Published private(set) var status = "Opening camera…"
    @MainActor @Published private(set) var recordingStartedAt: Date?
    @MainActor @Published private(set) var latestClip: URL?
    @MainActor var onClipSaved: ((URL) -> Void)?

    let session = AVCaptureSession()
    private let queue = DispatchQueue(label: "org.toomuchtrash.capture")
    private let output = AVCaptureMovieFileOutput()
    private var configured = false
    private var active = false
    private var hold = HoldRecordingState()
    private var observers: [NSObjectProtocol] = []

    override init() {
        super.init()
        let center = NotificationCenter.default
        observers.append(center.addObserver(forName: AVCaptureSession.wasInterruptedNotification,
                                            object: session, queue: nil) { [weak self] _ in
            self?.interrupt(message: "Camera interrupted. Your clip is being saved.")
        })
        observers.append(center.addObserver(forName: AVCaptureSession.interruptionEndedNotification,
                                            object: session, queue: nil) { [weak self] _ in
            guard let self else { return }
            self.queue.async { if self.active { self.startSession() } }
        })
        observers.append(center.addObserver(forName: AVCaptureSession.runtimeErrorNotification,
                                            object: session, queue: nil) { [weak self] _ in
            self?.interrupt(message: "Camera stopped. Reopen the app to retry.")
        })
    }

    deinit { observers.forEach(NotificationCenter.default.removeObserver) }

    @MainActor
    func activate() async {
        queue.async { self.active = true }
        let granted: Bool
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: granted = true
        case .notDetermined: granted = await AVCaptureDevice.requestAccess(for: .video)
        default: granted = false
        }
        guard granted else {
            permissionDenied = true
            status = "Allow camera access to record pickup attempts."
            return
        }
        permissionDenied = false
        queue.async {
            guard self.active else { return }
            self.startSession()
        }
    }

    func deactivate() {
        queue.async {
            self.active = false
            self.perform(self.hold.cancel())
            if self.session.isRunning { self.session.stopRunning() }
            self.publish { $0.isReady = false }
        }
    }

    func press(_ source: String) {
        queue.async {
            guard self.active, self.session.isRunning, !self.session.isInterrupted,
                  self.configured else { return }
            self.perform(self.hold.press(source))
        }
    }

    func release(_ source: String) {
        queue.async { self.perform(self.hold.release(source)) }
    }

    private func startSession() {
        do {
            if !configured { try configure() }
            if !session.isRunning { session.startRunning() }
            let ready = session.isRunning && !session.isInterrupted
            publish {
                $0.isReady = ready
                if $0.recordingStartedAt == nil && !$0.isFinishing {
                    $0.status = ready ? "Ready to record" : "Camera unavailable. Reopen the app to retry."
                }
            }
        } catch {
            publish { $0.isReady = false; $0.status = error.localizedDescription }
        }
    }

    private func configure() throws {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            throw CameraError.unavailable
        }
        let input = try AVCaptureDeviceInput(device: device)
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        session.sessionPreset = .high
        guard session.canAddInput(input) else { throw CameraError.configuration }
        session.addInput(input)
        guard session.canAddOutput(output) else {
            session.removeInput(input)
            throw CameraError.configuration
        }
        session.addOutput(output)
        // Video only: no microphone access or audio capture is requested.
        configured = true
    }

    private func perform(_ action: HoldRecordingState.Action) {
        switch action {
        case .none: break
        case .start:
            do {
                let folder = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                          appropriateFor: nil, create: true)
                    .appendingPathComponent("Captures", isDirectory: true)
                try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
                let url = folder.appendingPathComponent("pickup-\(UUID().uuidString).mov")
                if let connection = output.connection(with: .video), connection.isVideoRotationAngleSupported(90) {
                    connection.videoRotationAngle = 90
                }
                publish { $0.status = "Starting recording…" }
                output.startRecording(to: url, recordingDelegate: self)
            } catch {
                hold.didFinish()
                publish { $0.status = "Could not create recording: \(error.localizedDescription)" }
            }
        case .stop:
            publish { $0.isFinishing = true; $0.status = "Saving recording…" }
            output.stopRecording()
        }
    }

    private func interrupt(message: String) {
        queue.async {
            self.perform(self.hold.cancel())
            self.publish { $0.isReady = false; $0.status = message }
        }
    }

    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL,
                    from connections: [AVCaptureConnection]) {
        queue.async {
            self.publish { $0.recordingStartedAt = Date(); $0.status = "Recording" }
            self.perform(self.hold.didStart())
        }
    }

    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection], error: Error?) {
        queue.async {
            self.hold.didFinish()
            let successful = error == nil ||
                (error as NSError?)?.userInfo[AVErrorRecordingSuccessfullyFinishedKey] as? Bool == true
            self.publish {
                $0.recordingStartedAt = nil
                $0.isFinishing = false
                if successful {
                    $0.latestClip = outputFileURL
                    $0.onClipSaved?(outputFileURL)
                    $0.status = "Recording saved on this iPhone"
                } else {
                    // Preserve unsuccessful files for diagnosis instead of deleting them.
                    $0.status = "Recording failed: \(error?.localizedDescription ?? "Unknown error")"
                }
            }
        }
    }

    private func publish(_ update: @escaping @MainActor @Sendable (CameraController) -> Void) {
        DispatchQueue.main.async { update(self) }
    }

    private enum CameraError: LocalizedError {
        case unavailable, configuration
        var errorDescription: String? {
            switch self {
            case .unavailable: return "No camera available. Use an iPhone to record."
            case .configuration: return "Could not configure the camera. Reopen the app to retry."
            }
        }
    }
}
