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
                      Set(captures.map { $0.relativePath ?? $0.filename }).count == captures.count else { throw ClientError.storage }
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

    func file(for capture: QueuedCapture) -> URL { directory.appendingPathComponent(capture.relativePath ?? capture.filename) }

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
        return files.filter { $0.pathExtension.lowercased() == "mov" && !tracked.contains($0.standardizedFileURL) }.count
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
