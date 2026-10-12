import XCTest
@testable import TooMuchTrash

final class InviteWordEntryTests: XCTestCase {
    func testWholePhrasePastedIntoEitherBox() {
        for field in [InviteWordEntry.Field.first, .second] {
            var entry = InviteWordEntry(first: "old", second: "value")
            XCTAssertTrue(entry.update(" \n Abandon\t\u{00a0}ABILITY  ", field: field))
            XCTAssertEqual(entry.first, "Abandon")
            XCTAssertEqual(entry.second, "ABILITY")
            XCTAssertEqual(entry.code, "Abandon ABILITY")
            XCTAssertTrue(entry.isComplete)
        }
    }

    func testIndividualWordsAndRepeatedWords() {
        var entry = InviteWordEntry()
        XCTAssertFalse(entry.isComplete)
        entry.update("abandon", field: .first)
        XCTAssertFalse(entry.isComplete)
        entry.update("abandon", field: .second)
        XCTAssertTrue(entry.isComplete)
        XCTAssertEqual(entry.code, "abandon abandon")
        entry.update("", field: .first)
        XCTAssertFalse(entry.isComplete)
    }

    func testExtraWordsAreNotSilentlyDiscarded() {
        var entry = InviteWordEntry(first: "abandon", second: "ability")
        XCTAssertFalse(entry.update("abandon ability able", field: .second))
        XCTAssertEqual(entry.second, "abandon ability able")
        XCTAssertFalse(entry.isComplete)
        entry.update("able", field: .second)
        XCTAssertTrue(entry.isComplete)
    }

    func testWhitespaceAndOversizedEntriesDoNotEnableRegistration() {
        var entry = InviteWordEntry(first: " \n", second: "ability")
        XCTAssertFalse(entry.isComplete)
        entry.update(String(repeating: "a", count: 256), field: .first)
        XCTAssertFalse(entry.isComplete)
    }
}
