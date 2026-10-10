import XCTest

final class CameraLaunchTests: XCTestCase {
    func testNoCredentialOpensHomeAndSurvivesRelaunch() {
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "", "-privateAdminOrigin", ""]
        app.launch()
        XCTAssertTrue(app.buttons["continueButton"].waitForExistence(timeout: 10))
        XCTAssertTrue(app.buttons["registerButton"].exists)
        XCTAssertFalse(app.buttons["adminLogin"].exists)
        XCTAssertFalse(app.buttons["recordButton"].exists)
        app.terminate()
        app.launch()
        XCTAssertTrue(app.buttons["continueButton"].waitForExistence(timeout: 10))
    }

    func testUnsafeServerAddressIsRejected() {
        let app = XCUIApplication()
        app.launchArguments = ["-collectorPublicOrigin", "", "-privateAdminOrigin", ""]
        app.launch()
        app.buttons["serverAddresses"].tap()
        let input = app.textFields["publicServerURL"]
        XCTAssertTrue(input.waitForExistence(timeout: 5))
        input.tap()
        input.typeText("http://example.test")
        app.buttons["Save addresses"].tap()
        XCTAssertTrue(app.staticTexts["configurationError"].waitForExistence(timeout: 5))
    }
}
