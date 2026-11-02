import SwiftUI

struct BrandLogo: View {
    var width: CGFloat = 194

    var body: some View {
        Image("BookedUpLogo")
            .resizable()
            .scaledToFit()
            .frame(width: width, height: width * 64 / 194)
            .accessibilityLabel("Booked Up")
    }
}

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .bookedUpText(.button)
                .frame(maxWidth: .infinity, minHeight: 28)
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
        .foregroundStyle(.white)
        .background(AppColor.primaryText, in: RoundedRectangle(cornerRadius: 12))
    }
}

struct AccountEmailField: View {
    @Binding var email: String
    var identifier = "auth.email"

    var body: some View {
        TextField("Email", text: $email, prompt: Text("you@example.com").foregroundStyle(AppColor.tertiaryText))
            .foregroundStyle(AppColor.primaryText)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .bookedUpText(.body)
            .foregroundStyle(AppColor.primaryText)
            .padding(14)
            .frame(minHeight: 52)
            .background(.white, in: RoundedRectangle(cornerRadius: 12))
            .overlay { RoundedRectangle(cornerRadius: 12).stroke(AppColor.border) }
            .accessibilityLabel("Email")
            .accessibilityIdentifier(identifier)
    }
}

struct AccountPasswordField: View {
    @Binding var password: String
    let isCreating: Bool
    @State private var isVisible = false

    var body: some View {
        HStack(spacing: 0) {
            Group {
                if isVisible {
                    TextField(isCreating ? "Create a password" : "Enter your password", text: $password)
                } else {
                    SecureField(isCreating ? "Create a password" : "Enter your password", text: $password)
                }
            }
            .textContentType(.password)
            .keyboardType(.asciiCapable)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .bookedUpText(.body)
            .accessibilityLabel("Password")
            .accessibilityIdentifier("auth.password")
            Button {
                isVisible.toggle()
            } label: {
                Image(systemName: isVisible ? "eye.slash" : "eye")
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .foregroundStyle(AppColor.secondaryText)
            .accessibilityLabel(isVisible ? "Hide password" : "Show password")
        }
        .padding(.leading, 14)
        .padding(.trailing, 4)
        .padding(.vertical, 4)
        .frame(minHeight: 52)
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
        .overlay { RoundedRectangle(cornerRadius: 12).stroke(AppColor.border) }
    }
}

struct DemoResetButton: View {
    let onReset: () throws -> Void
    @State private var confirmReset = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button("Reset local demo account", role: .destructive) { confirmReset = true }
                .bookedUpText(.secondaryBody)
                .frame(minHeight: 44)
                .accessibilityIdentifier("demo.reset")
            if let errorMessage {
                Text(errorMessage).bookedUpText(.secondaryBody)
            }
        }
        .confirmationDialog("Reset this local demo?", isPresented: $confirmReset, titleVisibility: .visible) {
            Button("Reset demo", role: .destructive) {
                do { try onReset() }
                catch { errorMessage = error.localizedDescription }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This removes the saved email, Keychain password and session, then shows onboarding again.")
        }
    }
}
