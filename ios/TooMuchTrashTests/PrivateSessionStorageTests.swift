import XCTest
@testable import TooMuchTrash

@MainActor
final class PrivateSessionStorageTests: XCTestCase {
    private let origin = URL(string: "https://collector.example.test")!
    private func folder() -> URL { FileManager.default.temporaryDirectory.appendingPathComponent("tmt-private-\(UUID())") }

    func testEpisodeQueuePersistsAllFilesAndTracksUnfinishedFolders() throws {
        let root = folder()
        defer { try? FileManager.default.removeItem(at: root) }
        let queue = CaptureQueue(directory: root), owner = UUID(), id = UUID()
        let ownerFolder = try queue.recordingDirectory(origin: origin, installationID: owner)
        let episode = ownerFolder.appendingPathComponent("episode-\(id.uuidString.lowercased())", isDirectory: true)
        try FileManager.default.createDirectory(at: episode, withIntermediateDirectories: true)
        XCTAssertEqual(queue.untrackedVideoCount(origin: origin, installationID: owner), 1)
        for name in ["video.mp4", "imu.jsonl", "poses.jsonl"] {
            try Data(name.utf8).write(to: episode.appendingPathComponent(name))
        }
        try Data("{\"episode_id\":\"\(id.uuidString)\",\"complete\":false}".utf8).write(to: episode.appendingPathComponent("manifest.json"))
        try queue.enqueueEpisode(folder: episode, id: id, origin: origin, installationID: owner)
        XCTAssertEqual(queue.untrackedVideoCount(origin: origin, installationID: owner), 0)
        let restored = CaptureQueue(directory: root)
        let entry = try XCTUnwrap(restored.captures.first)
        XCTAssertEqual(entry.id, id)
        XCTAssertEqual(entry.isIncomplete, true)
        XCTAssertEqual(restored.file(for: entry), episode.appendingPathComponent("video.mp4"))
        XCTAssertEqual(try restored.storedSize(for: entry), entry.sizeBytes)
        XCTAssertTrue(FileManager.default.fileExists(atPath: episode.appendingPathComponent("imu.jsonl").path))
    }

    func testLegacyMigrationPreservesOriginalQueueAndVideos() throws {
        let legacy = folder(), target = folder(), id = UUID()
        let old = CaptureQueue(directory: legacy)
        let file = legacy.appendingPathComponent("original.mov")
        try Data("original video".utf8).write(to: file)
        try old.enqueue(file: file, origin: origin, installationID: id)
        let migrated = CaptureQueue(directory: target, legacyDirectory: legacy)
        XCTAssertFalse(migrated.storageUnavailable)
        XCTAssertEqual(migrated.captures, old.captures)
        XCTAssertEqual(try Data(contentsOf: migrated.file(for: migrated.captures[0])), Data("original video".utf8))
        XCTAssertFalse(FileManager.default.fileExists(atPath: legacy.path))
        XCTAssertEqual(try target.resourceValues(forKeys: [.isExcludedFromBackupKey]).isExcludedFromBackup, true)
    }

    func testConflictingMigrationNeverOverwritesOriginals() throws {
        let legacy = folder(), target = folder()
        _ = CaptureQueue(directory: legacy)
        try Data("old".utf8).write(to: legacy.appendingPathComponent("old.mov"))
        _ = CaptureQueue(directory: target)
        let queue = CaptureQueue(directory: target, legacyDirectory: legacy)
        XCTAssertTrue(queue.storageUnavailable)
        XCTAssertEqual(try Data(contentsOf: legacy.appendingPathComponent("old.mov")), Data("old".utf8))
    }

    func testScopedCleanupRemovesSessionIncludingUnqueuedFilesButNotOtherOrigin() throws {
        let queue = CaptureQueue(directory: folder()), id = UUID()
        let secondOrigin = URL(string: "https://other.example.test")!
        let ownFolder = try queue.recordingDirectory(origin: origin, installationID: id)
        let otherFolder = try queue.recordingDirectory(origin: secondOrigin, installationID: id)
        let ownFile = ownFolder.appendingPathComponent("recorded.mov")
        let orphan = ownFolder.appendingPathComponent("interrupted.mov")
        let otherFile = otherFolder.appendingPathComponent("recorded.mov")
        try Data("video".utf8).write(to: ownFile)
        try Data("partial".utf8).write(to: orphan)
        try Data("other".utf8).write(to: otherFile)
        try queue.enqueue(file: ownFile, origin: origin, installationID: id)
        try queue.enqueue(file: otherFile, origin: secondOrigin, installationID: id)
        try queue.removeSession(origin: origin, installationID: id)
        XCTAssertFalse(FileManager.default.fileExists(atPath: ownFolder.path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: otherFile.path))
        XCTAssertEqual(queue.captures.count, 1)
        XCTAssertEqual(CaptureQueue(directory: queue.directory).captures, queue.captures)
    }

    func testQueueRejectsUnscopedAndUnsafePaths() throws {
        let queue = CaptureQueue(directory: folder())
        let external = folder().appendingPathComponent("outside.mov")
        XCTAssertThrowsError(try queue.enqueue(file: external, origin: origin, installationID: UUID()))
        let manifest = queue.directory.appendingPathComponent("upload-queue.json")
        let capture = QueuedCapture(id: UUID(), filename: "safe.mov", origin: origin.absoluteString,
                                    installationID: UUID(), relativePath: "../safe.mov")
        let original = try JSONEncoder().encode([capture])
        try original.write(to: manifest)
        let rejected = CaptureQueue(directory: queue.directory)
        XCTAssertTrue(rejected.storageUnavailable)
        XCTAssertTrue(rejected.captures.isEmpty)
        XCTAssertEqual(try Data(contentsOf: manifest), original)
    }

    func testPrivateStorageAndNoFilesSharing() {
        XCTAssertTrue(CaptureQueue.defaultDirectory.path.contains("Library/Application Support/PrivateCaptures"))
        XCTAssertNotEqual(Bundle.main.object(forInfoDictionaryKey: "UIFileSharingEnabled") as? Bool, true)
        XCTAssertNotEqual(Bundle.main.object(forInfoDictionaryKey: "LSSupportsOpeningDocumentsInPlace") as? Bool, true)
    }
}
