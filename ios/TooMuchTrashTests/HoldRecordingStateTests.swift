import XCTest
import AVFoundation
@testable import TooMuchTrash

final class HoldRecordingStateTests: XCTestCase {
    #if DEBUG
    func testSyntheticCaptureCoordinatorFinalizesAnEpisode() async throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: root) }
        let engine = try EpisodeCaptureEngine(ownerDirectory: root)
        engine.debugActivateForSyntheticFrames()
        let done = expectation(description: "separate episodes saved")
        done.expectedFulfillmentCount = 2
        var savedFolders: [URL] = []
        var statuses: [String] = []
        engine.onStatus = { statuses.append($0.message) }
        engine.onEpisode = { folder, _ in savedFolders.append(folder); done.fulfill() }
        var source: CVPixelBuffer?
        XCTAssertEqual(CVPixelBufferCreate(nil, 64, 64, kCVPixelFormatType_32BGRA,
                                          [kCVPixelBufferIOSurfacePropertiesKey: [:]] as CFDictionary, &source), kCVReturnSuccess)
        let pixels = try XCTUnwrap(source)
        // Keep the simulated release close to the coordinator's actual clock;
        // an event far in the past correctly triggers the finalization watchdog.
        let base = ProcessInfo.processInfo.systemUptime - 1
        func feedMotion(_ time: TimeInterval) {
            for stream in [MotionSample.Stream.accelerometer, .gyroscope, .attitude] {
                engine.debugAccept(MotionSample(stream: stream, timestamp: time, values: [0, 0, 0]))
            }
        }
        func feedFrame(_ time: TimeInterval) async {
            let frame = expectation(description: "frame processed")
            let pose = CameraPoseSample(timestamp: time, callbackUptime: time, cameraToWorldColumns: Array(repeating: 0, count: 16),
                cameraOrientationQuaternion: [0, 0, 0, 1], intrinsicsColumns: Array(repeating: 0, count: 9),
                imageWidth: 64, imageHeight: 64, tracking: "normal", trackingReason: nil)
            engine.debugFrame(pixels, pose: pose) { frame.fulfill() }
            await fulfillment(of: [frame], timeout: 10)
        }
        for tick in 0...12 { let time = base - 3 + Double(tick) / 4; feedMotion(time); await feedFrame(time) }
        engine.debugForceReady()
        engine.press("volume", at: base)
        engine.debugDrainState()
        engine.release("volume", at: base + 1)
        engine.debugDrainState()
        engine.press("volume", at: base + 1.1)
        engine.release("volume", at: base + 1.2)
        engine.debugDrainState()
        for tick in 1...19 { let time = base + Double(tick) / 4; feedMotion(time); await feedFrame(time) }
        await fulfillment(of: [done], timeout: 30)
        XCTAssertEqual(savedFolders.count, 2, "Capture statuses: \(statuses.joined(separator: "; ")); \(engine.debugSummary())")
        XCTAssertEqual(Set(savedFolders).count, 2)
        for folder in savedFolders {
            for name in ["video.mp4", "imu.jsonl", "poses.jsonl", "manifest.json"] {
                XCTAssertTrue(FileManager.default.fileExists(atPath: folder.appendingPathComponent(name).path), name)
            }
            let manifest = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: folder.appendingPathComponent("manifest.json"))) as? [String: Any])
            XCTAssertEqual(manifest["complete"] as? Bool, false)
        }
        engine.stop(reason: "test_end")
        engine.debugDrainState()
    }
    #endif
    func testJournalPreservesSamplesAndMarksUnverifiedEpisodeIncomplete() throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: root) }
        var scheduler = EpisodeWindowScheduler()
        let window = try XCTUnwrap(scheduler.press("volume", at: 10))
        let journal = try EpisodeJournal(ownerDirectory: root, window: window)
        for stream in [MotionSample.Stream.accelerometer, .gyroscope, .attitude] {
            try journal.append(MotionSample(stream: stream, timestamp: 8, values: [1, 2, 3]), commonTime: 8, through: 15)
        }
        let pose = CameraPoseSample(timestamp: 8, callbackUptime: 8.01, cameraToWorldColumns: Array(repeating: 0, count: 16), cameraOrientationQuaternion: [0, 0, 0, 1], intrinsicsColumns: Array(repeating: 0, count: 9), imageWidth: 64, imageHeight: 64, tracking: "limited", trackingReason: "initializing")
        try journal.append(pose, commonTime: 8, through: 15)
        let video = root.appendingPathComponent("temporary.mp4")
        try Data("video".utf8).write(to: video)
        try journal.finalize(video: video, release: 12, end: 15, validatedCoverageAndClock: false)
        let manifest = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: journal.directory.appendingPathComponent("manifest.json"))) as? [String: Any])
        XCTAssertEqual(manifest["complete"] as? Bool, false)
        XCTAssertEqual(manifest["episode_id"] as? String, window.id.uuidString)
        XCTAssertEqual(String(decoding: try Data(contentsOf: journal.directory.appendingPathComponent("imu.jsonl")), as: UTF8.self).split(separator: "\n").count, 3)
        XCTAssertTrue(FileManager.default.fileExists(atPath: journal.directory.appendingPathComponent("video.mp4").path))
    }

    func testJournalMarksMissingSensorsAndKeepsIncompleteData() throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: root) }
        var scheduler = EpisodeWindowScheduler()
        let window = try XCTUnwrap(scheduler.press("volume", at: 10))
        let journal = try EpisodeJournal(ownerDirectory: root, window: window)
        let video = root.appendingPathComponent("temporary.mp4")
        try Data("video".utf8).write(to: video)
        try journal.finalize(video: video, release: nil, end: 11, validatedCoverageAndClock: false)
        let manifest = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: journal.directory.appendingPathComponent("manifest.json"))) as? [String: Any])
        XCTAssertEqual(manifest["complete"] as? Bool, false)
        let metadata = try XCTUnwrap(manifest["sensor_metadata"] as? [String: Any])
        let gaps = try XCTUnwrap(metadata["gaps"] as? [[String: Any]])
        XCTAssertEqual(Set(gaps.compactMap { $0["stream"] as? String }), Set(["imu", "camera_pose"]))
        XCTAssertGreaterThan(try Data(contentsOf: journal.directory.appendingPathComponent("poses.jsonl")).count, 0)
    }
    func testSegmentRetentionKeepsPrerollAndAllPendingOverlaps() throws {
        var index = EpisodeSegmentIndex()
        let old = EpisodeSegmentIndex.Segment(id: UUID(), start: 0, end: 1)
        let held = EpisodeSegmentIndex.Segment(id: UUID(), start: 2, end: 3)
        let recent = EpisodeSegmentIndex.Segment(id: UUID(), start: 7, end: 8)
        XCTAssertTrue(index.add(recent))
        XCTAssertTrue(index.add(old))
        XCTAssertTrue(index.add(held))
        var scheduler = EpisodeWindowScheduler()
        _ = scheduler.press("volume", at: 5)
        XCTAssertEqual(index.disposable(now: 10, pending: scheduler.pending).map(\.id), [old.id])
        XCTAssertEqual(index.overlapping(start: 3, end: 7).map(\.id), [held.id, recent.id])
        scheduler.release("volume", at: 6)
        _ = scheduler.completed(through: 9)
        XCTAssertEqual(index.disposable(now: 10, pending: scheduler.pending).map(\.id), [old.id, held.id])
    }
    func testSegmentWriterProducesAReadableVideoWithoutAudio() async throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: directory) }
        let writer = try ARVideoSegmentWriter(directory: directory)
        let done = expectation(description: "segment finished")
        var completed: ARVideoSegmentWriter.Segment?
        writer.onSegment = { segment in completed = segment; done.fulfill() }
        var source: CVPixelBuffer?
        let result = CVPixelBufferCreate(nil, 64, 64, kCVPixelFormatType_32BGRA,
                                         [kCVPixelBufferIOSurfacePropertiesKey: [:]] as CFDictionary, &source)
        XCTAssertEqual(result, kCVReturnSuccess)
        let frame = try XCTUnwrap(source)
        for i in 0..<10 { try writer.append(frame, timestamp: 10 + Double(i) / 30) }
        writer.finishCurrent()
        await fulfillment(of: [done], timeout: 20)
        let segment = try XCTUnwrap(completed)
        XCTAssertNil(segment.error)
        XCTAssertGreaterThan(segment.frameCount, 0)
        let asset = AVURLAsset(url: segment.url)
        let playable = try await asset.load(.isPlayable)
        XCTAssertTrue(playable)
        let video = try await asset.loadTracks(withMediaType: .video)
        let audio = try await asset.loadTracks(withMediaType: .audio)
        XCTAssertEqual(video.count, 1)
        XCTAssertTrue(audio.isEmpty)
        let assembledResult = try await EpisodeVideoAssembler.assemble(segments: [segment], start: 9.5, end: 10.3,
                                                               output: directory.appendingPathComponent("assembled.mp4"))
        let assembled = AVURLAsset(url: assembledResult.url)
        let assembledPlayable = try await assembled.load(.isPlayable)
        let assembledAudio = try await assembled.loadTracks(withMediaType: .audio)
        XCTAssertTrue(assembledPlayable)
        XCTAssertTrue(assembledAudio.isEmpty)
        XCTAssertEqual(assembledResult.gaps.first?.start, 9.5)
    }
    func testTimedPreRollRetainsExactBoundaryAndAcceptsLateDataInWindow() {
        var buffer = TimedPreRoll<Int>()
        for i in 0...6 { XCTAssertTrue(buffer.append(time: Double(i), value: i)) }
        XCTAssertEqual(buffer.samples.map(\.time), [3, 4, 5, 6])
        XCTAssertEqual(buffer.snapshot(from: 3, through: 5).map(\.value), [3, 4, 5])
        XCTAssertTrue(buffer.append(time: 5, value: 99))
        XCTAssertFalse(buffer.append(time: 2, value: 100))
        XCTAssertEqual(buffer.outOfOrderCount, 2)
        XCTAssertEqual(buffer.rejectedLateCount, 1)
        XCTAssertEqual(buffer.samples.map(\.value), [3, 4, 5, 99, 6])
    }
    func testEpisodeWindowsKeepOverlappingPressesSeparate() throws {
        var scheduler = EpisodeWindowScheduler()
        let first = try XCTUnwrap(scheduler.press("volume", at: 100))
        scheduler.release("volume", at: 101)
        let second = try XCTUnwrap(scheduler.press("volume", at: 102))
        scheduler.release("volume", at: 103)
        XCTAssertNotEqual(first.id, second.id)
        XCTAssertEqual(first.start, 97)
        XCTAssertEqual(second.start, 99)
        XCTAssertTrue(scheduler.completed(through: 103.99).isEmpty)
        let completedFirst = scheduler.completed(through: 104)
        XCTAssertEqual(completedFirst.first?.id, first.id)
        XCTAssertEqual(completedFirst.first?.releasedAt, 101)
        XCTAssertEqual(completedFirst.first?.end, 104)
        XCTAssertEqual(scheduler.completed(through: 106).first?.id, second.id)
    }

    func testInterruptionPreservesIncompleteWindowAndExistingRelease() throws {
        var scheduler = EpisodeWindowScheduler()
        _ = scheduler.press("volume", at: 20)
        scheduler.release("volume", at: 21)
        let interrupted = try XCTUnwrap(scheduler.interrupt(at: 22, reason: "background").first)
        XCTAssertEqual(interrupted.start, 17)
        XCTAssertEqual(interrupted.releasedAt, 21)
        XCTAssertEqual(interrupted.end, 22)
        XCTAssertEqual(interrupted.incompleteReason, "background")
        XCTAssertTrue(scheduler.pending.isEmpty)
    }

    func testDuplicateAndInvalidEventsDoNotAlterOpenWindow() throws {
        var scheduler = EpisodeWindowScheduler()
        _ = scheduler.press("volume", at: 10)
        XCTAssertNil(scheduler.press("volume", at: 11))
        scheduler.release("volume", at: 9)
        scheduler.release("other", at: 12)
        XCTAssertNil(scheduler.pending.first?.releasedAt)
        scheduler.release("volume", at: 13)
        XCTAssertEqual(scheduler.pending.first?.end, 16)
    }
    func testHoldRecordsUntilRelease() {
        var state = HoldRecordingState()
        XCTAssertEqual(state.press("primary"), .start)
        XCTAssertEqual(state.didStart(), .none)
        XCTAssertEqual(state.release("primary"), .stop)
        XCTAssertEqual(state.phase, .finishing)
        state.didFinish()
        XCTAssertEqual(state.phase, .idle)
        XCTAssertEqual(state.press("primary"), .start)
    }

    func testReleaseBeforeRecordingStartsStillStops() {
        var state = HoldRecordingState()
        XCTAssertEqual(state.press("primary"), .start)
        XCTAssertEqual(state.release("primary"), .none)
        XCTAssertEqual(state.didStart(), .stop)
    }

    func testRepeatedPressDoesNotStartAnotherClip() {
        var state = HoldRecordingState()
        XCTAssertEqual(state.press("primary"), .start)
        XCTAssertEqual(state.press("primary"), .none)
        XCTAssertEqual(state.didStart(), .none)
        XCTAssertEqual(state.release("primary"), .stop)
        XCTAssertEqual(state.press("secondary"), .none)
        state.didFinish()
        XCTAssertEqual(state.press("secondary"), .start)
    }

    func testOverlappingButtonsStopOnlyAfterBothRelease() {
        var state = HoldRecordingState()
        _ = state.press("primary")
        _ = state.didStart()
        XCTAssertEqual(state.press("secondary"), .none)
        XCTAssertEqual(state.release("primary"), .none)
        XCTAssertEqual(state.release("secondary"), .stop)
    }

    func testBackgroundOrInterruptionCancelsHeldRecording() {
        var state = HoldRecordingState()
        _ = state.press("screen")
        _ = state.didStart()
        XCTAssertEqual(state.cancel(), .stop)
        XCTAssertEqual(state.cancel(), .none)
        state.didFinish()
        XCTAssertEqual(state.press("screen"), .start)
    }

    func testCancellationWhileStartingStopsAfterCallback() {
        var state = HoldRecordingState()
        _ = state.press("primary")
        XCTAssertEqual(state.cancel(), .none)
        XCTAssertEqual(state.didStart(), .stop)
    }
}
