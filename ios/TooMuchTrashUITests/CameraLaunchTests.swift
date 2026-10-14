import XCTest
import UIKit

final class CameraLaunchTests: XCTestCase {
    func testLocalSessionVisualVerificationWithoutRevocation() throws {
        let app = XCUIApplication()
        // Launch-only overrides: never persist a server switch or move credentials.
        app.launchArguments = ["-collectorPublicOrigin", "http://localhost:18082",
                               "-privateAdminOrigin", "http://localhost:18081",
                               "-simulatorLocalBackend", "YES"]
        app.launch()
        guard app.buttons["openDashboard"].waitForExistence(timeout: 10) else {
            throw XCTSkip("Requires an existing approved localhost installation; never mint or bypass auth here.")
        }
        XCTAssertFalse(app.buttons["adminMenu"].exists)
        XCTAssertEqual(app.staticTexts["cameraStatus"].label, "No camera available. Use an iPhone to record.")
        saveVisual(app, name: "Verified camera")
        app.buttons["openDashboard"].tap()
        XCTAssertTrue(app.navigationBars["Dashboard"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["backToCamera"].exists)
        _ = app.buttons["adminMenu"].waitForExistence(timeout: 5)
        saveVisual(app, name: "Verified dashboard")
        app.buttons["endSession"].tap()
        XCTAssertTrue(app.alerts["End session?"].waitForExistence(timeout: 5))
        saveVisual(app, name: "Verified End confirmation")
        let cancel = app.alerts.buttons["Cancel"].exists ? app.alerts.buttons["Cancel"] : app.alerts.buttons["Keep uploading"]
        cancel.tap()
        app.buttons["backToCamera"].tap()
        XCTAssertTrue(app.buttons["openDashboard"].waitForExistence(timeout: 5))
    }

    private func saveVisual(_ app: XCUIApplication, name: String) {
        let image = XCTAttachment(screenshot: app.screenshot())
        image.name = name
        image.lifetime = .keepAlways
        add(image)
    }

    func testRegisteredCameraDashboardAndEndConfirmationWithoutRevocation() throws {
        let app = XCUIApplication()
        app.launch()
        guard app.buttons["openDashboard"].waitForExistence(timeout: 10) else {
            throw XCTSkip("Requires an existing authorized installation; never mint one or bypass auth in a UI test.")
        }
        XCTAssertFalse(app.buttons["adminMenu"].exists)
        XCTAssertFalse(app.staticTexts["Hold either volume button to record\nRelease to save · Video only"].exists)
        app.buttons["openDashboard"].tap()
        XCTAssertTrue(app.navigationBars["Dashboard"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["backToCamera"].exists)
        let end = app.buttons["endSession"]
        XCTAssertTrue(end.isEnabled)
        end.tap()
        XCTAssertTrue(app.alerts["End session?"].waitForExistence(timeout: 5))
        let cancel = app.alerts.buttons["Cancel"].exists ? app.alerts.buttons["Cancel"] : app.alerts.buttons["Keep uploading"]
        cancel.tap()
        XCTAssertTrue(app.buttons["backToCamera"].exists)
        app.buttons["backToCamera"].tap()
        XCTAssertTrue(app.buttons["openDashboard"].waitForExistence(timeout: 5))
        // Never confirm destructive End on the user's live installation.
    }

    func testPastingWholeInvitePhraseIntoFirstWord() {
        let savedClipboard = UIPasteboard.general.items
        defer { UIPasteboard.general.items = savedClipboard }
        UIPasteboard.general.string = "abandon ability"
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "http://localhost:18083", "-disableLocalFallback", "YES",
                               "-privateAdminOrigin", "http://localhost:18081", "-simulatorLocalBackend", "YES",
                               "-adminNetworkCollectorOrigin", "", "-adminNetworkPrivateOrigin", ""]
        app.launch()
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
        app.launchArguments = ["-collectorPublicOrigin", "http://localhost:18083", "-disableLocalFallback", "YES",
                               "-privateAdminOrigin", "http://localhost:18081", "-simulatorLocalBackend", "YES",
                               "-adminNetworkCollectorOrigin", "", "-adminNetworkPrivateOrigin", ""]
        app.launch()
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
        if app.buttons["openDashboard"].waitForExistence(timeout: 3) { app.buttons["openDashboard"].tap() }
        guard app.buttons["adminMenu"].waitForExistence(timeout: 10) else {
            throw XCTSkip("Requires the configured private Tailscale admin endpoint to be reachable.")
        }
        app.buttons["adminMenu"].tap()
        app.buttons["serverAddresses"].tap()
        let toggle = app.switches["simulatorLocalBackend"]
        if toggle.value as? String == "1" { toggle.tap() }
        toggle.tap()
        let collector = app.descendants(matching: .any).matching(identifier: "publicServerURL").firstMatch
        let admin = app.descendants(matching: .any).matching(identifier: "privateAdminURL").firstMatch
        XCTAssertEqual(collector.value as? String, "http://localhost:8082")
        XCTAssertTrue((admin.value as? String)?.hasPrefix("https://") == true)
        XCTAssertTrue(app.navigationBars["Server addresses"].exists)
        app.buttons["Cancel"].tap()
    }

    func testDisconnectedUserViewHidesAdminMenusAndSurvivesRelaunch() {
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "http://localhost:18083", "-disableLocalFallback", "YES", "-privateAdminOrigin", "",
                               "-simulatorLocalBackend", "YES", "-adminNetworkCollectorOrigin", "",
                               "-adminNetworkPrivateOrigin", ""]
        app.launch()
        XCTAssertTrue(app.textFields["inviteWord1"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.buttons["continueButton"].exists)
        XCTAssertFalse(app.buttons["adminLogin"].exists)
        XCTAssertFalse(app.buttons["serverAddresses"].exists)
        XCTAssertFalse(app.buttons["recordButton"].exists)
        app.terminate()
        app.launch()
        XCTAssertTrue(app.textFields["inviteWord1"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.buttons["serverAddresses"].exists)
    }

    func testLocalAdminDoesNotExposeNetworkAdminMenus() {
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "http://localhost:18083", "-disableLocalFallback", "YES",
                               "-privateAdminOrigin", "http://localhost:18081", "-simulatorLocalBackend", "YES",
                               "-adminNetworkCollectorOrigin", "", "-adminNetworkPrivateOrigin", ""]
        app.launch()
        XCTAssertTrue(app.textFields["inviteWord1"].waitForExistence(timeout: 10))
        XCTAssertFalse(app.buttons["adminLogin"].exists)
        XCTAssertFalse(app.buttons["serverAddresses"].exists)
    }
}
