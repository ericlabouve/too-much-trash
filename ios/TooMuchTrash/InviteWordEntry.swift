import Foundation

/// Presentation-only parsing. The backend still validates and normalizes invite words.
struct InviteWordEntry {
    enum Field: Hashable { case first, second }
    var first = ""
    var second = ""

    var isComplete: Bool {
        [first, second].allSatisfy { $0.split(whereSeparator: { $0.isWhitespace }).count == 1 }
            && code.count <= 256
    }

    var code: String {
        [first, second].map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.joined(separator: " ")
    }

    /// Returns true when a whole phrase was distributed between the two boxes.
    @discardableResult
    mutating func update(_ value: String, field: Field) -> Bool {
        let words = value.split(whereSeparator: { $0.isWhitespace })
        if words.count == 2 {
            first = String(words[0])
            second = String(words[1])
            return true
        }
        // Preserve invalid multiword input so it can be corrected, never silently truncate.
        if field == .first { first = value } else { second = value }
        return false
    }
}
