import Combine
import Foundation

struct QueuedCapture: Codable, Identifiable, Equatable {
    let id: UUID
    let filename: String
    let origin: String
    let installationID: UUID
    var receipt: MediaReceipt?
}

@MainActor
final class CaptureQueue: ObservableObject {
    @Published private(set) var captures: [QueuedCapture] = []
    @Published private(set) var storageUnavailable = false
    let directory: URL
    private let manifest: URL

    init(directory: URL? = nil) {
        self.directory = directory ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Captures", isDirectory: true)
        manifest = self.directory.appendingPathComponent("upload-queue.json")
        do {
            try FileManager.default.createDirectory(at: self.directory, withIntermediateDirectories: true)
            if FileManager.default.fileExists(atPath: manifest.path) {
                captures = try JSONDecoder().decode([QueuedCapture].self, from: Data(contentsOf: manifest))
                guard captures.allSatisfy({ Self.safeFilename($0.filename) }) else { throw ClientError.storage }
            }
        } catch {
            // Do not replace a corrupt/unreadable manifest with an empty queue.
            storageUnavailable = true
        }
    }

    func enqueue(file: URL, origin: URL, installationID: UUID) throws {
        guard file.deletingLastPathComponent().standardizedFileURL == directory.standardizedFileURL,
              Self.safeFilename(file.lastPathComponent), FileManager.default.fileExists(atPath: file.path) else {
            throw ClientError.storage
        }
        guard !captures.contains(where: { $0.filename == file.lastPathComponent }) else { return }
        var next = captures
        next.append(QueuedCapture(id: UUID(), filename: file.lastPathComponent,
                                  origin: origin.absoluteString, installationID: installationID))
        try persist(next)
    }

    func matching(origin: URL, installationID: UUID) -> [QueuedCapture] {
        captures.filter { $0.origin == origin.absoluteString && $0.installationID == installationID }
    }

    func file(for capture: QueuedCapture) -> URL { directory.appendingPathComponent(capture.filename) }

    func record(_ receipt: MediaReceipt, for id: UUID) throws {
        guard let index = captures.firstIndex(where: { $0.id == id }) else { throw ClientError.storage }
        var next = captures
        next[index].receipt = receipt
        try persist(next)
    }

    private func persist(_ next: [QueuedCapture]) throws {
        guard !storageUnavailable else { throw ClientError.storage }
        do {
            try JSONEncoder().encode(next).write(to: manifest, options: [.atomic, .completeFileProtection])
            captures = next
        } catch { throw ClientError.storage }
    }

    private static func safeFilename(_ filename: String) -> Bool {
        !filename.isEmpty && filename != "." && filename != ".." &&
        !filename.contains("/") && !filename.contains("\\") && filename.hasSuffix(".mov")
    }
}
