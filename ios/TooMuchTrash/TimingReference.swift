import Foundation
import Darwin

/// A collection protocol, not an estimated correction. Raw clocks stay intact.
enum TimingReference {
    static let holdDuration: TimeInterval = 14
    static let expectedDuration: TimeInterval = 20
    static var hardwareModel: String {
        var size = 0
        guard sysctlbyname("hw.machine", nil, &size, nil, 0) == 0, size > 1 else { return "unknown" }
        var bytes = [CChar](repeating: 0, count: size)
        guard sysctlbyname("hw.machine", &bytes, &size, nil, 0) == 0 else { return "unknown" }
        return String(cString: bytes)
    }
    static func instruction(elapsed: TimeInterval) -> String {
        switch elapsed {
        case ..<4: return "Gently turn left and right at varied speeds."
        case ..<9: return "Gently tilt up and down at varied speeds."
        default: return "Combine gentle turns and tilts, then hold still."
        }
    }

    static func annotateEpisode(at folder: URL, episodeID: UUID, deviceModel: String, osVersion: String) throws {
        let url = folder.appendingPathComponent("manifest.json")
        let bytes = try Data(contentsOf: url)
        guard var manifest = try JSONSerialization.jsonObject(with: bytes) as? [String: Any],
              let id = manifest["episode_id"] as? String, UUID(uuidString: id) == episodeID,
              var sensors = manifest["sensor_metadata"] as? [String: Any] else { throw ClientError.storage }
        sensors["timing_reference"] = [
            "protocol_version": 1,
            "purpose": "camera_motion_temporal_reference",
            "analysis_status": "awaiting_independent_visual_analysis",
            "corrections_applied": false,
            "device_model": deviceModel,
            "os_version": osVersion,
            "instructions": "stationary textured target; varied gentle rotations; mounted phone; no walking",
            "button_delay_measured": false
        ] as [String: Any]
        manifest["sensor_metadata"] = sensors
        try JSONSerialization.data(withJSONObject: manifest, options: [.sortedKeys]).write(to: url, options: .atomic)
        try CaptureQueue.protect(url)
    }
}
