import XCTest
@testable import TooMuchTrash

@MainActor final class OperationDeadlineTests: XCTestCase {
    func testReturnsEvenWhenOperationIgnoresCancellationAndDiscardsLateReply() async throws {
        var continuation: CheckedContinuation<Int, Never>?
        let start = Date()
        do {
            let _: Int = try await OperationDeadline.run(seconds: 0.02) {
                await withCheckedContinuation { continuation = $0 }
            }
            XCTFail("Expected timeout")
        } catch { XCTAssertEqual((error as? URLError)?.code, .timedOut) }
        XCTAssertLessThan(Date().timeIntervalSince(start), 1)
        try XCTUnwrap(continuation).resume(returning: 42)
        for _ in 0..<5 { await Task.yield() }
    }
    func testReturnsSuccessfulResult() async throws {
        let result = try await OperationDeadline.run(seconds: 1) { 42 }
        XCTAssertEqual(result, 42)
    }
}
