import XCTest
import UIKit

final class CameraLaunchTests: XCTestCase {
    func testPastingWholeInvitePhraseIntoFirstWord() {
        let savedClipboard = UIPasteboard.general.items
        defer { UIPasteboard.general.items = savedClipboard }
        UIPasteboard.general.string = "abandon ability"
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "http://localhost:18082",
                               "-privateAdminOrigin", "http://localhost:18081", "-simulatorLocalBackend", "YES",
                               "-adminNetworkCollectorOrigin", "", "-adminNetworkPrivateOrigin", ""]
        app.launch()
        XCTAssertTrue(app.buttons["registerButton"].waitForExistence(timeout: 10))
        app.buttons["registerButton"].tap()
        let first = app.textFields["inviteWord1"]
        XCTAssertTrue(first.waitForExistence(timeout: 5))
        first.tap()
        first.press(forDuration: 1)
        let paste = app.descendants(matching: .any).matching(NSPredicate(format: "label == 'Paste'")).firstMatch
        XCTAssertTrue(paste.waitForExistence(timeout: 5))
        paste.tap()
        let allowPaste = app.buttons["Allow Paste"]
        if allowPaste.waitForExistence(timeout: 2) { allowPaste.tap() }
        XCTAssertEqual(first.value as? String, "abandon")
        XCTAssertEqual(app.textFields["inviteWord2"].value as? String, "ability")
        XCTAssertTrue(app.buttons["submitRegistration"].isEnabled)
        XCTAssertFalse(app.staticTexts["registrationMessage"].exists)
    }

    func testRegistrationAcceptsReadableInviteWordsWithoutSubmitting() {
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "http://localhost:18082",
                               "-privateAdminOrigin", "http://localhost:18081", "-simulatorLocalBackend", "YES",
                               "-adminNetworkCollectorOrigin", "", "-adminNetworkPrivateOrigin", ""]
        app.launch()
        XCTAssertTrue(app.buttons["registerButton"].waitForExistence(timeout: 10))
        app.buttons["registerButton"].tap()
        let first = app.textFields["inviteWord1"]
        let second = app.textFields["inviteWord2"]
        let register = app.buttons["submitRegistration"]
        XCTAssertTrue(first.waitForExistence(timeout: 5))
        XCTAssertFalse(register.isEnabled)
        XCTAssertFalse(app.staticTexts["registrationMessage"].exists)
        XCTAssertEqual(register.label, "Register")
        XCTAssertTrue(app.staticTexts["Enter the two word invite phrase above"].exists)
        XCTAssertFalse(app.textFields["installationName"].exists)
        XCTAssertFalse(app.buttons["inviteEntryMode"].exists)
        XCTAssertFalse(app.textFields["inviteCode"].exists)
        first.tap()
        first.typeText("abandon ability")
        XCTAssertEqual(first.value as? String, "abandon")
        XCTAssertEqual(second.value as? String, "ability")
        XCTAssertTrue(register.isEnabled)
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
