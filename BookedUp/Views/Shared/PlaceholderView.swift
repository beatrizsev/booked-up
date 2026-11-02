import SwiftUI

struct PlaceholderView: View {
    let title: String
    let symbol: String
    let message: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text(title)
                    .bookedUpText(.pageTitle)
                    .accessibilityAddTraits(.isHeader)

                VStack(spacing: 16) {
                    Image(systemName: symbol)
                        .font(.system(size: 40, weight: .light))
                        .foregroundStyle(AppColor.sage)
                        .accessibilityHidden(true)
                    Text("Coming soon")
                        .bookedUpText(.sectionHeading)
                    Text(message)
                        .bookedUpText(.body)
                        .foregroundStyle(AppColor.secondaryText)
                        .multilineTextAlignment(.center)
                    Text("Today’s preview is on Home.")
                        .bookedUpText(.secondaryBody)
                        .foregroundStyle(AppColor.secondaryText)
                }
                .padding(28)
                .frame(maxWidth: .infinity)
                .background(AppColor.card, in: RoundedRectangle(cornerRadius: 18))
            }
            .padding(16)
            .frame(maxWidth: 640)
            .frame(maxWidth: .infinity)
        }
        .background(AppColor.background)
        .foregroundStyle(AppColor.primaryText)
        .toolbarBackground(AppColor.background, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}
