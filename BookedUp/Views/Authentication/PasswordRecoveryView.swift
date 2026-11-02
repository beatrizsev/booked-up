import SwiftUI

/// A truthful prototype of the two Figma recovery modals, without email or reset tokens.
struct PasswordRecoveryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dynamicTypeSize) private var typeSize
    @State var email: String
    @State private var isPreviewingInbox = false
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(isPreviewingInbox ? "Check your inbox" : "Reset your password")
                        .bookedUpText(.sectionHeading)
                        .accessibilityAddTraits(.isHeader)
                    Text("Demo preview · No email is sent")
                        .bookedUpText(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(AppColor.secondaryText)
                    Text(isPreviewingInbox
                         ? "This is a preview only. No recovery email was sent and your password is unchanged. If you’ve forgotten it, use Reset local demo account on Log In."
                         : "Enter an email to preview the recovery flow. This local demo won’t send an email or change your password.")
                        .bookedUpText(.secondaryBody)
                        .foregroundStyle(AppColor.secondaryText)
                }
                if !isPreviewingInbox {
                    AccountEmailField(email: $email, identifier: "recovery.email")
                    if let errorMessage {
                        Text(errorMessage)
                            .bookedUpText(.secondaryBody)
                            .accessibilityIdentifier("recovery.error")
                    }
                }
                PrimaryButton(title: isPreviewingInbox ? "Back to log in" : "Preview reset link") {
                    if isPreviewingInbox { dismiss() }
                    else if DemoAuthManager.isValidEmail(email) {
                        errorMessage = nil
                        isPreviewingInbox = true
                    } else {
                        errorMessage = DemoAuthManager.AuthError.invalidEmail.localizedDescription
                    }
                }
                .accessibilityIdentifier("recovery.submit")
                Button(isPreviewingInbox ? "Close" : "Cancel") { dismiss() }
                    .bookedUpText(.secondaryBody)
                    .frame(minHeight: 44)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
            .frame(maxWidth: 480)
            .frame(maxWidth: .infinity)
        }
        .background(AppColor.background)
        .presentationBackground(AppColor.background)
        .presentationCornerRadius(20)
        .presentationDragIndicator(.visible)
        .presentationDetents(typeSize.isAccessibilitySize ? [.large] : [.height(420), .large])
    }
}
