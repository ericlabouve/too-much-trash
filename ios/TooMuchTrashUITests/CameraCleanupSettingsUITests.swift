import XCTest

final class CameraCleanupSettingsUITests: XCTestCase {
    func testCameraSettingsShowFrozenIdentityAndIndependentToggles() {
        let app = XCUIApplication(); app.launchArguments = ["-camera-settings-preview"]; app.launch()
        XCTAssertTrue(app.navigationBars["Camera view"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", "2026-11-27")).firstMatch.exists)
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", "Squeeze, release")).firstMatch.exists)
        let model = app.switches["modelEnabled"], full = app.switches["fullRecordingButtonEnabled"]
        XCTAssertEqual(model.value as? String, "1"); model.coordinate(withNormalizedOffset: CGVector(dx: 0.93, dy: 0.5)).tap()
        XCTAssertTrue(NSPredicate(format: "value == %@", "0").evaluate(with: model))
        XCTAssertEqual(full.value as? String, "1")
        snapshot(app, "Camera configuration")
    }
    func testGeneralCleanupFormNamesSessionAndPreservesExistingRouteChoice() {
        let app = XCUIApplication(); app.launchArguments = ["-cleanup-session-preview"]; app.launch()
        XCTAssertTrue(app.textFields["cleanupName"].waitForExistence(timeout: 10))
        XCTAssertEqual(app.textFields["cleanupName"].value as? String, "Beach cleanup")
        XCTAssertTrue(app.buttons["Mark current location"].exists)
        XCTAssertEqual(app.switches["recordWalkingRoute"].value as? String, "0")
        XCTAssertTrue(app.buttons["Stop cleanup walk"].exists)
        snapshot(app, "Cleanup session details")
    }
    func testNewCleanupMenuShowsDetailsAndRouteBeforeStarting() {
        let app = XCUIApplication(); app.launchArguments = ["-cleanup-session-preview", "-cleanup-preview-empty"]; app.launch()
        XCTAssertTrue(app.textFields["cleanupName"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.textViews["cleanupDescription"].exists || app.textFields["cleanupDescription"].exists)
        XCTAssertTrue(app.switches["recordWalkingRoute"].exists)
        XCTAssertEqual(app.switches["markStartingLocation"].value as? String, "1")
        XCTAssertEqual(app.switches["recordWalkingRoute"].value as? String, "1")
        XCTAssertFalse(app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", "Location and route are shared")).firstMatch.exists)
        XCTAssertTrue(app.buttons["startCleanupWalk"].exists)
        snapshot(app, "New cleanup details before start")
    }
    func testFullRecordingRequiresStartAndConfirmedStopKeepsWalkActive() {
        let app = XCUIApplication(); app.launchArguments = ["-full-recording-preview"]; app.launch()
        let control = app.buttons["fullSessionRecording"]
        XCTAssertTrue(control.waitForExistence(timeout: 10))
        XCTAssertEqual(control.label, "Start Full Session Recording")
        XCTAssertTrue(app.staticTexts["No cleanup walk"].exists)
        control.tap()
        XCTAssertTrue(app.navigationBars["Cleanup session"].waitForExistence(timeout: 5))
        XCTAssertEqual(app.switches["markStartingLocation"].value as? String, "1")
        XCTAssertEqual(app.switches["recordWalkingRoute"].value as? String, "1")
        app.buttons["Cancel"].tap()
        XCTAssertEqual(control.label, "Start Full Session Recording")
        XCTAssertTrue(app.staticTexts["No cleanup walk"].exists)
        control.tap()
        app.buttons["startCleanupWalk"].tap()
        XCTAssertEqual(XCTWaiter.wait(for: [XCTNSPredicateExpectation(predicate: NSPredicate(format: "label == %@", "Stop Full Session Recording"), object: control)], timeout: 5), .completed)
        XCTAssertTrue(app.staticTexts["Cleanup walk active"].exists)
        control.tap()
        XCTAssertTrue(app.alerts["Stop Full Session Recording?"].waitForExistence(timeout: 5))
        app.alerts.buttons["Keep recording"].tap()
        XCTAssertEqual(control.label, "Stop Full Session Recording")
        control.tap(); app.alerts.buttons["Stop recording"].tap()
        XCTAssertEqual(control.label, "Start Full Session Recording")
        XCTAssertTrue(app.staticTexts["Cleanup walk active"].exists)
        control.tap()
        XCTAssertFalse(app.navigationBars["Cleanup session"].exists) // Same walk: no new form.
        XCTAssertEqual(control.label, "Stop Full Session Recording")
        snapshot(app, "Another full recording within the same walk")
    }
    func testDashboardRemainsAccessibleDuringFullRecording() {
        let app = XCUIApplication(); app.launchArguments = ["-recording-dashboard-preview"]; app.launch()
        let dashboard = app.buttons["openDashboard"]
        XCTAssertTrue(dashboard.waitForExistence(timeout: 10))
        XCTAssertTrue(dashboard.isEnabled)
        XCTAssertEqual(app.buttons["fullSessionRecording"].label, "Stop Full Session Recording")
        dashboard.tap()
        XCTAssertTrue(app.navigationBars["Dashboard"].waitForExistence(timeout: 5))
        XCTAssertEqual(app.scrollViews.buttons["fullSessionRecording"].label, "Stop Full Session Recording")
        XCTAssertFalse(app.buttons["endSession"].isEnabled)
        app.buttons["backToCamera"].tap()
        XCTAssertTrue(app.buttons["openDashboard"].waitForExistence(timeout: 5))
        XCTAssertEqual(app.buttons["fullSessionRecording"].label, "Stop Full Session Recording")
    }
    func testMarkedLocationDisplaysReadablePlaceInsteadOfCoordinates() {
        let app = XCUIApplication(); app.launchArguments = ["-cleanup-session-preview", "-cleanup-preview-place"]; app.launch()
        let place = app.staticTexts["cleanupPlaceName"]
        XCTAssertTrue(place.waitForExistence(timeout: 10))
        XCTAssertEqual(XCTWaiter.wait(for: [XCTNSPredicateExpectation(predicate: NSPredicate(format: "label == %@", "Sunset District, San Francisco, CA"), object: place)], timeout: 5), .completed)
        snapshot(app, "Readable cleanup location")
    }
    private func snapshot(_ app: XCUIApplication, _ name: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot()); attachment.name = name; attachment.lifetime = .keepAlways; add(attachment)
    }
}
