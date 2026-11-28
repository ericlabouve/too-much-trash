import XCTest
@testable import TooMuchTrash

final class ContinuousCaptureTests: XCTestCase {
    func testPartsSurviveSourceRemovalAndFinalizeOnlyAfterPendingCloses() throws {
        let base = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: base) }
        let source = base.appendingPathComponent("part.mp4")
        try Data([1,2,3]).write(to: source)
        let journal = try ContinuousCapture(owner: base, start: 10)
        try journal.stop(at: 14, pending: [source], reason: "user_stop")
        XCTAssertFalse(try journal.finishIfReady())
        try journal.segment(.init(url: source, firstTimestamp: 10, lastTimestamp: 14, frameCount: 4, error: nil))
        XCTAssertTrue(try journal.finishIfReady())
        try FileManager.default.removeItem(at: source)
        XCTAssertEqual(try Data(contentsOf: journal.directory.appendingPathComponent("part.mp4")), Data([1,2,3]))
        let manifest = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: journal.directory.appendingPathComponent("session.json"))) as? [String: Any])
        XCTAssertEqual(manifest["finalized"] as? Bool, true)
    }
    func testUnfinishedSessionPreservesManifestAndSensorWindow() throws {
        let base = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: base) }
        let journal = try ContinuousCapture(owner: base, start: 10)
        try journal.append(["time": 9], stream: "imu", time: 9)
        try journal.append(["time": 11], stream: "imu", time: 11)
        try journal.stop(at: 12, pending: [], reason: "interruption")
        try journal.append(["time": 13], stream: "imu", time: 13)
        XCTAssertTrue(try journal.finishIfReady())
        let lines = try String(contentsOf: journal.directory.appendingPathComponent("imu.jsonl"), encoding: .utf8).split(separator: "\n")
        XCTAssertEqual(lines.count, 1)
    }
}

extension ContinuousCaptureTests {
    func testFailedVideoPartCannotBePresentedAsFinalized() throws {
        let base = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: base) }
        let missing = base.appendingPathComponent("missing.mp4")
        let journal = try ContinuousCapture(owner: base, start: 1)
        try journal.stop(at: 2, pending: [missing], reason: "test")
        XCTAssertThrowsError(try journal.segment(.init(url: missing, firstTimestamp: 1, lastTimestamp: 2, frameCount: 0, error: "failed")))
        XCTAssertFalse(try journal.finishIfReady())
        XCTAssertThrowsError(try ContinuousCapture.fileNames(journal.directory))
    }
    func testInterruptedRecordingIsExplicitlyRecoveredWithoutChangingRawJournals() throws {
        let base = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: base) }
        let source = base.appendingPathComponent("part.mp4")
        try Data([1]).write(to: source)
        let journal = try ContinuousCapture(owner: base, start: 1)
        try journal.segment(.init(url: source, firstTimestamp: 1, lastTimestamp: 2, frameCount: 2, error: nil))
        try journal.event(["kind": "squeeze_reference", "callback_uptime": 1.5], stream: "references")
        let raw = try Data(contentsOf: journal.directory.appendingPathComponent("references.jsonl"))
        try ContinuousCapture.recover(in: base)
        let manifest = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: journal.directory.appendingPathComponent("session.json"))) as? [String: Any])
        XCTAssertEqual(manifest["recovered_after_interruption"] as? Bool, true)
        XCTAssertEqual(manifest["end"] as? Double, 2)
        XCTAssertEqual(try Data(contentsOf: journal.directory.appendingPathComponent("references.jsonl")), raw)
        XCTAssertEqual(try ContinuousCapture.fileNames(journal.directory).count, 7)
    }
}
