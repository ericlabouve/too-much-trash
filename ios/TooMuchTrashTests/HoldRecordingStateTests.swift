import XCTest
import AVFoundation
@testable import TooMuchTrash

final class HoldRecordingStateTests: XCTestCase {
    func testMeasuredByteBudgetStopsAtLastSafeSegmentForHighBitrate() {
        let pieces: [EpisodeLiveByteBudget.Piece] = [.init(end: 11, bytes: 25_000_000), .init(end: 12, bytes: 25_000_000), .init(end: 13, bytes: 25_000_000), .init(end: 14, bytes: 25_000_000)]
        XCTAssertEqual(EpisodeLiveByteBudget.cutoff(pieces: pieces, sensorBytes: 1_000_000, start: 10), 13)
        XCTAssertNil(EpisodeLiveByteBudget.cutoff(pieces: Array(pieces.prefix(3)), sensorBytes: 1_000_000, start: 10))
        XCTAssertEqual(EpisodeLiveByteBudget.cutoff(pieces: pieces, sensorBytes: 30_000_000, start: 10), 11)
    }

    func testByteLimitNeverInventsReleaseAndTrimsFutureSamples() throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: root) }
        var scheduler = EpisodeWindowScheduler()
        let window = try XCTUnwrap(scheduler.press("volume", at: 10))
        let journal = try EpisodeJournal(ownerDirectory: root, window: window)
        for time in [9.0, 11.0, 13.0] {
            try journal.append(MotionSample(stream: .accelerometer, timestamp: time, values: [1, 2, 3]), commonTime: time, through: nil)
        }
        let limited = try XCTUnwrap(scheduler.limitBytes(window.id, through: 12))
        XCTAssertEqual(limited.end, 12)
        XCTAssertNil(limited.releasedAt)
        XCTAssertEqual(limited.incompleteReason, "episode_size_limit")
        try journal.trimSensors(through: 12)
        let retained = try Data(contentsOf: journal.directory.appendingPathComponent("imu.jsonl"))
        let original = try Data(contentsOf: journal.directory.appendingPathComponent("overflow/imu.jsonl"))
        XCTAssertEqual(retained.split(separator: 10).count, 2)
        XCTAssertEqual(original.split(separator: 10).count, 3)
        XCTAssertEqual(journal.sensorBytesWritten, Int64(retained.count))
    }

    func testEpisodeDurationLimitMarksLongHoldWithoutInventingRelease() throws {
        var scheduler = EpisodeWindowScheduler()
        let window = try XCTUnwrap(scheduler.press("volume", at: 10))
        XCTAssertNil(scheduler.limit(window.id, at: 36.99))
        let limited = try XCTUnwrap(scheduler.limit(window.id, at: 37))
        XCTAssertEqual(limited.start, 7)
        XCTAssertEqual(limited.end, 37)
        XCTAssertNil(limited.releasedAt)
        XCTAssertEqual(limited.incompleteReason, "episode_duration_limit")
        scheduler.release("volume", at: 40)
        XCTAssertNil(scheduler.pending.first?.releasedAt)
    }

    func testEpisodeDurationLimitTruncatesPostRollOnlyWhenNeeded() throws {
        var scheduler = EpisodeWindowScheduler()
        let first = try XCTUnwrap(scheduler.press("first", at: 10))
        scheduler.release("first", at: 34)
        let completed = try XCTUnwrap(scheduler.pending.first { $0.id == first.id })
        XCTAssertEqual(completed.end, 37)
        XCTAssertEqual(completed.releasedAt, 34)
        XCTAssertNil(completed.incompleteReason)

        let second = try XCTUnwrap(scheduler.press("second", at: 10))
        scheduler.release("second", at: 36)
        let capped = try XCTUnwrap(scheduler.pending.first { $0.id == second.id })
        XCTAssertEqual(capped.end, 37)
        XCTAssertEqual(capped.releasedAt, 36)
        XCTAssertEqual(capped.incompleteReason, "episode_duration_limit")
    }

    func testEpisodeVideoBudgetReservesSpaceForSidecars() throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: root) }
        var scheduler = EpisodeWindowScheduler()
        let window = try XCTUnwrap(scheduler.press("volume", at: 10))
        let journal = try EpisodeJournal(ownerDirectory: root, window: window)
        let emptyBudget = try journal.videoByteBudget()
        try journal.append(MotionSample(stream: .accelerometer, timestamp: 9, values: [1, 2, 3]), commonTime: 9, through: 15)
        let sensorBytes = try XCTUnwrap((FileManager.default.attributesOfItem(atPath: journal.directory.appendingPathComponent("imu.jsonl").path)[.size] as? NSNumber)?.int64Value)
        XCTAssertGreaterThan(sensorBytes, 0)
        XCTAssertEqual(try journal.videoByteBudget(), emptyBudget - sensorBytes)
        XCTAssertLessThan(emptyBudget, EpisodeJournal.maximumEpisodeBytes)
    }

    func testOversizedBundleIsNotFinalizedAndVideoIsRetained() throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: root) }
        var scheduler = EpisodeWindowScheduler()
        let window = try XCTUnwrap(scheduler.press("volume", at: 10))
        let journal = try EpisodeJournal(ownerDirectory: root, window: window)
        let video = root.appendingPathComponent("video.mp4")
        XCTAssertTrue(FileManager.default.createFile(atPath: video.path, contents: nil))
        let handle = try FileHandle(forWritingTo: video)
        try handle.truncate(atOffset: UInt64(EpisodeJournal.maximumEpisodeBytes))
        try handle.close()
        XCTAssertThrowsError(try journal.finalize(video: video, release: 12, end: 15, validatedCoverageAndClock: false))
        XCTAssertTrue(FileManager.default.fileExists(atPath: journal.directory.appendingPathComponent("video.mp4").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: journal.directory.appendingPathComponent("recovery.json").path))
    }
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
        let pose = CameraPoseSample(timestamp: 8, callbackUptime: 8.01, cameraToWorldColumns: Array(repeating: 0, count: 16), cameraOrientationQuaternion: [0, 0, 0, 1], intrinsicsColumns: Array(repeating: 0, count: 9), imageWidth: 1920, imageHeight: 1080, tracking: "limited", trackingReason: "initializing")
        try journal.append(pose, commonTime: 8, through: 15)
        let video = root.appendingPathComponent("temporary.mp4")
        try Data("video".utf8).write(to: video)
        let geometry = EncodedFrameGeometry(sourceWidth: 1920, sourceHeight: 1080)
        try journal.finalize(video: video, release: 12, end: 15,
                             validatedCoverageAndClock: false, videoFrameGeometry: [geometry])
        let manifest = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(contentsOf: journal.directory.appendingPathComponent("manifest.json"))) as? [String: Any])
        XCTAssertEqual(manifest["complete"] as? Bool, false)
        XCTAssertEqual(manifest["episode_id"] as? String, window.id.uuidString)
        let metadata = try XCTUnwrap(manifest["sensor_metadata"] as? [String: Any])
        XCTAssertEqual(metadata["videoFrameCoordinates"] as? String, "top_left_pixel_edges_scale_to_content_then_translate")
        let mapping = try XCTUnwrap((metadata["videoFrameGeometry"] as? [[String: Int]])?.first)
        XCTAssertEqual(mapping, ["sourceWidth": 1920, "sourceHeight": 1080, "encodedWidth": 960, "encodedHeight": 720,
                                 "contentX": 0, "contentY": 90, "contentWidth": 960, "contentHeight": 540])
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
        let result = CVPixelBufferCreate(nil, 1920, 1440, kCVPixelFormatType_420YpCbCr8BiPlanarFullRange,
                                         [kCVPixelBufferIOSurfacePropertiesKey: [:]] as CFDictionary, &source)
        XCTAssertEqual(result, kCVReturnSuccess)
        let frame = try XCTUnwrap(source)
        XCTAssertEqual(CVPixelBufferLockBaseAddress(frame, []), kCVReturnSuccess)
        for plane in 0..<2 {
            let base = try XCTUnwrap(CVPixelBufferGetBaseAddressOfPlane(frame, plane))
            memset(base, 128, CVPixelBufferGetBytesPerRowOfPlane(frame, plane) * CVPixelBufferGetHeightOfPlane(frame, plane))
        }
        CVPixelBufferUnlockBaseAddress(frame, [])
        for i in 0..<10 {
            try writer.append(frame, timestamp: 10 + Double(i) / 60)
            try await Task.sleep(for: .milliseconds(3))
        }
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
        let size = try await XCTUnwrap(video.first).load(.naturalSize)
        XCTAssertEqual(size, CGSize(width: 960, height: 720))
        XCTAssertTrue(audio.isEmpty)
        let assembledResult = try await EpisodeVideoAssembler.assemble(segments: [segment], start: 9.5, end: 10.3,
                                                               output: directory.appendingPathComponent("assembled.mp4"))
        let assembled = AVURLAsset(url: assembledResult.url)
        let assembledPlayable = try await assembled.load(.isPlayable)
        let assembledAudio = try await assembled.loadTracks(withMediaType: .audio)
        let mapping = try XCTUnwrap(assembledResult.geometry.first)
        XCTAssertEqual(mapping.sourceWidth, 1920)
        XCTAssertEqual(mapping.sourceHeight, 1440)
        XCTAssertEqual(mapping.contentX, 0)
        XCTAssertEqual(mapping.contentY, 0)
        XCTAssertEqual(mapping.contentWidth, 960)
        XCTAssertEqual(mapping.contentHeight, 720)
        XCTAssertTrue(assembledPlayable)
        XCTAssertTrue(assembledAudio.isEmpty)
        var rejectedTinyBudget = false
        do {
            _ = try await EpisodeVideoAssembler.assemble(segments: [segment], start: 9.5, end: 10.3,
                output: directory.appendingPathComponent("too-small.mp4"), maximumVideoBytes: 1)
        } catch { rejectedTinyBudget = true }
        XCTAssertTrue(rejectedTinyBudget)
        XCTAssertTrue(FileManager.default.fileExists(atPath: segment.url.path), "Retain the original segment when export is limited")
        XCTAssertEqual(assembledResult.gaps.first?.start, 9.5)
    }
    func testJoinDiagnosticsPreserveRoundingWithoutHidingMissingFrames() {
        for fps in [29.97, 59.94] {
            let dt = 1 / fps
            func segment(_ times: [Double]) -> ARVideoSegmentWriter.Segment {
                .init(url: URL(fileURLWithPath: "/unused"), firstTimestamp: times.first!, lastTimestamp: times.last!,
                      frameCount: times.count, error: nil, frameTimestamps: times)
            }
            let previous = segment([10, 10 + dt, 10 + 2 * dt, 10 + 3 * dt])
            let next = segment([10 + 4 * dt, 10 + 5 * dt, 10 + 6 * dt])
            let tiny = EpisodeVideoAssembler.classifyJoin(previous: previous, next: next,
                gapStart: next.firstTimestamp - 0.000071, gapEnd: next.firstTimestamp)
            XCTAssertEqual(tiny.classification, "subframe_container_join")
            XCTAssertEqual(tiny.containerGapEnd - tiny.containerGapStart, 0.000071, accuracy: 0.000000001)
            let missing = segment([10 + 5 * dt, 10 + 6 * dt, 10 + 7 * dt])
            XCTAssertEqual(EpisodeVideoAssembler.classifyJoin(previous: previous, next: missing,
                gapStart: next.firstTimestamp - 0.000071, gapEnd: missing.firstTimestamp).classification, "unverified_video_gap")
            let unknown = ARVideoSegmentWriter.Segment(url: previous.url, firstTimestamp: previous.firstTimestamp,
                lastTimestamp: previous.lastTimestamp, frameCount: previous.frameCount, error: nil)
            XCTAssertEqual(EpisodeVideoAssembler.classifyJoin(previous: unknown, next: next,
                gapStart: next.firstTimestamp - 0.000071, gapEnd: next.firstTimestamp).classification, "unverified_video_gap")
        }
    }

    func testMultiSegmentPassthroughKeepsSourceCadenceAndNoAudio() async throws {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: directory) }
        let writer = try ARVideoSegmentWriter(directory: directory, segmentDuration: 0.5,
                                              encodedWidth: 64, encodedHeight: 64)
        let done = expectation(description: "all segments")
        done.expectedFulfillmentCount = 3
        var segments: [ARVideoSegmentWriter.Segment] = []
        let lock = NSLock()
        writer.onSegment = { segment in lock.lock(); segments.append(segment); lock.unlock(); done.fulfill() }
        var source: CVPixelBuffer?
        XCTAssertEqual(CVPixelBufferCreate(nil, 64, 64, kCVPixelFormatType_32BGRA,
            [kCVPixelBufferIOSurfacePropertiesKey: [:]] as CFDictionary, &source), kCVReturnSuccess)
        let frame = try XCTUnwrap(source)
        for i in 0..<80 { try writer.append(frame, timestamp: 10 + Double(i) / 59.94); try await Task.sleep(for: .milliseconds(2)) }
        writer.finishCurrent()
        await fulfillment(of: [done], timeout: 20)
        let ordered = segments.sorted { $0.firstTimestamp < $1.firstTimestamp }
        XCTAssertEqual(ordered.reduce(0) { $0 + $1.frameCount }, 80)
        let result = try await EpisodeVideoAssembler.assemble(segments: ordered, start: 10,
            end: 10 + 79.0 / 59.94, output: directory.appendingPathComponent("joined.mp4"))
        XCTAssertTrue(result.gaps.isEmpty, "Contiguous accepted source frames must not be classified as missing")
        let asset = AVURLAsset(url: result.url)
        let audio = try await asset.loadTracks(withMediaType: .audio)
        XCTAssertTrue(audio.isEmpty)
        let tracks = try await asset.loadTracks(withMediaType: .video)
        let track = try XCTUnwrap(tracks.first)
        let reader = try AVAssetReader(asset: asset)
        let output = AVAssetReaderTrackOutput(track: track, outputSettings: [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA])
        reader.add(output)
        XCTAssertTrue(reader.startReading())
        var times: [Double] = []
        while let sample = output.copyNextSampleBuffer() { times.append(CMTimeGetSeconds(CMSampleBufferGetPresentationTimeStamp(sample))) }
        XCTAssertEqual(reader.status, .completed)
        XCTAssertGreaterThanOrEqual(times.count, 79)
        XCTAssertTrue(zip(times.dropFirst(), times).allSatisfy { $0.0 - $0.1 < 1.5 / 59.94 })
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
