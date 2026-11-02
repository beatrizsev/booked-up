import SwiftUI

struct AppRootView: View {
    @StateObject private var auth: DemoAuthManager
    @AppStorage("onboardingCompleted") private var hasOnboarded = false
    @State private var mode: AuthenticationView.Mode = .logIn
    @State private var replayWelcome = false
    @State private var showAccount = false

    init() {
        let configuration = DemoStorage.configuration
        _hasOnboarded = AppStorage(wrappedValue: false, "onboardingCompleted", store: configuration.defaults)
        _auth = StateObject(wrappedValue: DemoAuthManager(
            defaults: configuration.defaults,
            keychain: KeychainPasswordStore(service: configuration.service)
        ))
    }

    var body: some View {
        Group {
            if auth.isSignedIn {
                ContentView(onAccount: { showAccount = true })
            } else if !hasOnboarded || replayWelcome {
                OnboardingView { destination in
                    mode = destination
                    hasOnboarded = true
                    replayWelcome = false
                }
            } else {
                AuthenticationView(
                    auth: auth,
                    mode: $mode,
                    onBack: { replayWelcome = true },
                    onReset: resetDemo
                )
            }
        }
        .foregroundStyle(AppColor.primaryText)
        .tint(AppColor.primaryText)
        .background(AppColor.background)
        .preferredColorScheme(.light)
        .sheet(isPresented: $showAccount) {
            LocalAccountView(auth: auth, onLogOut: {
                showAccount = false
                mode = .logIn
                auth.logOut()
            }, onReset: resetDemo)
        }
    }

    private func resetDemo() throws {
        try auth.resetAccount()
        showAccount = false
        replayWelcome = false
        hasOnboarded = false
        mode = .createAccount
    }
}

private enum DemoStorage {
    /// Evaluated once per process, rather than resetting test state in a View initializer.
    static let configuration: (defaults: UserDefaults, service: String) = {
        var defaults = UserDefaults.standard
        var service = "\(Bundle.main.bundleIdentifier ?? "bea.BookedUp").local-demo"
        #if DEBUG
        // UI tests use an isolated account and defaults suite, never the reader’s demo.
        if ProcessInfo.processInfo.arguments.contains("--ui-testing") {
            let suite = "bea.BookedUp.ui-tests"
            defaults = UserDefaults(suiteName: suite)!
            service += ".ui-tests"
            if ProcessInfo.processInfo.arguments.contains("--reset-ui-tests") {
                defaults.removePersistentDomain(forName: suite)
                try? KeychainPasswordStore(service: service).delete()
            }
        }
        #endif
        return (defaults, service)
    }()
}
