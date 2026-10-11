import XCTest

final class CameraLaunchTests: XCTestCase {
    func testRegistrationAcceptsReadableInviteWordsWithoutSubmitting() {
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "http://localhost:18082",
                               "-privateAdminOrigin", "http://localhost:18081", "-simulatorLocalBackend", "YES",
                               "-adminNetworkCollectorOrigin", "", "-adminNetworkPrivateOrigin", ""]
        app.launch()
        XCTAssertTrue(app.buttons["registerButton"].waitForExistence(timeout: 10))
        app.buttons["registerButton"].tap()
        let words = app.textFields["inviteCode"]
        XCTAssertTrue(words.waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["Register this iPhone"].isEnabled)
        words.tap()
        words.typeText("abandon ability")
        XCTAssertEqual(words.value as? String, "abandon ability")
        XCTAssertTrue(app.buttons["Register this iPhone"].isEnabled)
        // Dummy words only. Never consume a live invite in a UI test.
    }

    func testConnectedAdminLocalToggleKeepsMenuAndBothAddresses() throws {
        let app = XCUIApplication()
        app.launch()
        guard app.buttons["serverAddresses"].waitForExistence(timeout: 10) else {
            throw XCTSkip("Requires the configured private Tailscale admin endpoint to be reachable.")
        }
        app.buttons["serverAddresses"].tap()
        let toggle = app.switches["simulatorLocalBackend"]
        if toggle.value as? String == "1" { toggle.tap() }
        toggle.tap()
        let collector = app.descendants(matching: .any).matching(identifier: "publicServerURL").firstMatch
        let admin = app.descendants(matching: .any).matching(identifier: "privateAdminURL").firstMatch
        XCTAssertEqual(collector.value as? String, "http://localhost:18082")
        XCTAssertEqual(admin.value as? String, "http://localhost:18081")
        XCTAssertTrue(app.navigationBars["Server addresses"].exists)
        app.buttons["Cancel"].tap()
    }

    func testDisconnectedUserViewHidesAdminMenusAndSurvivesRelaunch() {
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "", "-privateAdminOrigin", "",
                               "-simulatorLocalBackend", "NO", "-adminNetworkCollectorOrigin", "",
                               "-adminNetworkPrivateOrigin", ""]
        app.launch()
        XCTAssertTrue(app.buttons["continueButton"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.buttons["registerButton"].exists)
        XCTAssertFalse(app.buttons["adminLogin"].exists)
        XCTAssertFalse(app.buttons["serverAddresses"].exists)
        XCTAssertFalse(app.buttons["recordButton"].exists)
        XCTAssertTrue(app.staticTexts["collectorViewStatus"].exists)
        app.terminate()
        app.launch()
        XCTAssertTrue(app.buttons["continueButton"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.buttons["serverAddresses"].exists)
    }

    func testLocalAdminDoesNotExposeNetworkAdminMenus() {
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "http://localhost:18082",
                               "-privateAdminOrigin", "http://localhost:18081", "-simulatorLocalBackend", "YES",
                               "-adminNetworkCollectorOrigin", "", "-adminNetworkPrivateOrigin", ""]
        app.launch()
        XCTAssertTrue(app.buttons["registerButton"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.buttons["adminLogin"].exists)
        XCTAssertFalse(app.buttons["serverAddresses"].exists)
    }
}
