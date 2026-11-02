import SwiftUI

struct OnboardingView: View {
    let onContinue: (AuthenticationView.Mode) -> Void
    @State private var page = 0

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                BrandLogo(width: 179)
                    .padding(.top, 8)
                    .padding(.bottom, 16)

                TabView(selection: $page) {
                    welcomePage(
                        title: "A calmer way\nto read",
                        description: "Discover books, track your reading and remember what each story made you feel",
                        image: "OnboardingReading",
                        width: min(342, geometry.size.width - 32),
                        height: 253,
                        illustrationSpacing: 16
                    )
                    .tag(0)
                    .accessibilityIdentifier("onboarding.page.0")

                    welcomePage(
                        title: "Every page\nhas a story",
                        description: "Save your favourite quotes, capture your thoughts and keep your reading memories close",
                        image: "OnboardingJournal",
                        width: min(292, geometry.size.width - 32),
                        height: 228,
                        illustrationSpacing: 40
                    )
                    .tag(1)
                    .accessibilityIdentifier("onboarding.page.1")
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .never))
                .accessibilityIdentifier("onboarding.pages")

                VStack(spacing: 8) {
                    PrimaryButton(title: "Get started") { onContinue(.createAccount) }
                        .accessibilityIdentifier("onboarding.getStarted")
                    Button("I already have an account") { onContinue(.logIn) }
                        .bookedUpText(.button)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .accessibilityIdentifier("onboarding.logIn")
                }
                .padding(16)
            }
            .frame(maxWidth: 520)
            .frame(maxWidth: .infinity)
        }
        .background(AppColor.background)
    }

    private func welcomePage(
        title: String, description: String, image: String,
        width: CGFloat, height: CGFloat, illustrationSpacing: CGFloat
    ) -> some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .padding(.bottom, illustrationSpacing - 16)
                    .accessibilityHidden(true)
                Text(title)
                    .bookedUpText(.editorial)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityAddTraits(.isHeader)
                Text(description)
                    .bookedUpText(.body)
                    .foregroundStyle(AppColor.secondaryText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .frame(maxWidth: 282)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 48)
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }
}
