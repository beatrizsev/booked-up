import XCTest

@MainActor
final class AuthenticationFlowTests: XCTestCase {
    private var app: XCUIApplication!
    private let email = "reader@example.com"
    private let password = "Portfolio123!"

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication(bundleIdentifier: "bea.BookedUp")
        app.terminate()
        app.launchArguments = ["--ui-testing", "--reset-ui-tests"]
        app.launch()
    }

    func testOnboardingAccountAndSessionLifecycle() {
        XCTAssertTrue(app.staticTexts["A calmer way\nto read"].waitForExistence(timeout: 10))
        app.swipeLeft()
        XCTAssertTrue(app.staticTexts["Every page\nhas a story"].isHittable)
        capture("02 Original journal illustration")
        app.swipeRight()
        XCTAssertTrue(app.staticTexts["A calmer way\nto read"].isHittable)
        capture("01 Original reading illustration")
        app.buttons["onboarding.getStarted"].tap()
        XCTAssertEqual(app.staticTexts["auth.title"].label, "Create your account")
        capture("03 Create account")
        enterCredentials(email: "  Reader@Example.com  ", password: password)
        app.buttons["auth.submit"].tap()
        assertHome()

        // A genuine process restart must restore the persisted session.
        relaunchWithoutReset()
        assertHome()
        capture("04 Home after session restore")
        logOut()
        XCTAssertTrue(app.staticTexts["Welcome back"].waitForExistence(timeout: 5))
        relaunchWithoutReset()
        XCTAssertTrue(app.staticTexts["Welcome back"].waitForExistence(timeout: 5))
        XCTAssertEqual(app.textFields["auth.email"].value as? String, email)

        replacePassword(with: "WrongPassword!")
        app.buttons["auth.submit"].tap()
        XCTAssertTrue(app.staticTexts["auth.error"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["auth.error"].label.contains("incorrect"))
        XCTAssertFalse(app.buttons["home.account"].exists)
        capture("05 Incorrect password")

        replacePassword(with: password)
        app.buttons["auth.submit"].tap()
        assertHome()
        logOut()
        XCTAssertTrue(app.staticTexts["Welcome back"].waitForExistence(timeout: 5))
    }

    func testHiddenPasswordEntryAndSignedOutReset() {
        app.buttons["onboarding.getStarted"].tap()
        replace(app.textFields["auth.email"], with: email)
        let field = app.secureTextFields["auth.password"]
        field.tap()
        let hiddenPassword = "readingtogether"
        field.typeText(hiddenPassword)
        XCTAssertNotEqual(field.value as? String, hiddenPassword)
        app.buttons["auth.submit"].tap()
        assertHome()
        logOut()
        let loginPassword = app.secureTextFields["auth.password"]
        loginPassword.tap()
        loginPassword.typeText(hiddenPassword)
        app.buttons["auth.submit"].tap()
        assertHome()
        logOut()
        capture("08 Log In")
        app.buttons["demo.reset"].tap()
        if app.buttons["Cancel"].exists {
            app.buttons["Cancel"].tap()
        } else {
            // iOS 26 presents this confirmation as an anchored popover.
            app.otherElements["PopoverDismissRegion"].tap()
        }
        XCTAssertTrue(app.staticTexts["Welcome back"].exists)
        app.buttons["demo.reset"].tap()
        app.buttons["Reset demo"].tap()
        XCTAssertTrue(app.staticTexts["A calmer way\nto read"].waitForExistence(timeout: 5))
        relaunchWithoutReset()
        XCTAssertTrue(app.staticTexts["A calmer way\nto read"].waitForExistence(timeout: 5))
    }

    func testValidationSingleAccountAndReset() {
        app.buttons["onboarding.getStarted"].tap()
        enterCredentials(email: "not-an-email", password: password)
        app.buttons["auth.submit"].tap()
        XCTAssertTrue(app.staticTexts["auth.error"].label.contains("valid email"))
        enterCredentials(email: email, password: "short")
        app.buttons["auth.submit"].tap()
        XCTAssertTrue(app.staticTexts["auth.error"].label.contains("8–128"))
        replacePassword(with: "        ")
        app.buttons["auth.submit"].tap()
        XCTAssertTrue(app.staticTexts["auth.error"].label.contains("only spaces"))
        replacePassword(with: password)
        app.buttons["auth.submit"].tap()
        assertHome()
        logOut()

        app.buttons["auth.switchMode"].tap()
        enterCredentials(email: "another@example.com", password: "AnotherPassword!")
        app.buttons["auth.submit"].tap()
        XCTAssertTrue(app.staticTexts["auth.error"].label.contains("already exists"))
        app.buttons["auth.switchMode"].tap()
        enterCredentials(email: email, password: password)
        app.buttons["auth.submit"].tap()
        assertHome() // The duplicate attempt did not overwrite the original account.

        app.buttons["home.account"].tap()
        app.buttons["demo.reset"].tap()
        app.buttons["Reset demo"].tap()
        XCTAssertTrue(app.staticTexts["A calmer way\nto read"].waitForExistence(timeout: 5))
        relaunchWithoutReset()
        XCTAssertTrue(app.staticTexts["A calmer way\nto read"].waitForExistence(timeout: 5))
        app.buttons["onboarding.logIn"].tap()
        enterCredentials(email: email, password: password)
        app.buttons["auth.submit"].tap()
        XCTAssertTrue(app.staticTexts["auth.error"].label.contains("No demo account"))
        app.buttons["auth.switchMode"].tap()
        enterCredentials(email: email, password: password)
        app.buttons["auth.submit"].tap()
        assertHome() // Reset cleared the Keychain item too; creating again succeeds.
    }

    func testNavigationAndTruthfulRecoveryPreview() {
        app.buttons["onboarding.logIn"].tap()
        XCTAssertTrue(app.staticTexts["Welcome back"].waitForExistence(timeout: 5))
        app.buttons["Back to welcome"].tap()
        XCTAssertTrue(app.staticTexts["A calmer way\nto read"].isHittable)
        app.buttons["onboarding.getStarted"].tap()
        enterCredentials(email: email, password: password)
        app.buttons["auth.submit"].tap()
        assertHome()
        logOut()

        app.buttons["Forgot password?"].tap()
        XCTAssertTrue(app.staticTexts["Reset your password"].waitForExistence(timeout: 5))
        capture("06 Demo password recovery")
        app.buttons["Cancel"].tap()
        app.buttons["Forgot password?"].tap()
        replace(app.textFields["recovery.email"], with: "invalid")
        app.buttons["recovery.submit"].tap()
        XCTAssertTrue(app.staticTexts["recovery.error"].label.contains("valid email"))
        replace(app.textFields["recovery.email"], with: email)
        app.buttons["recovery.submit"].tap()
        XCTAssertTrue(app.staticTexts["Check your inbox"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Demo preview · No email is sent"].exists)
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", "No recovery email was sent")).firstMatch.exists)
        capture("07 Truthful inbox preview")
        app.buttons["recovery.submit"].tap()
        XCTAssertTrue(app.staticTexts["Welcome back"].waitForExistence(timeout: 5))
        enterCredentials(email: email, password: password)
        app.buttons["auth.submit"].tap()
        assertHome() // Recovery preview never changes the saved password.
    }

    private func replacePassword(with value: String) {
        let show = app.buttons["Show password"]
        if show.exists { show.tap() }
        let field = app.textFields["auth.password"]
        replace(field, with: value)
        XCTAssertEqual(field.value as? String, value)
        app.buttons["Hide password"].tap()
        XCTAssertTrue(app.secureTextFields["auth.password"].exists)
    }

    private func replace(_ field: XCUIElement, with value: String) {
        XCTAssertTrue(field.waitForExistence(timeout: 5))
        field.tap()
        if let existing = field.value as? String,
           existing != field.placeholderValue, !existing.isEmpty {
            field.typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: existing.count))
        }
        field.typeText(value)
    }

    private func enterCredentials(email: String, password: String) {
        replace(app.textFields["auth.email"], with: email)
        replacePassword(with: password)
    }

    private func assertHome() {
        let reachedHome = app.buttons["home.account"].waitForExistence(timeout: 8)
        let failure = app.staticTexts["auth.error"]
        XCTAssertTrue(reachedHome, failure.exists ? failure.label : "Home was not shown")
        XCTAssertTrue(app.staticTexts["Currently Reading"].exists)
    }

    private func logOut() {
        app.buttons["home.account"].tap()
        XCTAssertTrue(app.staticTexts["account.email"].waitForExistence(timeout: 5))
        XCTAssertEqual(app.staticTexts["account.email"].label, email)
        app.buttons["account.logOut"].tap()
    }

    private func relaunchWithoutReset() {
        app.terminate()
        app.launchArguments = ["--ui-testing"]
        app.launch()
    }

    private func capture(_ name: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
