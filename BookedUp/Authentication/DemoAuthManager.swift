import SwiftUI
import Combine

/// Portfolio demo only: a single account and a persisted local session.
@MainActor
final class DemoAuthManager: ObservableObject {
    @AppStorage("localDemo.email") private var storedEmail = ""
    @AppStorage("localDemo.isSignedIn") private var storedSession = false
    @Published private(set) var email = ""
    @Published private(set) var isSignedIn = false
    @Published private(set) var startupError: String?

    private let keychain: KeychainPasswordStore
    var hasAccount: Bool { !email.isEmpty }

    init(defaults: UserDefaults, keychain: KeychainPasswordStore) {
        _storedEmail = AppStorage(wrappedValue: "", "localDemo.email", store: defaults)
        _storedSession = AppStorage(wrappedValue: false, "localDemo.isSignedIn", store: defaults)
        self.keychain = keychain
        email = storedEmail
        do {
            if email.isEmpty {
                // Keychain can survive uninstall; a fresh installation has no account.
                try keychain.delete()
                storedSession = false
            } else if try keychain.read() != nil {
                isSignedIn = storedSession
            } else {
                storedSession = false
                startupError = AuthError.missingPassword.localizedDescription
            }
        } catch {
            storedSession = false
            startupError = AuthError.storageUnavailable.localizedDescription
        }
    }

    static func normalisedEmail(_ email: String) -> String {
        email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    static func isValidEmail(_ email: String) -> Bool {
        let value = normalisedEmail(email)
        return value.count <= 254 && value.range(
            of: #"^[A-Z0-9._%+-]+@[A-Z0-9-]+(?:\.[A-Z0-9-]+)+$"#,
            options: [.regularExpression, .caseInsensitive]
        ) != nil
    }

    func createAccount(email input: String, password: String) throws {
        guard Self.isValidEmail(input) else { throw AuthError.invalidEmail }
        guard (8...128).contains(password.count),
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw AuthError.invalidPassword
        }
        guard !hasAccount else { throw AuthError.accountExists }
        do { try keychain.save(password) }
        catch { throw AuthError.storageUnavailable }
        // Publish the account/session only after the secret was saved successfully.
        email = Self.normalisedEmail(input)
        storedEmail = email
        signIn()
    }

    func logIn(email input: String, password: String) throws {
        guard Self.isValidEmail(input) else { throw AuthError.invalidEmail }
        guard !password.isEmpty else { throw AuthError.emptyPassword }
        guard hasAccount else { throw AuthError.noAccount }
        let savedPassword: String?
        do { savedPassword = try keychain.read() }
        catch { throw AuthError.storageUnavailable }
        guard let savedPassword else { throw AuthError.missingPassword }
        guard Self.normalisedEmail(input) == email, password == savedPassword else {
            throw AuthError.incorrectCredentials
        }
        signIn()
    }

    private func signIn() {
        startupError = nil
        storedSession = true
        isSignedIn = true
    }

    func logOut() {
        storedSession = false
        isSignedIn = false
    }

    func resetAccount() throws {
        do { try keychain.delete() }
        catch { throw AuthError.storageUnavailable }
        storedSession = false
        storedEmail = ""
        email = ""
        startupError = nil
        isSignedIn = false
    }

    enum AuthError: LocalizedError {
        case invalidEmail, invalidPassword, emptyPassword, accountExists
        case noAccount, incorrectCredentials, missingPassword, storageUnavailable

        var errorDescription: String? {
            switch self {
            case .invalidEmail: "Enter a valid email address, such as you@example.com."
            case .invalidPassword: "Use a password with 8–128 characters. It can’t contain only spaces."
            case .emptyPassword: "Enter your password."
            case .accountExists: "A demo account already exists on this device. Log in, or reset the local demo account below."
            case .noAccount: "No demo account is saved on this device yet. Create an account to get started."
            case .incorrectCredentials: "The email or password is incorrect. Please try again."
            case .missingPassword: "The saved password is missing. Reset the local demo account below to start again."
            case .storageUnavailable: "Your password couldn’t be accessed securely. Please unlock your device and try again."
            }
        }
    }

}
