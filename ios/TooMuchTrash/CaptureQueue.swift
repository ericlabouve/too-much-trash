import Combine
import Foundation
import CryptoKit

struct QueuedCapture: Codable, Identifiable, Equatable {
    let id: UUID
    let filename: String
    let origin: String
    let installationID: UUID
    var receipt: MediaReceipt?
    var relativePath: String?
    var createdAt: Date?
    var sizeBytes: Int64?
    var uploadBlocked: String?
    var episodeDirectory: String?
    var isIncomplete: Bool?
}

@MainActor
final class CaptureQueue: ObservableObject {
    @Published private(set) var captures: [QueuedCapture] = []
    @Published private(set) var storageUnavailable = false
    let directory: URL
    private let manifest: URL

    nonisolated static var defaultDirectory: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("PrivateCaptures", isDirectory: true)
    }

    init(directory: URL? = nil, legacyDirectory: URL? = nil) {
        self.directory = directory ?? Self.defaultDirectory
        manifest = self.directory.appendingPathComponent("upload-queue.json")
        do {
            let legacy = legacyDirectory ?? (directory == nil ? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Captures") : nil)
            if let legacy, FileManager.default.fileExists(atPath: legacy.path) {
                if !FileManager.default.fileExists(atPath: self.directory.path) {
                    try FileManager.default.createDirectory(at: self.directory.deletingLastPathComponent(), withIntermediateDirectories: true)
                    // Move the entire original queue together, preserving ownership and receipts.
                    try FileManager.default.moveItem(at: legacy, to: self.directory)
                } else if !(try FileManager.default.contentsOfDirectory(atPath: legacy.path)).isEmpty {
                    // Never merge conflicting manifests or silently overwrite original videos.
                    throw ClientError.storage
                }
            }
            try FileManager.default.createDirectory(at: self.directory, withIntermediateDirectories: true)
            try Self.protect(self.directory)
            if FileManager.default.fileExists(atPath: manifest.path) {
                captures = try JSONDecoder().decode([QueuedCapture].self, from: Data(contentsOf: manifest))
                guard captures.allSatisfy(Self.validOwnership),
                      Set(captures.map(\.id)).count == captures.count,
                      Set(captures.map { $0.episodeDirectory ?? $0.relativePath ?? $0.filename }).count == captures.count else { throw ClientError.storage }
            }
        } catch {
            // Do not replace a corrupt/unreadable manifest with an empty queue.
            captures = []
            storageUnavailable = true
        }
    }

    func enqueue(file: URL, origin: URL, installationID: UUID) throws {
        let expectedFolder = try recordingDirectory(origin: origin, installationID: installationID)
        guard [directory.standardizedFileURL, expectedFolder.standardizedFileURL].contains(file.deletingLastPathComponent().standardizedFileURL),
              Self.safeFilename(file.lastPathComponent), FileManager.default.fileExists(atPath: file.path) else {
            throw ClientError.storage
        }
        let relative = file.deletingLastPathComponent().standardizedFileURL == directory.standardizedFileURL
            ? file.lastPathComponent : expectedFolder.lastPathComponent + "/" + file.lastPathComponent
        guard !captures.contains(where: { ($0.relativePath ?? $0.filename) == relative }) else { return }
        let attrs = try FileManager.default.attributesOfItem(atPath: file.path)
        try Self.protect(file)
        var next = captures
        next.append(QueuedCapture(id: UUID(), filename: file.lastPathComponent,
                                  origin: origin.absoluteString, installationID: installationID,
                                  relativePath: relative, createdAt: attrs[.creationDate] as? Date ?? Date(),
                                  sizeBytes: (attrs[.size] as? NSNumber)?.int64Value))
        try persist(next)
    }

    func matching(origin: URL, installationID: UUID) -> [QueuedCapture] {
        captures.filter { $0.origin == origin.absoluteString && $0.installationID == installationID }
    }

    func file(for capture: QueuedCapture) -> URL {
        if let episode = capture.episodeDirectory { return directory.appendingPathComponent(episode).appendingPathComponent("video.mp4") }
        return directory.appendingPathComponent(capture.relativePath ?? capture.filename)
    }

    func episodeFolder(for capture: QueuedCapture) -> URL? {
        capture.episodeDirectory.map { directory.appendingPathComponent($0, isDirectory: true) }
    }

    func storedSize(for capture: QueuedCapture) throws -> Int64 {
        if let folder = episodeFolder(for: capture) {
            var total: Int64 = 0
            for name in ["video.mp4", "imu.jsonl", "poses.jsonl", "manifest.json"] {
                let attributes = try FileManager.default.attributesOfItem(atPath: folder.appendingPathComponent(name).path)
                guard let size = attributes[.size] as? NSNumber, size.int64Value > 0 else { throw ClientError.storage }
                total += size.int64Value
            }
            return total
        }
        let attributes = try FileManager.default.attributesOfItem(atPath: file(for: capture).path)
        guard let size = attributes[.size] as? NSNumber else { throw ClientError.storage }
        return size.int64Value
    }

    nonisolated static func episodeDigest(folder: URL) throws -> String {
        var combined = SHA256()
        for (name, filename) in [("video", "video.mp4"), ("imu", "imu.jsonl"), ("poses", "poses.jsonl"), ("manifest", "manifest.json")] {
            let url = folder.appendingPathComponent(filename)
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            guard let size = attributes[.size] as? NSNumber, size.int64Value > 0 else { throw ClientError.storage }
            var part = SHA256()
            let source = try FileHandle(forReadingFrom: url)
            defer { try? source.close() }
            while let bytes = try source.read(upToCount: 1024 * 1024), !bytes.isEmpty { part.update(data: bytes) }
            try source.close()
            combined.update(data: Data("\(name)\0\(size.int64Value)\0".utf8))
            combined.update(data: Data(part.finalize()))
        }
        return combined.finalize().map { String(format: "%02x", $0) }.joined()
    }

    func enqueueEpisode(folder: URL, id: UUID, origin: URL, installationID: UUID) throws {
        let ownerFolder = try recordingDirectory(origin: origin, installationID: installationID)
        let expectedName = "episode-\(id.uuidString.lowercased())"
        guard folder.standardizedFileURL.deletingLastPathComponent() == ownerFolder.standardizedFileURL,
              folder.lastPathComponent == expectedName else { throw ClientError.storage }
        let relative = ownerFolder.lastPathComponent + "/" + expectedName
        guard !captures.contains(where: { $0.id == id || $0.episodeDirectory == relative }) else { return }
        try Self.protect(folder)
        var total: Int64 = 0
        for name in ["video.mp4", "imu.jsonl", "poses.jsonl", "manifest.json"] {
            let file = folder.appendingPathComponent(name)
            let values = try file.resourceValues(forKeys: [.isRegularFileKey, .isSymbolicLinkKey, .fileSizeKey])
            guard values.isRegularFile == true, values.isSymbolicLink != true, let size = values.fileSize, size > 0 else { throw ClientError.storage }
            total += Int64(size)
            try Self.protect(file)
        }
        let manifestData = try Data(contentsOf: folder.appendingPathComponent("manifest.json"))
        guard manifestData.count <= 1024 * 1024,
              let manifest = try JSONSerialization.jsonObject(with: manifestData) as? [String: Any],
              let episodeID = manifest["episode_id"] as? String, UUID(uuidString: episodeID) == id,
              let complete = manifest["complete"] as? Bool else { throw ClientError.storage }
        var next = captures
        next.append(QueuedCapture(id: id, filename: "video.mp4", origin: origin.absoluteString,
                                  installationID: installationID, createdAt: Date(), sizeBytes: total,
                                  episodeDirectory: relative, isIncomplete: !complete))
        try persist(next)
    }

    func recordingDirectory(origin: URL, installationID: UUID) throws -> URL {
        guard !storageUnavailable else { throw ClientError.storage }
        let folder = directory.appendingPathComponent(Self.folderName(origin: origin.absoluteString, installationID: installationID), isDirectory: true)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        try Self.protect(folder)
        return folder
    }

    func untrackedVideoCount(origin: URL, installationID: UUID) -> Int {
        guard let folder = try? recordingDirectory(origin: origin, installationID: installationID),
              let files = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil) else { return 0 }
        let tracked = Set(matching(origin: origin, installationID: installationID).map { file(for: $0).standardizedFileURL })
        let episodeFolders = Set(matching(origin: origin, installationID: installationID).compactMap { episodeFolder(for: $0)?.standardizedFileURL })
        return files.filter { file in
            (file.pathExtension.lowercased() == "mov" && !tracked.contains(file.standardizedFileURL)) ||
                (file.lastPathComponent.hasPrefix("episode-") && !episodeFolders.contains(file.standardizedFileURL)) ||
                (file.lastPathComponent.hasPrefix("rolling-") && (try? FileManager.default.contentsOfDirectory(atPath: file.path).isEmpty) == false)
        }.count
    }

    /// Called only after server-confirmed revocation and the user's destructive confirmation.
    func removeSession(origin: URL, installationID: UUID) throws {
        guard !storageUnavailable else { throw ClientError.storage }
        let owned = matching(origin: origin, installationID: installationID)
        for capture in owned {
            let url = file(for: capture)
            if FileManager.default.fileExists(atPath: url.path) { try FileManager.default.removeItem(at: url) }
        }
        let folder = try recordingDirectory(origin: origin, installationID: installationID)
        try FileManager.default.removeItem(at: folder)
        try persist(captures.filter { $0.origin != origin.absoluteString || $0.installationID != installationID })
    }

    func record(_ receipt: MediaReceipt, for id: UUID) throws {
        guard let index = captures.firstIndex(where: { $0.id == id }) else { throw ClientError.storage }
        var next = captures
        next[index].receipt = receipt
        next[index].uploadBlocked = nil
        try persist(next)
    }

    func blockUpload(_ message: String, for id: UUID) throws {
        guard let index = captures.firstIndex(where: { $0.id == id }) else { throw ClientError.storage }
        var next = captures
        next[index].uploadBlocked = message
        try persist(next)
    }

    private func persist(_ next: [QueuedCapture]) throws {
        guard !storageUnavailable else { throw ClientError.storage }
        do {
            try JSONEncoder().encode(next).write(to: manifest, options: [.atomic])
            try Self.protect(manifest)
            captures = next
        } catch { throw ClientError.storage }
    }

    private static func safeFilename(_ filename: String) -> Bool {
        !filename.isEmpty && filename != "." && filename != ".." &&
        !filename.contains("/") && !filename.contains("\\") && filename.hasSuffix(".mov")
    }

    private static func safeRelativePath(_ path: String) -> Bool {
        let parts = path.split(separator: "/", omittingEmptySubsequences: false)
        return !path.hasPrefix("/") && !path.contains("\\") && parts.count <= 2 &&
            parts.allSatisfy { !$0.isEmpty && $0 != "." && $0 != ".." } && safeFilename(String(parts.last ?? ""))
    }

    private static func folderName(origin: String, installationID: UUID) -> String {
        let prefix = SHA256.hash(data: Data(origin.utf8)).map { String(format: "%02x", $0) }.joined().prefix(16)
        return "\(prefix)-\(installationID.uuidString.lowercased())"
    }

    private static func validOwnership(_ capture: QueuedCapture) -> Bool {
        if let episode = capture.episodeDirectory {
            return capture.filename == "video.mp4" && capture.relativePath == nil &&
                episode == folderName(origin: capture.origin, installationID: capture.installationID) + "/episode-" + capture.id.uuidString.lowercased()
        }
        let path = capture.relativePath ?? capture.filename
        guard safeFilename(capture.filename), safeRelativePath(path) else { return false }
        // Legacy files are in the queue root; new files must match their recorded owner.
        return path == capture.filename || path == folderName(origin: capture.origin, installationID: capture.installationID) + "/" + capture.filename
    }

    nonisolated static func protect(_ url: URL) throws {
        var mutable = url
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try mutable.setResourceValues(values)
        try FileManager.default.setAttributes([.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication], ofItemAtPath: url.path)
    }
}
