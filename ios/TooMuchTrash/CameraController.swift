import AVFoundation
import ARKit
import Combine
import CoreMotion
import Foundation

// AVFoundation state is confined to `queue`; UI state is confined to MainActor.
// The immutable session reference is shared with AVFoundation's preview layer.
final class CameraController: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate, @unchecked Sendable {
    @MainActor @Published private(set) var isReady = false
    @MainActor @Published private(set) var isFinishing = false
    @MainActor @Published private(set) var isStarting = false
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
    private var recordingDirectory: URL?

    func setRecordingDirectory(_ directory: URL) { queue.async { self.recordingDirectory = directory } }

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
        #if targetEnvironment(simulator)
        status = "No camera available. Use an iPhone to record."
        isReady = false
        return
        #else
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
        #endif
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
                guard let folder = recordingDirectory else { throw CameraError.configuration }
                let url = folder.appendingPathComponent("pickup-\(UUID().uuidString).mov")
                if let connection = output.connection(with: .video), connection.isVideoRotationAngleSupported(90) {
                    connection.videoRotationAngle = 90
                }
                publish { $0.status = "Starting recording…"; $0.isStarting = true }
                output.startRecording(to: url, recordingDelegate: self)
            } catch {
                hold.didFinish()
                publish { $0.status = "Could not create recording: \(error.localizedDescription)"; $0.isStarting = false }
            }
        case .stop:
            publish { $0.isFinishing = true; $0.status = "Saving recording…" }
            output.stopRecording()
        }
    }

    private func interrupt(message: String) {
        queue.async {
            self.perform(self.hold.cancel())
            #if targetEnvironment(simulator)
            let displayMessage = "No camera available. Use an iPhone to record."
            #else
            let displayMessage = message
            #endif
            self.publish { $0.isReady = false; $0.status = displayMessage }
        }
    }

    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL,
                    from connections: [AVCaptureConnection]) {
        queue.async {
            self.publish { $0.recordingStartedAt = Date(); $0.status = "Recording"; $0.isStarting = false }
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
                $0.isStarting = false
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

/// Raw Core Motion samples retain the timestamps supplied by Core Motion.
/// Collection is confined to one operation queue so each stream remains ordered.
struct MotionSample: Codable, Sendable {
    enum Stream: String, Codable, Sendable { case accelerometer, gyroscope, attitude }
    let stream: Stream
    let timestamp: TimeInterval
    let values: [Double]
    let callbackUptime: TimeInterval

    init(stream: Stream, timestamp: TimeInterval, values: [Double]) {
        self.stream = stream
        self.timestamp = timestamp
        self.values = values
        self.callbackUptime = ProcessInfo.processInfo.systemUptime
    }
}

final class MotionSampleCollector {
    private let motion = CMMotionManager()
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "org.toomuchtrash.motion"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    private var active = false
    private var accelerometer = TimedPreRoll<MotionSample>()
    private var gyroscope = TimedPreRoll<MotionSample>()
    private var attitude = TimedPreRoll<MotionSample>()
    /// All callbacks, including failures, run on the collector's serial queue.
    var onSample: ((MotionSample) -> Void)?
    var onFailure: ((String) -> Void)?

    func start() {
        queue.addOperation { [weak self] in
            guard let self, !self.active else { return }
            self.active = true
            self.accelerometer = TimedPreRoll()
            self.gyroscope = TimedPreRoll()
            self.attitude = TimedPreRoll()
            self.motion.accelerometerUpdateInterval = 0.01
            self.motion.gyroUpdateInterval = 0.01
            self.motion.deviceMotionUpdateInterval = 0.01
            if self.motion.isAccelerometerAvailable {
                self.motion.startAccelerometerUpdates(to: self.queue) { [weak self] data, error in
                    guard let self, self.active else { return }
                    guard let data else { if error != nil { self.onFailure?("accelerometer") }; return }
                    let a = data.acceleration
                    self.record(MotionSample(stream: .accelerometer, timestamp: data.timestamp, values: [a.x, a.y, a.z]))
                }
            } else { self.onFailure?("accelerometer unavailable") }
            if self.motion.isGyroAvailable {
                self.motion.startGyroUpdates(to: self.queue) { [weak self] data, error in
                    guard let self, self.active else { return }
                    guard let data else { if error != nil { self.onFailure?("gyroscope") }; return }
                    let v = data.rotationRate
                    self.record(MotionSample(stream: .gyroscope, timestamp: data.timestamp, values: [v.x, v.y, v.z]))
                }
            } else { self.onFailure?("gyroscope unavailable") }
            if self.motion.isDeviceMotionAvailable {
                self.motion.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: self.queue) { [weak self] data, error in
                    guard let self, self.active else { return }
                    guard let data else { if error != nil { self.onFailure?("attitude") }; return }
                    let q = data.attitude.quaternion
                    self.record(MotionSample(stream: .attitude, timestamp: data.timestamp, values: [q.x, q.y, q.z, q.w]))
                }
            } else { self.onFailure?("attitude unavailable") }
        }
    }

    func stop() {
        queue.addOperation { [weak self] in
            guard let self else { return }
            self.active = false
            self.motion.stopAccelerometerUpdates()
            self.motion.stopGyroUpdates()
            self.motion.stopDeviceMotionUpdates()
        }
    }

    private func record(_ sample: MotionSample) {
        let accepted: Bool
        switch sample.stream {
        case .accelerometer: accepted = accelerometer.append(time: sample.timestamp, value: sample)
        case .gyroscope: accepted = gyroscope.append(time: sample.timestamp, value: sample)
        case .attitude: accepted = attitude.append(time: sample.timestamp, value: sample)
        }
        // Never suppress a raw callback: live episode writers can preserve even
        // an out-of-order sample while recording the pre-roll gap separately.
        onSample?(sample)
        if !accepted { onFailure?("out-of-order \(sample.stream.rawValue) sample") }
    }

    func snapshot(from start: TimeInterval, through end: TimeInterval, completion: @escaping ([MotionSample]) -> Void) {
        queue.addOperation { [weak self] in
            guard let self else { completion([]); return }
            let all = self.accelerometer.snapshot(from: start, through: end).map(\.value) +
                self.gyroscope.snapshot(from: start, through: end).map(\.value) +
                self.attitude.snapshot(from: start, through: end).map(\.value)
            completion(all.sorted { $0.timestamp < $1.timestamp })
        }
    }
}

/// Frame metadata uses the camera-to-AR-world transform in column-major order.
struct CameraPoseSample: Codable, Sendable {
    let timestamp: TimeInterval
    let callbackUptime: TimeInterval
    let cameraToWorldColumns: [Float]
    let cameraOrientationQuaternion: [Float]
    let intrinsicsColumns: [Float]
    let imageWidth: Int
    let imageHeight: Int
    let tracking: String
    let trackingReason: String?
}

/// This collector owns a single ARKit camera session. Its frame callback must
/// encode/copy the pixel buffer promptly; retaining ARFrames can stall capture.
final class ARFrameCollector: NSObject, ARSessionDelegate {
    let session = ARSession()
    private let frameQueue = DispatchQueue(label: "org.toomuchtrash.arkit-frames")
    var onFrame: ((CVPixelBuffer, CameraPoseSample) -> Void)?
    var onInterruption: ((String) -> Void)?

    override init() {
        super.init()
        session.delegate = self
        session.delegateQueue = frameQueue
    }

    func start() -> Bool {
        guard ARWorldTrackingConfiguration.isSupported else { return false }
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravity
        configuration.providesAudioData = false
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        return true
    }

    func stop() { session.pause() }

    func onFrameQueue(_ action: @escaping @Sendable () -> Void) { frameQueue.async(execute: action) }

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let transform = frame.camera.transform
        let rotation = simd_quatf(transform)
        let matrix = frame.camera.intrinsics
        let tracking: String
        let reason: String?
        switch frame.camera.trackingState {
        case .normal: tracking = "normal"; reason = nil
        case .notAvailable: tracking = "unavailable"; reason = nil
        case .limited(let value):
            tracking = "limited"
            switch value {
            case .initializing: reason = "initializing"
            case .excessiveMotion: reason = "excessive_motion"
            case .insufficientFeatures: reason = "insufficient_features"
            case .relocalizing: reason = "relocalizing"
            @unknown default: reason = "unknown"
            }
        }
        let pose = CameraPoseSample(
            timestamp: frame.timestamp,
            callbackUptime: ProcessInfo.processInfo.systemUptime,
            cameraToWorldColumns: [transform.columns.0.x, transform.columns.0.y, transform.columns.0.z, transform.columns.0.w,
                                   transform.columns.1.x, transform.columns.1.y, transform.columns.1.z, transform.columns.1.w,
                                   transform.columns.2.x, transform.columns.2.y, transform.columns.2.z, transform.columns.2.w,
                                   transform.columns.3.x, transform.columns.3.y, transform.columns.3.z, transform.columns.3.w],
            cameraOrientationQuaternion: [rotation.imag.x, rotation.imag.y, rotation.imag.z, rotation.real],
            intrinsicsColumns: [matrix.columns.0.x, matrix.columns.0.y, matrix.columns.0.z,
                                matrix.columns.1.x, matrix.columns.1.y, matrix.columns.1.z,
                                matrix.columns.2.x, matrix.columns.2.y, matrix.columns.2.z],
            imageWidth: CVPixelBufferGetWidth(frame.capturedImage),
            imageHeight: CVPixelBufferGetHeight(frame.capturedImage), tracking: tracking, trackingReason: reason)
        onFrame?(frame.capturedImage, pose)
    }

    func sessionWasInterrupted(_ session: ARSession) { onInterruption?("arkit_interrupted") }
    func session(_ session: ARSession, didFailWithError error: Error) { onInterruption?("arkit_failed") }
}

/// Encodes ARKit frames into independently readable MP4 segments. All methods
/// must be called on the AR frame queue; callbacks may arrive on another queue.
final class ARVideoSegmentWriter {
    struct Segment {
        let url: URL
        let firstTimestamp: TimeInterval
        let lastTimestamp: TimeInterval
        let frameCount: Int
        let error: String?
        var frameTimestamps: [TimeInterval] = []
    }
    private struct OpenSegment {
        let writer: AVAssetWriter
        let input: AVAssetWriterInput
        let adaptor: AVAssetWriterInputPixelBufferAdaptor
        let url: URL
        let first: TimeInterval
        var last: TimeInterval
        var frames: Int
        var frameTimestamps: [TimeInterval] = []
    }
    private let directory: URL
    private let segmentDuration: TimeInterval
    private var current: OpenSegment?
    var onSegmentOpened: ((URL, TimeInterval) -> Void)?
    var onSegment: ((Segment) -> Void)?
    var onFrameDropped: ((TimeInterval, String) -> Void)?

    init(directory: URL, segmentDuration: TimeInterval = 1) throws {
        precondition(segmentDuration > 0 && segmentDuration.isFinite)
        self.directory = directory
        self.segmentDuration = segmentDuration
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    }

    func append(_ source: CVPixelBuffer, timestamp: TimeInterval) throws {
        guard timestamp.isFinite else { throw SegmentError.invalidTimestamp }
        if let open = current, timestamp < open.last { onFrameDropped?(timestamp, "out_of_order"); return }
        if let open = current, timestamp - open.first >= segmentDuration { finishCurrent() }
        if current == nil {
            let segment = try makeSegment(source, timestamp: timestamp)
            current = segment
            onSegmentOpened?(segment.url, timestamp)
        }
        guard var open = current else { throw SegmentError.writer }
        guard open.writer.status == .writing else { throw open.writer.error ?? SegmentError.writer }
        guard open.input.isReadyForMoreMediaData else { onFrameDropped?(timestamp, "encoder_backpressure"); return }
        guard let pool = open.adaptor.pixelBufferPool else { throw SegmentError.pixelBuffer }
        var copied: CVPixelBuffer?
        guard CVPixelBufferPoolCreatePixelBuffer(nil, pool, &copied) == kCVReturnSuccess, let copied else {
            onFrameDropped?(timestamp, "pixel_buffer_allocation"); return
        }
        try copyPixels(from: source, to: copied)
        CVBufferPropagateAttachments(source, copied)
        let pts = CMTime(seconds: timestamp, preferredTimescale: 1_000_000_000)
        guard open.adaptor.append(copied, withPresentationTime: pts) else {
            onFrameDropped?(timestamp, "encoder_rejected_frame")
            if open.writer.status == .failed { throw open.writer.error ?? SegmentError.writer }
            return
        }
        open.last = timestamp
        open.frames += 1
        open.frameTimestamps.append(timestamp)
        current = open
    }

    func finishCurrent() {
        guard let open = current else { return }
        current = nil
        open.input.markAsFinished()
        let callback = onSegment
        open.writer.finishWriting {
            let failure = open.writer.status == .completed ? nil : (open.writer.error?.localizedDescription ?? "segment_encoding_failed")
            callback?(Segment(url: open.url, firstTimestamp: open.first, lastTimestamp: open.last,
                              frameCount: open.frames, error: failure, frameTimestamps: open.frameTimestamps))
        }
    }

    func closeAfterFailure() {
        guard let open = current else { return }
        if open.writer.status == .writing { finishCurrent(); return }
        current = nil
        onSegment?(Segment(url: open.url, firstTimestamp: open.first, lastTimestamp: open.last,
                           frameCount: open.frames, error: open.writer.error?.localizedDescription ?? "segment_encoding_failed", frameTimestamps: open.frameTimestamps))
    }

    private func makeSegment(_ source: CVPixelBuffer, timestamp: TimeInterval) throws -> OpenSegment {
        let width = CVPixelBufferGetWidth(source), height = CVPixelBufferGetHeight(source)
        let url = directory.appendingPathComponent("segment-\(UUID().uuidString).mp4")
        let writer = try AVAssetWriter(outputURL: url, fileType: .mp4)
        let input = AVAssetWriterInput(mediaType: .video, outputSettings: [
            AVVideoCodecKey: AVVideoCodecType.h264, AVVideoWidthKey: width, AVVideoHeightKey: height
        ])
        input.expectsMediaDataInRealTime = true
        guard writer.canAdd(input) else { throw SegmentError.writer }
        writer.add(input)
        let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: input, sourcePixelBufferAttributes: [
            kCVPixelBufferPixelFormatTypeKey as String: CVPixelBufferGetPixelFormatType(source),
            kCVPixelBufferWidthKey as String: width, kCVPixelBufferHeightKey as String: height,
            kCVPixelBufferIOSurfacePropertiesKey as String: [:]
        ])
        guard writer.startWriting() else { throw writer.error ?? SegmentError.writer }
        writer.startSession(atSourceTime: CMTime(seconds: timestamp, preferredTimescale: 1_000_000_000))
        return OpenSegment(writer: writer, input: input, adaptor: adaptor, url: url, first: timestamp, last: timestamp, frames: 0)
    }

    private func copyPixels(from source: CVPixelBuffer, to destination: CVPixelBuffer) throws {
        guard CVPixelBufferGetPixelFormatType(source) == CVPixelBufferGetPixelFormatType(destination),
              CVPixelBufferGetWidth(source) == CVPixelBufferGetWidth(destination),
              CVPixelBufferGetHeight(source) == CVPixelBufferGetHeight(destination),
              CVPixelBufferGetPlaneCount(source) == CVPixelBufferGetPlaneCount(destination) else { throw SegmentError.pixelBuffer }
        CVPixelBufferLockBaseAddress(source, .readOnly)
        CVPixelBufferLockBaseAddress(destination, [])
        defer { CVPixelBufferUnlockBaseAddress(destination, []); CVPixelBufferUnlockBaseAddress(source, .readOnly) }
        let planes = CVPixelBufferGetPlaneCount(source)
        for plane in 0..<max(planes, 1) {
            let sourceBase = planes == 0 ? CVPixelBufferGetBaseAddress(source) : CVPixelBufferGetBaseAddressOfPlane(source, plane)
            let destinationBase = planes == 0 ? CVPixelBufferGetBaseAddress(destination) : CVPixelBufferGetBaseAddressOfPlane(destination, plane)
            let sourceStride = planes == 0 ? CVPixelBufferGetBytesPerRow(source) : CVPixelBufferGetBytesPerRowOfPlane(source, plane)
            let destinationStride = planes == 0 ? CVPixelBufferGetBytesPerRow(destination) : CVPixelBufferGetBytesPerRowOfPlane(destination, plane)
            let rows = planes == 0 ? CVPixelBufferGetHeight(source) : CVPixelBufferGetHeightOfPlane(source, plane)
            guard let sourceBase, let destinationBase else { throw SegmentError.pixelBuffer }
            for row in 0..<rows {
                destinationBase.advanced(by: row * destinationStride).copyMemory(from: sourceBase.advanced(by: row * sourceStride), byteCount: min(sourceStride, destinationStride))
            }
        }
    }

    private enum SegmentError: Error { case invalidTimestamp, pixelBuffer, writer }
}

/// Incrementally persists raw samples for one episode. All calls are made by
/// the capture coordinator on its serial queue. A failed or unfinished journal
/// is deliberately retained for recovery; it is never presented as complete.
final class EpisodeJournal: @unchecked Sendable {
    static let maximumEpisodeBytes: Int64 = 80_000_000
    private static let manifestReserveBytes: Int64 = 1_048_576
    struct Gap: Codable {
        let stream: String
        let timestamp: TimeInterval
        let reason: String
    }
    private struct TimedRecord<Value: Codable>: Codable {
        let commonTime: TimeInterval
        let sample: Value
    }
    private struct Coverage: Codable {
        var first: TimeInterval?
        var last: TimeInterval?
        var count = 0
        mutating func add(_ time: TimeInterval) {
            first = min(first ?? time, time)
            last = max(last ?? time, time)
            count += 1
        }
    }
    private struct Manifest: Codable {
        struct Timing: Codable { let start: TimeInterval; let press: TimeInterval; let release: TimeInterval?; let end: TimeInterval }
        struct Metadata: Codable {
            let commonClock: String
            let nativeClockAlignment: String
            let buttonTiming: String
            let triggerSource: String
            let accelerationUnits: String
            let angularVelocityUnits: String
            let attitudeQuaternionOrder: String
            let cameraTransform: String
            let cameraIntrinsics: String
            let streams: [String: Coverage]
            let gaps: [Gap]
            let videoSegmentJoins: [EpisodeVideoAssembler.JoinTiming]
        }
        let schemaVersion: Int
        let episodeID: String
        let complete: Bool
        let timing: Timing
        let files: [String: String]
        let sensorMetadata: Metadata
        enum CodingKeys: String, CodingKey {
            case schemaVersion = "schema_version", episodeID = "episode_id", complete, timing, files, sensorMetadata = "sensor_metadata"
        }
    }

    let directory: URL
    let window: EpisodeWindowScheduler.Window
    private var imu: FileHandle?
    private var poses: FileHandle?
    private var coverage: [String: Coverage] = [:]
    private(set) var sensorBytesWritten: Int64 = 0
    private var gaps: [Gap] = []
    private var videoSegmentJoins: [EpisodeVideoAssembler.JoinTiming] = []

    func noteVideoSegmentJoins(_ joins: [EpisodeVideoAssembler.JoinTiming]) {
        videoSegmentJoins.append(contentsOf: joins)
    }
    private var lastSyncTime: TimeInterval?
    private let encoder = JSONEncoder()

    init(ownerDirectory: URL, window: EpisodeWindowScheduler.Window) throws {
        self.window = window
        directory = ownerDirectory.appendingPathComponent("episode-\(window.id.uuidString.lowercased())", isDirectory: true)
        guard !FileManager.default.fileExists(atPath: directory.path) else { throw ClientError.storage }
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: false)
        try CaptureQueue.protect(directory)
        let imuURL = directory.appendingPathComponent("imu.jsonl")
        let poseURL = directory.appendingPathComponent("poses.jsonl")
        guard FileManager.default.createFile(atPath: imuURL.path, contents: nil),
              FileManager.default.createFile(atPath: poseURL.path, contents: nil) else { throw ClientError.storage }
        try CaptureQueue.protect(imuURL)
        try CaptureQueue.protect(poseURL)
        imu = try FileHandle(forWritingTo: imuURL)
        poses = try FileHandle(forWritingTo: poseURL)
        let recoveryURL = directory.appendingPathComponent("recovery.json")
        let recovery: [String: Any] = ["schema_version": 1, "episode_id": window.id.uuidString,
                                       "complete": false, "start": window.start,
                                       "press": window.pressedAt, "reason": "recording_not_finalized"]
        try JSONSerialization.data(withJSONObject: recovery, options: [.sortedKeys]).write(to: recoveryURL, options: .atomic)
        try CaptureQueue.protect(recoveryURL)
    }

    deinit { try? imu?.close(); try? poses?.close() }

    func append(_ sample: MotionSample, commonTime: TimeInterval, through end: TimeInterval?) throws {
        guard includes(commonTime, end: end), let imu else { return }
        try line(TimedRecord(commonTime: commonTime, sample: sample), to: imu)
        coverage[sample.stream.rawValue, default: Coverage()].add(commonTime)
        try synchronizePeriodically(at: commonTime)
    }

    func append(_ sample: CameraPoseSample, commonTime: TimeInterval, through end: TimeInterval?) throws {
        guard includes(commonTime, end: end), let poses else { return }
        try line(TimedRecord(commonTime: commonTime, sample: sample), to: poses)
        coverage["camera_pose", default: Coverage()].add(commonTime)
        try synchronizePeriodically(at: commonTime)
    }

    func noteGap(stream: String, time: TimeInterval, reason: String) {
        guard time.isFinite else { return }
        gaps.append(Gap(stream: stream, timestamp: time, reason: reason))
    }

    /// A byte limit can be discovered after an encoded segment is finalized.
    /// Keep the original sensor journals privately and publish only the common
    /// truncated interval. No timestamp is rewritten or synthesized.
    func trimSensors(through end: TimeInterval) throws {
        try imu?.synchronize(); try poses?.synchronize()
        try imu?.close(); try poses?.close(); imu = nil; poses = nil
        let overflow = directory.appendingPathComponent("overflow", isDirectory: true)
        try FileManager.default.createDirectory(at: overflow, withIntermediateDirectories: true)
        try CaptureQueue.protect(overflow)
        coverage = [:]
        sensorBytesWritten = 0
        for name in ["imu.jsonl", "poses.jsonl"] {
            let source = directory.appendingPathComponent(name)
            let original = overflow.appendingPathComponent(name)
            try FileManager.default.moveItem(at: source, to: original)
            var retained = Data()
            for line in try Data(contentsOf: original).split(separator: 10) {
                guard let record = try JSONSerialization.jsonObject(with: Data(line)) as? [String: Any],
                      let time = record["commonTime"] as? Double,
                      let sample = record["sample"] as? [String: Any] else { throw ClientError.storage }
                guard time <= end else { continue }
                retained.append(contentsOf: line); retained.append(10)
                let stream = name == "poses.jsonl" ? "camera_pose" : (sample["stream"] as? String ?? "unknown")
                coverage[stream, default: Coverage()].add(time)
            }
            try retained.write(to: source, options: .atomic)
            try CaptureQueue.protect(source)
            sensorBytesWritten += Int64(retained.count)
        }
        imu = try FileHandle(forWritingTo: directory.appendingPathComponent("imu.jsonl"))
        poses = try FileHandle(forWritingTo: directory.appendingPathComponent("poses.jsonl"))
        try imu?.seekToEnd(); try poses?.seekToEnd()
        gaps.removeAll { $0.timestamp > end }
    }

    func markExportFailure(end: TimeInterval, reason: String) throws {
        try imu?.synchronize(); try poses?.synchronize()
        try imu?.close(); try poses?.close()
        imu = nil; poses = nil
        let metadata: [String: Any] = ["schema_version": 1, "episode_id": window.id.uuidString,
                                       "complete": false, "start": window.start,
                                       "press": window.pressedAt, "end": end, "reason": reason]
        let url = directory.appendingPathComponent("recovery.json")
        try JSONSerialization.data(withJSONObject: metadata, options: [.sortedKeys]).write(to: url, options: .atomic)
        try CaptureQueue.protect(url)
    }

    /// Reserve space for sensor sidecars and the largest accepted manifest.
    /// A second exact check runs before publishing the episode.
    func videoByteBudget() throws -> Int64 {
        try imu?.synchronize(); try poses?.synchronize()
        let sidecarBytes = try ["imu.jsonl", "poses.jsonl"].reduce(Int64(0)) { total, name in
            let attributes = try FileManager.default.attributesOfItem(atPath: directory.appendingPathComponent(name).path)
            guard let size = attributes[.size] as? NSNumber else { throw ClientError.storage }
            return total + size.int64Value
        }
        return Self.maximumEpisodeBytes - Self.manifestReserveBytes - sidecarBytes
    }

    /// Finalization requires explicit coverage/clock validation from the
    /// coordinator; a produced file alone does not establish synchronized data.
    func finalize(video: URL, release: TimeInterval?, end: TimeInterval,
                  validatedCoverageAndClock: Bool) throws {
        guard end.isFinite, end >= window.pressedAt,
              release.map({ $0.isFinite && $0 >= window.pressedAt && $0 <= end }) ?? true else { throw ClientError.storage }
        guard let imu, let poses else { throw ClientError.storage }
        if coverage["accelerometer"] == nil || coverage["gyroscope"] == nil || coverage["attitude"] == nil {
            noteGap(stream: "imu", time: end, reason: "one_or_more_streams_missing")
        }
        if coverage["camera_pose"] == nil { noteGap(stream: "camera_pose", time: end, reason: "stream_missing") }
        if coverage["accelerometer"] == nil && coverage["gyroscope"] == nil && coverage["attitude"] == nil {
            try line(["type": "missing", "stream": "imu"], to: imu)
        }
        if coverage["camera_pose"] == nil { try line(["type": "missing", "stream": "camera_pose"], to: poses) }
        try imu.synchronize(); try poses.synchronize()
        try imu.close(); try poses.close()
        self.imu = nil; self.poses = nil
        let target = directory.appendingPathComponent("video.mp4")
        guard !FileManager.default.fileExists(atPath: target.path) else { throw ClientError.storage }
        try FileManager.default.moveItem(at: video, to: target)
        try CaptureQueue.protect(target)
        let hasPadding = release.map { window.pressedAt - window.start >= 3 && end - $0 >= 3 } ?? false
        let manifest = Manifest(schemaVersion: 1, episodeID: window.id.uuidString, complete: validatedCoverageAndClock && gaps.isEmpty && hasPadding,
            timing: .init(start: window.start, press: window.pressedAt, release: release, end: end),
            files: ["video": "video.mp4", "imu": "imu.jsonl", "poses": "poses.jsonl"],
            sensorMetadata: .init(commonClock: "system_uptime_seconds", nativeClockAlignment: validatedCoverageAndClock ? "validated" : "unverified",
                buttonTiming: window.source == "screen" ? "screen_gesture_callback_uptime" : "capture_event_callback_uptime_not_physical_edge",
                triggerSource: window.source,
                accelerationUnits: "g", angularVelocityUnits: "rad/s", attitudeQuaternionOrder: "x,y,z,w",
                cameraTransform: "camera_to_ar_world_column_major", cameraIntrinsics: "column_major_pixels",
                streams: coverage, gaps: gaps, videoSegmentJoins: videoSegmentJoins))
        let manifestURL = directory.appendingPathComponent("manifest.json")
        try encoder.encode(manifest).write(to: manifestURL, options: .atomic)
        try CaptureQueue.protect(manifestURL)
        let bundleSize = try ["video.mp4", "imu.jsonl", "poses.jsonl", "manifest.json"].reduce(Int64(0)) { total, name in
            let attributes = try FileManager.default.attributesOfItem(atPath: directory.appendingPathComponent(name).path)
            guard let size = attributes[.size] as? NSNumber else { throw ClientError.storage }
            return total + size.int64Value
        }
        guard bundleSize <= Self.maximumEpisodeBytes else { throw EpisodeVideoAssembler.ExportLimitError.oversizedOrTruncated }
        try? FileManager.default.removeItem(at: directory.appendingPathComponent("recovery.json"))
    }

    private func includes(_ time: TimeInterval, end: TimeInterval?) -> Bool {
        time.isFinite && time >= window.start && (end.map { time <= $0 } ?? true)
    }

    private func synchronizePeriodically(at time: TimeInterval) throws {
        guard lastSyncTime.map({ time - $0 >= 1 }) ?? true else { return }
        try imu?.synchronize()
        try poses?.synchronize()
        lastSyncTime = time
    }

    private func line<T: Encodable>(_ value: T, to handle: FileHandle) throws {
        let data = try encoder.encode(value)
        try handle.write(contentsOf: data)
        try handle.write(contentsOf: Data([10]))
        sensorBytesWritten += Int64(data.count + 1)
    }
}

/// Composes overlapping encoded segments on the requested common timeline.
/// Gaps are returned explicitly rather than collapsing time between segments.
enum EpisodeVideoAssembler {
    enum ExportLimitError: Error { case oversizedOrTruncated }
    struct Gap: Equatable { let start: TimeInterval; let end: TimeInterval }
    struct JoinTiming: Codable {
        let containerGapStart: TimeInterval
        let containerGapEnd: TimeInterval
        let previousSourceFrame: TimeInterval?
        let nextSourceFrame: TimeInterval?
        let estimatedFrameInterval: TimeInterval?
        let classification: String
    }
    struct Result { let url: URL; let gaps: [Gap]; let joins: [JoinTiming] }

    /// Distinguish a sub-frame container join from a missing expected source
    /// frame. Retain the exact discrepancy as a diagnostic in either case.
    /// This checks accepted encoder input cadence, not physical clock alignment.
    static func classifyJoin(previous: ARVideoSegmentWriter.Segment, next: ARVideoSegmentWriter.Segment,
                             gapStart: TimeInterval, gapEnd: TimeInterval) -> JoinTiming {
        let before = Array(previous.frameTimestamps.suffix(4))
        let after = Array(next.frameTimestamps.prefix(4))
        let intervals = (Array(zip(before.dropFirst(), before)) + Array(zip(after.dropFirst(), after)))
            .map { $0.0 - $0.1 }.filter { $0.isFinite && $0 > 0 }.sorted()
        let cadence = intervals.isEmpty ? nil : intervals[intervals.count / 2]
        let last = before.last, first = after.first
        let continuous: Bool
        if let cadence, let last, let first {
            let step = first - last
            continuous = step >= cadence * 0.5 && step < cadence * 1.5 &&
                gapEnd - gapStart < cadence * 0.5
        } else { continuous = false }
        return JoinTiming(containerGapStart: gapStart, containerGapEnd: gapEnd,
            previousSourceFrame: last, nextSourceFrame: first, estimatedFrameInterval: cadence,
            classification: continuous ? "subframe_container_join" : "unverified_video_gap")
    }
    private final class ExportBox: @unchecked Sendable {
        let session: AVAssetExportSession
        init(_ session: AVAssetExportSession) { self.session = session }
    }

    static func assemble(segments: [ARVideoSegmentWriter.Segment], start: TimeInterval,
                         end: TimeInterval, output: URL,
                         maximumVideoBytes: Int64 = EpisodeJournal.maximumEpisodeBytes) async throws -> Result {
        guard start.isFinite, end.isFinite, end > start,
              !FileManager.default.fileExists(atPath: output.path) else { throw ClientError.storage }
        guard maximumVideoBytes > 0 else { throw ExportLimitError.oversizedOrTruncated }
        let composition = AVMutableComposition()
        guard let destination = composition.addMutableTrack(withMediaType: .video,
                                                               preferredTrackID: kCMPersistentTrackID_Invalid) else { throw ClientError.storage }
        let scale: CMTimeScale = 1_000_000_000
        var cursor = start
        var gaps: [Gap] = []
        var joins: [JoinTiming] = []
        var previousSegment: ARVideoSegmentWriter.Segment?
        for segment in segments.sorted(by: { $0.firstTimestamp < $1.firstTimestamp }) {
            guard segment.error == nil, segment.frameCount > 0 else { continue }
            let asset = AVURLAsset(url: segment.url)
            guard let track = try await asset.loadTracks(withMediaType: .video).first else { continue }
            let trackRange = try await track.load(.timeRange)
            let duration = CMTimeGetSeconds(trackRange.duration)
            guard duration.isFinite, duration > 0 else { continue }
            let actualStart = segment.firstTimestamp + CMTimeGetSeconds(trackRange.start)
            let segmentEnd = actualStart + duration
            let from = max(start, cursor, actualStart)
            let to = min(end, segmentEnd)
            guard to > from else { continue }
            if from > cursor {
                if let previousSegment, cursor > start {
                    let join = classifyJoin(previous: previousSegment, next: segment, gapStart: cursor, gapEnd: from)
                    joins.append(join)
                    if join.classification != "subframe_container_join" { gaps.append(Gap(start: cursor, end: from)) }
                } else { gaps.append(Gap(start: cursor, end: from)) }
            }
            let sourceStart = CMTimeAdd(trackRange.start, CMTime(seconds: from - actualStart, preferredTimescale: scale))
            let range = CMTimeRange(start: sourceStart, duration: CMTime(seconds: to - from, preferredTimescale: scale))
            try destination.insertTimeRange(range, of: track, at: CMTime(seconds: from - start, preferredTimescale: scale))
            cursor = to
            previousSegment = segment
        }
        if cursor < end { gaps.append(Gap(start: cursor, end: end)) }
        guard cursor > start, let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetPassthrough) else {
            throw ClientError.storage
        }
        exporter.outputURL = output
        exporter.outputFileType = .mp4
        // AVFoundation may fail or truncate when enforcing this limit. We
        // verify both the final size and duration before publishing an episode.
        exporter.fileLengthLimit = maximumVideoBytes
        let box = ExportBox(exporter)
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            exporter.exportAsynchronously {
                if box.session.status == .completed { continuation.resume() }
                else { continuation.resume(throwing: box.session.error ?? ClientError.storage) }
            }
        }
        let size = (try FileManager.default.attributesOfItem(atPath: output.path)[.size] as? NSNumber)?.int64Value ?? 0
        let exportedDuration = CMTimeGetSeconds(try await AVURLAsset(url: output).load(.duration))
        let intendedDuration = CMTimeGetSeconds(composition.duration)
        guard size > 0, size <= maximumVideoBytes, exportedDuration.isFinite,
              intendedDuration.isFinite, exportedDuration + 0.1 >= intendedDuration else {
            throw ExportLimitError.oversizedOrTruncated
        }
        return Result(url: output, gaps: gaps, joins: joins)
    }
}

/// Coordinates a single ARKit camera and independently sampled motion streams.
/// The UI integration stays separate until device and recovery validation passes.
final class EpisodeCaptureEngine: @unchecked Sendable {
    struct Status: Sendable {
        let ready: Bool
        let message: String
        let pendingEpisodes: Int
        let latestMotion: [String: MotionSample]
        let latestPose: CameraPoseSample?
    }
    let camera = ARFrameCollector()
    private let motion = MotionSampleCollector()
    private let state = DispatchQueue(label: "org.toomuchtrash.episode-state")
    private let ownerDirectory: URL
    private let scratchDirectory: URL
    private let writer: ARVideoSegmentWriter
    private var scheduler = EpisodeWindowScheduler()
    private var journals: [UUID: EpisodeJournal] = [:]
    private var pendingExports: [UUID: EpisodeWindowScheduler.Window] = [:]
    private var openSegments: [URL: TimeInterval] = [:]
    private var segments: [ARVideoSegmentWriter.Segment] = []
    private var accelerometer = TimedPreRoll<MotionSample>(duration: 5)
    private var gyroscope = TimedPreRoll<MotionSample>(duration: 5)
    private var attitude = TimedPreRoll<MotionSample>(duration: 5)
    private var poses = TimedPreRoll<CameraPoseSample>(duration: 5)
    private var recentGaps: [EpisodeJournal.Gap] = []
    private var latestMotion: [String: MotionSample] = [:]
    private var latestPose: CameraPoseSample?
    private var lastGoodVideoTime: TimeInterval?
    private var firstFrameUptime: TimeInterval?
    private var lastStatusUptime: TimeInterval = 0
    private var active = false
    private var ready = false
    private var outstandingExports = 0
    private var preserveRollingFiles = false
    private var retainedFailureMessage: String?
    private var protectedSizeOverflowSegments: Set<URL> = []
    private var sizeOverflowIntervals: [(start: TimeInterval, end: TimeInterval)] = []
    private var lastByteCheckUptime: TimeInterval = 0
    private let lifecycleLock = NSLock()
    private var running = false
    var onStatus: ((Status) -> Void)?
    var onEpisode: ((URL, UUID) -> Void)?
    var onDurationLimit: ((String, TimeInterval) -> Void)?
    var onSizeLimit: ((String, TimeInterval) -> Void)?
    var onPostRollTruncated: (() -> Void)?

    init(ownerDirectory: URL) throws {
        self.ownerDirectory = ownerDirectory
        scratchDirectory = ownerDirectory.appendingPathComponent("rolling-\(UUID().uuidString.lowercased())", isDirectory: true)
        writer = try ARVideoSegmentWriter(directory: scratchDirectory)
        try CaptureQueue.protect(scratchDirectory)
        camera.onFrame = { [weak self] pixels, pose in
            guard let self else { return }
            self.lifecycleLock.lock()
            let running = self.running
            self.lifecycleLock.unlock()
            guard running else { return }
            do { try self.writer.append(pixels, timestamp: pose.timestamp) }
            catch {
                self.writer.closeAfterFailure()
                self.state.async {
                    self.preserveRollingFiles = true
                    self.recordGap(stream: "video", time: pose.callbackUptime, reason: "encoding_failed")
                    self.publish("Video encoding failed. Partial data is retained.")
                }
            }
            self.state.async { self.accept(pose) }
        }
        writer.onSegmentOpened = { [weak self] url, time in self?.state.async { [weak self] in self?.openSegments[url] = time } }
        writer.onFrameDropped = { [weak self] time, reason in self?.state.async { [weak self] in self?.recordGap(stream: "video", time: time, reason: reason) } }
        writer.onSegment = { [weak self] segment in self?.state.async { [weak self] in
            guard let self else { return }
            self.openSegments.removeValue(forKey: segment.url)
            self.segments.append(segment)
            if self.sizeOverflowIntervals.contains(where: { segment.lastTimestamp >= $0.start && segment.firstTimestamp <= $0.end }) {
                self.protectedSizeOverflowSegments.insert(segment.url)
            }
            do { try self.persistSegmentMetadata(segment) }
            catch { self.preserveRollingFiles = true; self.publish("Could not save video timing metadata. Partial data is retained.") }
            if segment.error != nil || segment.frameCount == 0 {
                self.lastGoodVideoTime = nil
                self.recordGap(stream: "video", time: segment.lastTimestamp, reason: "segment_encoding_failed")
            } else { self.lastGoodVideoTime = segment.lastTimestamp }
            self.enforceLiveByteLimits(force: true)
            self.finishReady()
            self.prune()
        } }
        motion.onSample = { [weak self] sample in self?.state.async { [weak self] in self?.accept(sample) } }
        motion.onFailure = { [weak self] reason in self?.state.async { [weak self] in
            self?.recordGap(stream: "imu", time: ProcessInfo.processInfo.systemUptime, reason: reason)
        } }
        camera.onInterruption = { [weak self] reason in self?.stop(reason: reason) }
    }

    func start() -> Bool {
        guard ARWorldTrackingConfiguration.isSupported else { return false }
        lifecycleLock.lock()
        if running { lifecycleLock.unlock(); return true }
        running = true
        lifecycleLock.unlock()
        state.async {
            self.active = true
            self.ready = false
            self.firstFrameUptime = nil
            self.accelerometer = TimedPreRoll(duration: 5)
            self.gyroscope = TimedPreRoll(duration: 5)
            self.attitude = TimedPreRoll(duration: 5)
            self.poses = TimedPreRoll(duration: 5)
            self.recentGaps = []
            self.latestMotion = [:]
            self.latestPose = nil
            self.lastGoodVideoTime = nil
            self.publish("Buffering at least three seconds…")
        }
        motion.start()
        return camera.start()
    }

    func press(_ source: String, at timestamp: TimeInterval) {
        state.async {
            guard self.active, self.ready, let window = self.scheduler.press(source, at: timestamp) else { return }
            do {
                let journal = try EpisodeJournal(ownerDirectory: self.ownerDirectory, window: window)
                self.journals[window.id] = journal
                let samples = self.accelerometer.snapshot(from: window.start, through: timestamp).map(\.value) +
                    self.gyroscope.snapshot(from: window.start, through: timestamp).map(\.value) +
                    self.attitude.snapshot(from: window.start, through: timestamp).map(\.value)
                for sample in samples { try journal.append(sample, commonTime: sample.timestamp, through: nil) }
                for sample in self.poses.snapshot(from: window.start, through: timestamp).map(\.value) {
                    try journal.append(sample, commonTime: sample.timestamp, through: nil)
                }
                for gap in self.recentGaps where gap.timestamp >= window.start && gap.timestamp <= timestamp {
                    journal.noteGap(stream: gap.stream, time: gap.timestamp, reason: gap.reason)
                }
                self.publish("Recording episode")
                let deadline = window.start + EpisodeWindowScheduler.maximumDuration
                let delay = max(0, deadline - ProcessInfo.processInfo.systemUptime)
                self.state.asyncAfter(deadline: .now() + delay) {
                    guard let limited = self.scheduler.limit(window.id, at: deadline) else { return }
                    self.onDurationLimit?(limited.source, limited.pressedAt)
                    self.publish("30-second limit reached. Release the trigger.")
                    self.flushSegments(after: 0.2)
                }
            } catch {
                self.scheduler.cancel(source, at: timestamp, reason: "journal_failed")
                if self.journals[window.id] == nil { _ = self.scheduler.take(window.id) }
                self.preserveRollingFiles = true
                self.publish("Could not start the episode. Partial data is retained.")
                self.flushSegments(after: 0)
            }
        }
    }

    func release(_ source: String, at timestamp: TimeInterval) {
        state.async {
            let activeWindow = self.scheduler.pending.first { $0.source == source && $0.end == nil }
            self.scheduler.release(source, at: timestamp)
            self.publish("Recording post-roll…")
            if let id = activeWindow?.id, let window = self.scheduler.pending.first(where: { $0.id == id }), let end = window.end {
                if window.incompleteReason == "episode_duration_limit" { self.onPostRollTruncated?() }
                self.flushSegments(after: max(0, end - ProcessInfo.processInfo.systemUptime + 0.2))
            }
        }
    }

    func cancel(_ source: String, at timestamp: TimeInterval, reason: String) {
        state.async {
            self.scheduler.cancel(source, at: timestamp, reason: reason)
            self.recordGap(stream: "capture", time: timestamp, reason: reason)
            self.flushSegments(after: 0)
        }
    }

    func stop(reason: String) {
        lifecycleLock.lock()
        guard running else { lifecycleLock.unlock(); return }
        running = false
        lifecycleLock.unlock()
        camera.stop()
        motion.stop()
        state.async {
            guard self.active else { return }
            self.active = false
            self.ready = false
            let now = ProcessInfo.processInfo.systemUptime
            for window in self.scheduler.interrupt(at: now, reason: reason) { self.pendingExports[window.id] = window }
            self.recordGap(stream: "capture", time: now, reason: reason)
            self.publish("Capture interrupted; preserving available data.")
            self.flushSegments(after: 0)
        }
    }

    private func accept(_ sample: MotionSample) {
        guard active else { return }
        if ProcessInfo.processInfo.systemUptime - sample.callbackUptime > 0.5 {
            recordGap(stream: sample.stream.rawValue, time: sample.timestamp, reason: "sample_processing_backlog")
        }
        if let previous = latestMotion[sample.stream.rawValue], sample.timestamp - previous.timestamp > 0.25 {
            recordGap(stream: sample.stream.rawValue, time: sample.timestamp, reason: "sample_gap_after_\(previous.timestamp)")
        }
        switch sample.stream {
        case .accelerometer: _ = accelerometer.append(time: sample.timestamp, value: sample)
        case .gyroscope: _ = gyroscope.append(time: sample.timestamp, value: sample)
        case .attitude: _ = attitude.append(time: sample.timestamp, value: sample)
        }
        latestMotion[sample.stream.rawValue] = sample
        for window in scheduler.pending + Array(pendingExports.values) {
            let end = min(window.end ?? .infinity, window.start + EpisodeWindowScheduler.maximumDuration)
            do { try journals[window.id]?.append(sample, commonTime: sample.timestamp, through: end) }
            catch {
                journals[window.id]?.noteGap(stream: sample.stream.rawValue, time: sample.timestamp, reason: "sample_write_failed")
                preserveRollingFiles = true
                publish("Sensor write failed. Partial data is retained.")
            }
        }
        refreshReadiness()
    }

    private func accept(_ pose: CameraPoseSample) {
        guard active else { return }
        if ProcessInfo.processInfo.systemUptime - pose.callbackUptime > 0.5 {
            recordGap(stream: "camera_pose", time: pose.timestamp, reason: "frame_processing_backlog")
        }
        if firstFrameUptime == nil { firstFrameUptime = pose.callbackUptime }
        if let previous = latestPose, pose.timestamp - previous.timestamp > 0.25 {
            recordGap(stream: "camera_pose", time: pose.timestamp, reason: "frame_gap_after_\(previous.timestamp)")
        }
        if !poses.append(time: pose.timestamp, value: pose) {
            recordGap(stream: "camera_pose", time: pose.callbackUptime, reason: "out_of_order_frame")
        }
        latestPose = pose
        for window in scheduler.pending + Array(pendingExports.values) {
            let end = min(window.end ?? .infinity, window.start + EpisodeWindowScheduler.maximumDuration)
            do { try journals[window.id]?.append(pose, commonTime: pose.timestamp, through: end) }
            catch {
                journals[window.id]?.noteGap(stream: "camera_pose", time: pose.timestamp, reason: "sample_write_failed")
                preserveRollingFiles = true
                publish("Pose write failed. Partial data is retained.")
            }
        }
        refreshReadiness()
    }

    private func refreshReadiness() {
        enforceLiveByteLimits()
        let now = ProcessInfo.processInfo.systemUptime
        let firstTimes = [accelerometer.samples.first?.time, gyroscope.samples.first?.time,
                          attitude.samples.first?.time, poses.samples.first?.time]
        let lastTimes = [accelerometer.samples.last?.time, gyroscope.samples.last?.time,
                         attitude.samples.last?.time, poses.samples.last?.time]
        ready = active && !preserveRollingFiles && firstFrameUptime.map { now - $0 >= 3.1 } == true &&
            firstTimes.allSatisfy { $0.map { $0 <= now - 3 } ?? false } &&
            lastTimes.allSatisfy { $0.map { $0 <= now && $0 >= now - 0.5 } ?? false } &&
            lastGoodVideoTime.map { $0 <= now && $0 >= now - 2.5 } == true
        if now - lastStatusUptime >= 0.25 {
            publish(preserveRollingFiles ? (retainedFailureMessage ?? "Recording needs attention; partial data retained.") : (ready ? (scheduler.pending.isEmpty ? "Ready" : "Recording") : "Buffering…"))
        }
    }

    private func enforceLiveByteLimits(force: Bool = false) {
        let now = ProcessInfo.processInfo.systemUptime
        guard force || now - lastByteCheckUptime >= 0.1 else { return }
        lastByteCheckUptime = now
        for window in scheduler.pending where window.incompleteReason != "episode_size_limit" {
            guard let journal = journals[window.id] else { continue }
            let relevant = segments.filter { $0.lastTimestamp >= window.start && $0.firstTimestamp <= (window.end ?? .infinity) }
                .sorted { $0.firstTimestamp < $1.firstTimestamp }
            do {
                let pieces = try relevant.map { segment -> EpisodeLiveByteBudget.Piece in
                    guard let bytes = try FileManager.default.attributesOfItem(atPath: segment.url.path)[.size] as? NSNumber else { throw ClientError.storage }
                    return .init(end: segment.lastTimestamp, bytes: bytes.int64Value)
                }
                guard let safeEnd = EpisodeLiveByteBudget.cutoff(pieces: pieces, sensorBytes: journal.sensorBytesWritten, start: window.start) else { continue }
                let end = max(window.pressedAt, safeEnd)
                guard let limited = scheduler.limitBytes(window.id, through: end) else { continue }
                sizeOverflowIntervals.append((start: end, end: ProcessInfo.processInfo.systemUptime))
                for segment in relevant where segment.lastTimestamp >= end { protectedSizeOverflowSegments.insert(segment.url) }
                onSizeLimit?(limited.source, limited.pressedAt)
                publish("80 MB byte budget reached; preserving a shorter episode.")
                flushSegments(after: 0)
            } catch {
                preserveRollingFiles = true
                publish("Could not measure recording size. Source data retained.")
            }
        }
    }

    private func flushSegments(after delay: TimeInterval) {
        state.asyncAfter(deadline: .now() + delay) {
            self.camera.onFrameQueue {
                self.writer.finishCurrent()
                self.state.async { self.finishReady() }
            }
            self.state.asyncAfter(deadline: .now() + 2) { self.finishReady() }
            self.state.asyncAfter(deadline: .now() + 6) { self.finishReady() }
        }
    }

    private func finishReady() {
        let now = ProcessInfo.processInfo.systemUptime
        for window in scheduler.pending where window.end.map({ $0 <= now }) == true {
            if let taken = scheduler.take(window.id) { pendingExports[window.id] = taken }
        }
        for window in Array(pendingExports.values) {
            guard let end = window.end else { continue }
            if openSegments.values.contains(where: { $0 <= end }) {
                if now >= end + 5 {
                    if let journal = journals.removeValue(forKey: window.id) {
                        try? journal.markExportFailure(end: end, reason: "video_segment_finish_timeout")
                    }
                    pendingExports.removeValue(forKey: window.id)
                    preserveRollingFiles = true
                    publish("Video segment did not finish. Partial data is retained.")
                }
                continue
            }
            let watermarks = [latestMotion["accelerometer"]?.timestamp, latestMotion["gyroscope"]?.timestamp,
                              latestMotion["attitude"]?.timestamp, latestPose?.timestamp]
            let streamsReachedEnd = watermarks.allSatisfy { $0.map { $0 >= end } ?? false }
            guard streamsReachedEnd || !active || now >= end + 2 else { continue }
            guard let journal = journals.removeValue(forKey: window.id) else {
                pendingExports.removeValue(forKey: window.id)
                preserveRollingFiles = true
                continue
            }
            if !streamsReachedEnd { journal.noteGap(stream: "capture", time: end, reason: "stream_ended_before_requested_window") }
            pendingExports.removeValue(forKey: window.id)
            let videoBudget: Int64
            do {
                if window.incompleteReason == "episode_size_limit" { try journal.trimSensors(through: end) }
                videoBudget = try journal.videoByteBudget()
                guard videoBudget > 0 else { throw EpisodeVideoAssembler.ExportLimitError.oversizedOrTruncated }
            } catch {
                try? journal.markExportFailure(end: end, reason: "episode_size_budget_unavailable")
                preserveRollingFiles = true
                ready = false
                let message = "Episode cannot fit within 80 MB. Partial data is retained."
                retainedFailureMessage = message
                publish(message)
                continue
            }
            outstandingExports += 1
            let chosen = segments.filter { $0.lastTimestamp + 0.2 >= window.start && $0.firstTimestamp <= end }
            let output = scratchDirectory.appendingPathComponent("export-\(window.id.uuidString).mp4")
            Task {
                do {
                    let result = try await EpisodeVideoAssembler.assemble(segments: chosen, start: window.start, end: end, output: output, maximumVideoBytes: videoBudget)
                    self.state.async {
                        do {
                            for gap in result.gaps { journal.noteGap(stream: "video", time: gap.start, reason: "gap_until_\(gap.end)") }
                            journal.noteVideoSegmentJoins(result.joins)
                            if let reason = window.incompleteReason { journal.noteGap(stream: "capture", time: end, reason: reason) }
                            // Clock and complete-stream coverage must be validated on real hardware.
                            try journal.finalize(video: result.url, release: window.releasedAt, end: end, validatedCoverageAndClock: false)
                            self.onEpisode?(journal.directory, window.id)
                            self.publish("Episode saved; synchronization validation pending.")
                        } catch {
                            try? journal.markExportFailure(end: end, reason: "episode_finalize_failed")
                            self.preserveRollingFiles = true
                            self.ready = false
                            let message = error is EpisodeVideoAssembler.ExportLimitError ? "Episode exceeds 80 MB. Partial data is retained." : "Episode export failed. Partial data is retained."
                            self.retainedFailureMessage = message
                            self.publish(message)
                        }
                        self.outstandingExports -= 1
                        self.prune()
                    }
                } catch {
                    self.state.async {
                        let reason = error is EpisodeVideoAssembler.ExportLimitError ? "video_size_limit_or_truncated_export" : "video_assembly_failed"
                        try? journal.markExportFailure(end: end, reason: reason)
                        self.outstandingExports -= 1
                        self.preserveRollingFiles = true
                        self.ready = false
                        let message = "Video export failed or exceeded 80 MB. Partial data is retained."
                        self.retainedFailureMessage = message
                        self.publish(message)
                    }
                }
            }
        }
    }

    private func recordGap(stream: String, time: TimeInterval, reason: String) {
        guard time.isFinite else { return }
        recentGaps.append(EpisodeJournal.Gap(stream: stream, timestamp: time, reason: reason))
        let cutoff = (recentGaps.map(\.timestamp).max() ?? time) - 5
        recentGaps.removeAll { $0.timestamp < cutoff }
        for window in scheduler.pending + Array(pendingExports.values) where time >= window.start && time <= (window.end ?? .infinity) {
            journals[window.id]?.noteGap(stream: stream, time: time, reason: reason)
        }
    }

    private func prune() {
        guard !preserveRollingFiles, scheduler.pending.isEmpty, pendingExports.isEmpty, outstandingExports == 0, let latestPose else { return }
        let cutoff = latestPose.timestamp - 5
        let old = segments.filter { !protectedSizeOverflowSegments.contains($0.url) && (!active || $0.lastTimestamp < cutoff) }
        for segment in old {
            do {
                try FileManager.default.removeItem(at: segment.url)
                let metadata = segment.url.deletingPathExtension().appendingPathExtension("json")
                if FileManager.default.fileExists(atPath: metadata.path) { try FileManager.default.removeItem(at: metadata) }
                segments.removeAll { $0.url == segment.url }
            }
            catch { publish("Could not reclaim rolling-buffer storage.") }
        }
    }

    private func persistSegmentMetadata(_ segment: ARVideoSegmentWriter.Segment) throws {
        let metadata: [String: Any] = ["file": segment.url.lastPathComponent,
            "first_timestamp": segment.firstTimestamp, "last_timestamp": segment.lastTimestamp,
            "frame_count": segment.frameCount, "frame_timestamps": segment.frameTimestamps,
            "error": (segment.error as Any?) ?? NSNull()]
        let url = segment.url.deletingPathExtension().appendingPathExtension("json")
        try JSONSerialization.data(withJSONObject: metadata, options: [.sortedKeys]).write(to: url, options: .atomic)
        try CaptureQueue.protect(url)
        try CaptureQueue.protect(segment.url)
    }

    private func publish(_ message: String) {
        lastStatusUptime = ProcessInfo.processInfo.systemUptime
        onStatus?(Status(ready: ready, message: message, pendingEpisodes: scheduler.pending.count + pendingExports.count + outstandingExports,
                         latestMotion: latestMotion, latestPose: latestPose))
    }

    #if DEBUG
    private final class DebugPixelBufferBox: @unchecked Sendable {
        let value: CVPixelBuffer
        init(_ value: CVPixelBuffer) { self.value = value }
    }
    func debugActivateForSyntheticFrames() {
        lifecycleLock.lock(); running = true; lifecycleLock.unlock()
        state.sync { active = true; ready = true }
    }
    func debugAccept(_ sample: MotionSample) { state.sync { accept(sample) } }
    func debugForceReady() { state.sync { ready = true } }
    func debugDrainState() { state.sync {} }
    func debugSummary() -> String {
        state.sync { "pending=\(scheduler.pending.count), awaiting=\(pendingExports.count), journals=\(journals.count), open=\(openSegments.count), segments=\(segments.count), exports=\(outstandingExports), retain=\(preserveRollingFiles)" }
    }
    func debugFrame(_ pixels: CVPixelBuffer, pose: CameraPoseSample, completion: @escaping () -> Void) {
        let buffer = DebugPixelBufferBox(pixels)
        camera.onFrameQueue {
            self.camera.onFrame?(buffer.value, pose)
            self.state.async { completion() }
        }
    }
    #endif
}

@MainActor
final class EpisodeCameraController: ObservableObject {
    @Published private(set) var session: ARSession?
    @Published private(set) var isReady = false
    @Published private(set) var permissionDenied = false
    @Published private(set) var status = "Opening camera…"
    @Published private(set) var recordingStartedAt: Date?
    @Published private(set) var pendingEpisodes = 0
    @Published private(set) var limitNotice: String?
    @Published private(set) var latestMotion: [String: MotionSample] = [:]
    @Published private(set) var latestPose: CameraPoseSample?
    var onEpisodeSaved: ((URL, UUID) -> Void)?
    private var engine: EpisodeCaptureEngine?
    private var heldSources: Set<String> = []
    private var heldStartTimes: [String: TimeInterval] = [:]

    func configure(directory: URL) throws {
        guard engine == nil else { return }
        let engine = try EpisodeCaptureEngine(ownerDirectory: directory)
        engine.onStatus = { [weak self] update in
            Task { @MainActor [weak self] in
                self?.isReady = update.ready
                self?.status = update.message
                self?.pendingEpisodes = update.pendingEpisodes
                self?.latestMotion = update.latestMotion
                self?.latestPose = update.latestPose
            }
        }
        engine.onEpisode = { [weak self] folder, id in
            Task { @MainActor [weak self] in self?.onEpisodeSaved?(folder, id) }
        }
        engine.onDurationLimit = { [weak self] source, pressedAt in
            Task { @MainActor [weak self] in
                guard let self, self.heldStartTimes[source] == pressedAt else { return }
                self.heldStartTimes.removeValue(forKey: source)
                self.heldSources.remove(source)
                if self.heldSources.isEmpty { self.recordingStartedAt = nil }
                self.limitNotice = "30-second limit reached. Release the trigger to record again."
            }
        }
        engine.onSizeLimit = { [weak self] source, pressedAt in
            Task { @MainActor [weak self] in
                guard let self, self.heldStartTimes[source] == pressedAt else { return }
                self.heldStartTimes.removeValue(forKey: source)
                self.heldSources.remove(source)
                if self.heldSources.isEmpty { self.recordingStartedAt = nil }
                self.limitNotice = "80 MB limit reached. A shorter episode is being saved. Release the trigger."
            }
        }
        engine.onPostRollTruncated = { [weak self] in
            Task { @MainActor [weak self] in
                guard let self, self.recordingStartedAt == nil else { return }
                self.limitNotice = "30-second limit reached. The post-roll was shortened."
            }
        }
        self.engine = engine
        session = engine.camera.session
    }

    func activate() async {
        #if targetEnvironment(simulator)
        status = "No camera available. Use an iPhone to record."
        isReady = false
        #else
        let granted: Bool
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: granted = true
        case .notDetermined: granted = await AVCaptureDevice.requestAccess(for: .video)
        default: granted = false
        }
        guard granted else { permissionDenied = true; status = "Allow camera access to record pickup attempts."; return }
        permissionDenied = false
        guard let engine, engine.start() else { status = "AR camera tracking is unavailable on this device."; return }
        #endif
    }

    func deactivate() {
        heldSources.removeAll()
        heldStartTimes.removeAll()
        recordingStartedAt = nil
        isReady = false
        engine?.stop(reason: "capture_screen_inactive")
    }

    func press(_ source: String) {
        guard isReady, !heldSources.contains(source) else { return }
        let time = ProcessInfo.processInfo.systemUptime
        heldSources.insert(source)
        heldStartTimes[source] = time
        limitNotice = nil
        if recordingStartedAt == nil { recordingStartedAt = Date() }
        engine?.press(source, at: time)
    }

    func release(_ source: String) {
        guard heldSources.remove(source) != nil else { return }
        heldStartTimes.removeValue(forKey: source)
        engine?.release(source, at: ProcessInfo.processInfo.systemUptime)
        if heldSources.isEmpty { recordingStartedAt = nil }
    }

    func cancel(_ source: String) {
        guard heldSources.remove(source) != nil else { return }
        heldStartTimes.removeValue(forKey: source)
        engine?.cancel(source, at: ProcessInfo.processInfo.systemUptime, reason: "capture_event_cancelled")
        if heldSources.isEmpty { recordingStartedAt = nil }
    }
}
