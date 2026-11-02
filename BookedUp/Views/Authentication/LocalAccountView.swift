import SwiftUI

struct LocalAccountView: View {
    @ObservedObject var auth: DemoAuthManager
    let onLogOut: () -> Void
    let onReset: () throws -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Your demo account")
                        .bookedUpText(.pageTitle)
                        .accessibilityAddTraits(.isHeader)
                    Text(auth.email)
                        .bookedUpText(.body)
                        .textSelection(.enabled)
                        .accessibilityIdentifier("account.email")
                    Text("This account is saved only on this device. Logging out keeps the account so you can log back in.")
                        .bookedUpText(.body)
                        .foregroundStyle(AppColor.secondaryText)
                    PrimaryButton(title: "Log out", action: onLogOut)
                        .accessibilityIdentifier("account.logOut")
                    DemoResetButton(onReset: onReset)
                    NavigationLink("Playfair Display font licence") {
                        ScrollView {
                            Text(fontLicence)
                                .bookedUpText(.caption)
                                .padding()
                        }
                        .background(AppColor.background)
                        .navigationTitle("Font licence")
                    }
                    .bookedUpText(.secondaryBody)
                }
                .padding(20)
            }
            .background(AppColor.background)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    private var fontLicence: String {
        guard let url = Bundle.main.url(forResource: "PlayfairDisplay-OFL", withExtension: "txt"),
              let text = try? String(contentsOf: url, encoding: .utf8) else {
            return "Playfair Display is licensed under the SIL Open Font License 1.1. See the bundled PlayfairDisplay-OFL.txt."
        }
        return text
    }
}
