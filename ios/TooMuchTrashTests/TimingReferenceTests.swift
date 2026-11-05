import XCTest
@testable import TooMuchTrash

final class TimingReferenceTests: XCTestCase {
    func testReferenceLabelsPreserveTimingAndDoNotInventCorrections() throws {
        let folder = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: folder) }
        let id = UUID()
        let manifest: [String: Any] = ["episode_id": id.uuidString, "complete": false,
            "timing": ["start": 10.0, "press": 13.0, "release": 27.0, "end": 30.0],
            "sensor_metadata": ["nativeClockAlignment": "unverified"]]
        let file = folder.appendingPathComponent("manifest.json")
        try JSONSerialization.data(withJSONObject: manifest).write(to: file)
        try TimingReference.annotateEpisode(at: folder, episodeID: id, deviceModel: "test", osVersion: "test")
        let result = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: file)) as? [String: Any])
        XCTAssertEqual(result["complete"] as? Bool, false)
        XCTAssertEqual(result["timing"] as? [String: Double], manifest["timing"] as? [String: Double])
        let sensors = try XCTUnwrap(result["sensor_metadata"] as? [String: Any])
        XCTAssertEqual(sensors["nativeClockAlignment"] as? String, "unverified")
        let reference = try XCTUnwrap(sensors["timing_reference"] as? [String: Any])
        XCTAssertEqual(reference["corrections_applied"] as? Bool, false)
        XCTAssertEqual(reference["button_delay_measured"] as? Bool, false)
        XCTAssertEqual(reference["analysis_status"] as? String, "awaiting_independent_visual_analysis")
        let saved = try Data(contentsOf: file)
        XCTAssertThrowsError(try TimingReference.annotateEpisode(at: folder, episodeID: UUID(), deviceModel: "test", osVersion: "test"))
        XCTAssertEqual(try Data(contentsOf: file), saved)
    }
}
