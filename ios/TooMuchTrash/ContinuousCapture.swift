import Foundation

/// Durable logical recording: MP4 parts and every raw stream share uptime seconds.
/// An unfinished manifest and append-only journals survive interruption.
final class ContinuousCapture {
    let directory: URL
    var id: UUID { UUID(uuidString: String(directory.lastPathComponent.dropFirst(11)))! }
    let start: Double
    private let created = Date()
    private let cleanupSessionID: UUID?
    private let modelEnabled: Bool
    private var handles: [String: FileHandle] = [:]
    private var parts: [[String: Any]] = []
    private var lastSync = 0.0
    private(set) var end: Double?
    private var waiting: Set<URL> = []
    private var finished = false
    var onFinished: ((URL) -> Void)?
    init(owner: URL, start: Double, cleanupSessionID: UUID? = nil, modelEnabled: Bool = true) throws {
        self.start = start
        self.cleanupSessionID = cleanupSessionID
        self.modelEnabled = modelEnabled
        directory = owner.appendingPathComponent("continuous-\(UUID().uuidString.lowercased())")
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        try CaptureQueue.protect(directory)
        for name in ["imu", "poses", "references", "predictions", "diagnostics"] {
            let url = directory.appendingPathComponent(name + ".jsonl")
            FileManager.default.createFile(atPath: url.path, contents: nil)
            handles[name] = try FileHandle(forWritingTo: url)
            try CaptureQueue.protect(url)
        }
        try manifest(complete: false)
    }
    func append<T: Encodable>(_ value: T, stream: String, time: Double) throws {
        guard time >= start, end.map({ time <= $0 }) ?? true else { return }
        let data = try JSONEncoder().encode(value)
        try handles[stream]?.write(contentsOf: data + Data([10]))
        if time - lastSync >= 1 { for handle in handles.values { try handle.synchronize() }; lastSync = time }
    }
    func event(_ value: [String: Any], stream: String) throws {
        if let timestamp = (value["frame_time"] ?? value["callback_uptime"]) as? Double {
            guard timestamp >= start, end.map({ timestamp <= $0 }) ?? true else { return }
        }
        try handles[stream]?.write(contentsOf: JSONSerialization.data(withJSONObject: value, options: [.sortedKeys]) + Data([10]))
        let now = ProcessInfo.processInfo.systemUptime
        if stream == "references" || now - lastSync >= 1 {
            for handle in handles.values { try handle.synchronize() }; lastSync = now
        }
    }
    func segment(_ part: ARVideoSegmentWriter.Segment) throws {
        guard part.lastTimestamp >= start, end.map({ part.firstTimestamp <= $0 }) ?? true else { waiting.remove(part.url); return }
        guard part.error == nil, part.frameCount > 0 else { throw ClientError.storage }
        let name = part.url.lastPathComponent
        let target = directory.appendingPathComponent(name)
        if !FileManager.default.fileExists(atPath: target.path) { try FileManager.default.copyItem(at: part.url, to: target); try CaptureQueue.protect(target) }
        var entry: [String: Any] = ["file": name, "first": part.firstTimestamp, "last": part.lastTimestamp,
                                   "frame_timestamps": part.frameTimestamps, "frames": part.frameCount]
        if let error = part.error { entry["error"] = error }
        if let geometry = part.geometry { entry["geometry"] = try JSONSerialization.jsonObject(with: JSONEncoder().encode(geometry)) }
        parts.append(entry)
        try manifest(complete: false)
        waiting.remove(part.url)
    }
    func stop(at time: Double, pending: Set<URL>, reason: String) throws {
        guard end == nil else { return }
        end = time; waiting = pending
        try event(["kind": "stop", "time": time, "reason": reason], stream: "diagnostics")
        try manifest(complete: false)
    }
    func finishIfReady() throws -> Bool {
        guard !finished, end != nil, waiting.isEmpty else { return false }
        for h in handles.values { try h.synchronize(); try h.close() }; handles.removeAll()
        // Finalized means transport-ready, not ground-truth or clock calibration.
        try manifest(complete: true)
        finished = true
        onFinished?(directory)
        return true
    }
    private func manifest(complete: Bool) throws {
        let value: [String: Any] = ["schema": "tmt-continuous-session-v1", "session_id": directory.lastPathComponent,
            "clock": "system_uptime_seconds", "created_at": created.timeIntervalSince1970, "start": start, "end": end as Any? ?? NSNull(),
            "finalized": complete, "native_clock_alignment": "unverified", "live_preprocessing": "nv12_luma_vimage_hq_v1", "audio": false,
            "video_parts": parts.sorted { ($0["first"] as? Double ?? 0) < ($1["first"] as? Double ?? 0) },
            "streams": ["imu": "imu.jsonl", "poses": "poses.jsonl", "references": "references.jsonl", "predictions": "predictions.jsonl", "diagnostics": "diagnostics.jsonl"],
            "cleanup_session_id": cleanupSessionID?.uuidString.lowercased() as Any? ?? NSNull(), "model_enabled": modelEnabled,
            "reference_timing": "button_callback_not_physical_edge", "model_id": "jaw-r59-independent-motion-alpha1"]
        try JSONSerialization.data(withJSONObject: value, options: [.sortedKeys]).write(to: directory.appendingPathComponent("session.json"), options: .atomic)
    }
    static func fileNames(_ directory: URL) throws -> [String] {
        let manifest = try JSONSerialization.jsonObject(with: Data(contentsOf: directory.appendingPathComponent("session.json"))) as? [String: Any]
        guard let manifest, manifest["finalized"] as? Bool == true,
              let parts = manifest["video_parts"] as? [[String: Any]], !parts.isEmpty,
              let streams = manifest["streams"] as? [String: String] else { throw ClientError.storage }
        let names = ["session.json"] + Array(streams.values) + (try parts.map { part -> String in
            guard let file = part["file"] as? String else { throw ClientError.storage }; return file
        })
        guard Set(names).count == names.count, names.allSatisfy({
            !$0.isEmpty && !$0.contains("/") && !$0.contains("..") && !$0.contains("\\") &&
            (try? directory.appendingPathComponent($0).resourceValues(forKeys: [.isRegularFileKey, .isSymbolicLinkKey])).map { $0.isRegularFile == true && $0.isSymbolicLink != true } == true
        }) else { throw ClientError.storage }
        return names.sorted()
    }

    /// Run once before opening the camera. Preserve partial sessions and flag recovery.
    static func recover(in owner: URL) throws {
        for folder in try FileManager.default.contentsOfDirectory(at: owner, includingPropertiesForKeys: [.isDirectoryKey]) where folder.lastPathComponent.hasPrefix("continuous-") {
            let file = folder.appendingPathComponent("session.json")
            guard var manifest = try? JSONSerialization.jsonObject(with: Data(contentsOf: file)) as? [String: Any],
                  manifest["finalized"] as? Bool != true,
                  let parts = manifest["video_parts"] as? [[String: Any]], !parts.isEmpty,
                  let end = parts.compactMap({ $0["last"] as? Double }).max() else { continue }
            // Only acknowledged, copied parts are claimed. Raw journals remain untouched;
            // samples outside the recovered video interval can be masked downstream.
            manifest["end"] = end
            manifest["recovered_after_interruption"] = true
            manifest["recovery_note"] = "Unclosed video tail may be missing; raw journals preserved."
            manifest["finalized"] = true
            try JSONSerialization.data(withJSONObject: manifest, options: [.sortedKeys]).write(to: file, options: .atomic)
        }
    }
    deinit { for h in handles.values { try? h.close() } }
}
