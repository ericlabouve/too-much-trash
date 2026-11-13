import XCTest
@testable import TooMuchTrash

final class WatchScoreTests: XCTestCase {
    func testScoreSurvivesRetentionAndUndoIsScoped() throws {
        let suite = "watch-score-test-" + UUID().uuidString
        let defaults = try XCTUnwrap(UserDefaults(suiteName: suite))
        defer { defaults.removePersistentDomain(forName: suite) }
        let first = UUID(), second = UUID()
        let score = WatchScore(defaults: defaults, key: "owner-a")
        XCTAssertEqual(score.observe([first, second]), 2)
        XCTAssertEqual(score.observe([second]), 2)
        XCTAssertEqual(score.observe([second, second]), 2)
        score.undo(second)
        XCTAssertEqual(score.observe([]), 1)
        XCTAssertEqual(WatchScore(defaults: defaults, key: "owner-b").observe([second]), 1)
    }
}
