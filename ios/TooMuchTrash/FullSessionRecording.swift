import Foundation

/// Read-only dashboard metadata. Source bytes and acknowledged manifests stay immutable.
struct FullSessionRecording: Identifiable, Equatable {
    let id: UUID
    let directory: URL
    let createdAt: Date
    let start: Double
    let end: Double?
    let cleanupSessionID: UUID?
    let finalized: Bool
    let uploaded: Bool
    var duration: Double { max(0, (end ?? start) - start) }

    static func read(_ directory: URL) -> Self? {
        guard let id = UUID(uuidString: String(directory.lastPathComponent.dropFirst(11))),
              directory.lastPathComponent == "continuous-\(id.uuidString.lowercased())",
              let values = try? directory.resourceValues(forKeys: [.isDirectoryKey, .isSymbolicLinkKey]),
              values.isDirectory == true, values.isSymbolicLink != true,
              let data = try? Data(contentsOf: directory.appendingPathComponent("session.json")),
              let m = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              m["session_id"] as? String == directory.lastPathComponent,
              let start = m["start"] as? Double, start.isFinite,
              let created = m["created_at"] as? Double, created.isFinite else { return nil }
        let ack = (try? Data(contentsOf: directory.appendingPathComponent("uploaded.json")))
            .flatMap { try? JSONDecoder().decode(ContinuousReceipt.self, from: $0) }
        return Self(id: id, directory: directory, createdAt: Date(timeIntervalSince1970: created), start: start,
                    end: m["end"] as? Double,
                    cleanupSessionID: (m["cleanup_session_id"] as? String).flatMap(UUID.init(uuidString:)),
                    finalized: m["finalized"] as? Bool == true,
                    uploaded: ack?.recording_id == id && ack?.complete == true)
    }

    @MainActor func contains(_ capture: QueuedCapture, queue: CaptureQueue) -> Bool {
        if let linked = capture.fullSessionRecordingID { return linked == id }
        // Backward compatibility: do not rewrite historical checksummed manifests.
        guard let folder = queue.episodeFolder(for: capture),
              let data = try? Data(contentsOf: folder.appendingPathComponent("manifest.json")),
              let m = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return false }
        if let linked = (m["full_session_recording_id"] as? String).flatMap(UUID.init(uuidString:)) { return linked == id }
        guard let cleanupSessionID,
              (m["cleanup_session_id"] as? String).flatMap(UUID.init(uuidString:)) == cleanupSessionID,
              let timing = m["timing"] as? [String: Any], let press = timing["press"] as? Double,
              let end else { return false }
        return press >= start && press <= end
    }
}


struct FullRecordingGroup: Identifiable, Equatable {
    let id: String
    let name: String
    let startedAt: Date?
    let recordings: [FullSessionRecording]
    static func make(recordings: [FullSessionRecording], walks: [CleanupSessionRecord]) -> [Self] {
        Dictionary(grouping: recordings, by: { $0.cleanupSessionID?.uuidString ?? "unassigned" }).map { key, rows in
            let walk = walks.first { $0.id.uuidString == key }
            return Self(id: key, name: walk.map { $0.name.isEmpty ? "Cleanup walk" : $0.name } ?? (key == "unassigned" ? "Earlier recordings" : "Cleanup walk"),
                        startedAt: walk.map { Date(timeIntervalSince1970: $0.started_at) },
                        recordings: rows.sorted { $0.createdAt > $1.createdAt })
        }.sorted { ($0.recordings.first?.createdAt ?? .distantPast) > ($1.recordings.first?.createdAt ?? .distantPast) }
    }
}
