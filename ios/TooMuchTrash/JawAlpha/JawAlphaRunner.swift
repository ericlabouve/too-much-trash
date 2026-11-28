import Foundation
import CoreVideo

/// One bounded, serial stateful detector for an actual camera session.
final class JawAlphaRunner {
    private let worker = DispatchQueue(label: "org.toomuchtrash.jaw-alpha", qos: .userInitiated)
    private let lock = NSLock()
    private var pending = false
    private var lastTime = -Double.infinity
    private var bridge: JawAlphaBridge?
    private var nextDue = -Double.infinity
    private var generation = 0
    private var checkFrameCount = 0
    var onResult: (([String: Any]) -> Void)?
    func reset(reason: String) {
        lock.lock(); generation += 1; let token = generation; nextDue = -.infinity; lock.unlock()
        worker.async {
            self.bridge = try? JawAlphaBridge(directory: Bundle.main.resourceURL!)
            self.lastTime = -.infinity
            self.onResult?(["kind": "reset", "reason": reason, "generation": token, "emitted_uptime": ProcessInfo.processInfo.systemUptime, "model_id": "jaw-r59-independent-motion-alpha1", "available": self.bridge != nil])
        }
    }
    func stop() {
        lock.lock(); generation += 1; lock.unlock()
        worker.async {
            self.bridge = nil
            self.onResult?(["kind": "stop", "emitted_uptime": ProcessInfo.processInfo.systemUptime])
        }
    }
    func offer(_ buffer: CVPixelBuffer, pose: CameraPoseSample, samples: [MotionSample]) {
        lock.lock()
        guard pose.timestamp >= nextDue else { lock.unlock(); return }
        if !nextDue.isFinite { nextDue = pose.timestamp }
        repeat { nextDue += 1.0 / 15 } while nextDue <= pose.timestamp
        guard !pending else { lock.unlock(); onResult?(["kind": "dropped_inference_frame", "frame_time": pose.timestamp]); return }
        pending = true; let token = generation; lock.unlock()
        worker.async {
            defer { self.lock.lock(); self.pending = false; self.lock.unlock() }
            self.lock.lock(); let current = self.generation; self.lock.unlock()
            guard token == current, pose.timestamp > self.lastTime, let bridge = self.bridge else { return }
            self.lastTime = pose.timestamp
            let begin = ProcessInfo.processInfo.systemUptime
            guard let gray = JawGrayConverter.make(buffer) else {
                self.onResult?(["kind": "preprocessing_failure", "frame_time": pose.timestamp]); return
            }
            #if DEBUG
            self.checkFrameCount += 1
            if ProcessInfo.processInfo.arguments.contains("-jaw-alpha-live-check"), [40, 80, 120].contains(self.checkFrameCount) {
                let folder = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("AlphaLiveCheck")
                let name = String(format: "%.9f", pose.timestamp)
                try? Data(gray).write(to: folder.appendingPathComponent(name + ".gray"))
                if CVPixelBufferLockBaseAddress(buffer, .readOnly) == kCVReturnSuccess {
                    defer { CVPixelBufferUnlockBaseAddress(buffer, .readOnly) }
                    if let pointer = CVPixelBufferGetBaseAddressOfPlane(buffer, 0) {
                        let width = CVPixelBufferGetWidthOfPlane(buffer, 0), height = CVPixelBufferGetHeightOfPlane(buffer, 0), stride = CVPixelBufferGetBytesPerRowOfPlane(buffer, 0)
                        var packed = Data()
                        for y in 0..<height { packed.append(pointer.advanced(by: y * stride).assumingMemoryBound(to: UInt8.self), count: width) }
                        try? packed.write(to: folder.appendingPathComponent(name + ".y"))
                        try? JSONSerialization.data(withJSONObject: ["width": width, "height": height, "format": CVPixelBufferGetPixelFormatType(buffer)]).write(to: folder.appendingPathComponent(name + ".json"))
                    }
                }
            }
            #endif
            func stream(_ kind: MotionSample.Stream) -> ([NSNumber], [NSNumber]) {
                let values = samples.filter { $0.stream == kind && $0.timestamp <= pose.timestamp }.sorted { $0.timestamp < $1.timestamp }.suffix(33)
                return (values.map { NSNumber(value: $0.timestamp) }, values.flatMap { $0.values.map(NSNumber.init(value:)) })
            }
            let (gt, gv) = stream(.gyroscope), (at, av) = stream(.accelerometer)
            var score = 0.0
            let event = bridge.step(Data(gray), timestamp: pose.timestamp, gyroTimes: gt, gyroValues: gv, accelTimes: at, accelValues: av, score: &score)
            let now = ProcessInfo.processInfo.systemUptime
            self.onResult?(["kind": "inference", "model_id": "jaw-r59-independent-motion-alpha1", "event": event, "frame_time": pose.timestamp, "emitted_uptime": now, "processing_ms": (now-begin)*1000, "gyro_age": pose.timestamp-(gt.last?.doubleValue ?? pose.timestamp), "accel_age": pose.timestamp-(at.last?.doubleValue ?? pose.timestamp), "gyro_count": gt.count, "accel_count": at.count, "thermal_state": ProcessInfo.processInfo.thermalState.rawValue, "live_preprocessing": "nv12_luma_vimage_hq_v1"])
        }
    }
}
