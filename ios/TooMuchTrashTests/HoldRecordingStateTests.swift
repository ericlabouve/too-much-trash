import XCTest
@testable import TooMuchTrash

final class HoldRecordingStateTests: XCTestCase {
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
