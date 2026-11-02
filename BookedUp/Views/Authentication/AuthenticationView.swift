import SwiftUI

struct AuthenticationView: View {
    enum Mode: Equatable { case createAccount, logIn }

    @ObservedObject var auth: DemoAuthManager
    @Binding var mode: Mode
    let onBack: () -> Void
    let onReset: () throws -> Void
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var showRecovery = false

    private var isCreating: Bool { mode == .createAccount }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                VStack(spacing: 4) {
                    BrandLogo().frame(maxWidth: .infinity)
                    HStack {
                        Button(action: onBack) {
                            Image(systemName: "arrow.left")
                                .frame(width: 44, height: 44)
                        }
                        .accessibilityLabel("Back to welcome")
                        Spacer()
                    }
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text(isCreating ? "Create your account" : "Welcome back")
                        .bookedUpText(.pageTitle)
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityIdentifier("auth.title")
                    Text(isCreating
                         ? "Keep your books, notes and reading progress in one place."
                         : "Your books and notes are waiting right where you left them.")
                        .bookedUpText(.body)
                        .lineSpacing(4)
                        .foregroundStyle(AppColor.secondaryText)
                }

                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email").bookedUpText(.bookTitle)
                        AccountEmailField(email: $email)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password").bookedUpText(.bookTitle)
                        AccountPasswordField(password: $password, isCreating: isCreating)
                        if isCreating {
                            Text("At least 8 characters.")
                                .bookedUpText(.caption)
                                .foregroundStyle(AppColor.secondaryText)
                        } else {
                            Button("Forgot password?") { showRecovery = true }
                                .bookedUpText(.secondaryBody)
                                .foregroundStyle(AppColor.secondaryText)
                                .frame(maxWidth: .infinity, minHeight: 44, alignment: .trailing)
                        }
                    }
                    if let message = errorMessage ?? auth.startupError {
                        Text(message)
                            .bookedUpText(.secondaryBody)
                            .foregroundStyle(AppColor.primaryText)
                            .accessibilityIdentifier("auth.error")
                    }
                }
                .onSubmit(submit)

                VStack(spacing: 12) {
                    PrimaryButton(title: isCreating ? "Create account" : "Log in", action: submit)
                        .accessibilityIdentifier("auth.submit")
                    Button {
                        mode = isCreating ? .logIn : .createAccount
                    } label: {
                        Text("\(isCreating ? "Already have an account?" : "New to booked up?") \(Text(isCreating ? "Log in" : "Create account").bold())")
                        .bookedUpText(.secondaryBody)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    .accessibilityIdentifier("auth.switchMode")

                    Text("Local demo · Your account stays on this device.")
                        .bookedUpText(.caption)
                        .foregroundStyle(AppColor.secondaryText)
                        .multilineTextAlignment(.center)
                    if auth.hasAccount {
                        DemoResetButton(onReset: onReset)
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: 480)
            .frame(maxWidth: .infinity)
        }
        .background(AppColor.background)
        .scrollDismissesKeyboard(.interactively)
        .onAppear { if !isCreating { email = auth.email } }
        .onChange(of: mode) {
            password = ""
            email = isCreating ? "" : auth.email
            errorMessage = nil
        }
        .sheet(isPresented: $showRecovery) {
            PasswordRecoveryView(email: email)
        }
    }

    private func submit() {
        do {
            if isCreating { try auth.createAccount(email: email, password: password) }
            else { try auth.logIn(email: email, password: password) }
            password = ""
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
