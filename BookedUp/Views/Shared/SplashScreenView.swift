import SwiftUI

/// A single gentle rocking cycle before the app's existing destination appears.
struct SplashScreenView: View {
    let onFinished: () -> Void
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var angle = 0.0

    var body: some View {
        GeometryReader { geometry in
            let size = max(0, min(264, geometry.size.width - 64, geometry.size.height - 64))
            Image("SplashBadge")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .rotationEffect(.degrees(reduceMotion ? 0 : angle))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(AppColor.background)
        .ignoresSafeArea()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Booked Up")
        .accessibilityAddTraits(.isImage)
        .accessibilityIdentifier("splash.screen")
        .task(id: reduceMotion) {
            do {
                angle = 0
                if reduceMotion {
                    try await Task.sleep(for: .seconds(0.8))
                } else {
                    // Clockwise, counterclockwise, then settle at the original angle.
                    withAnimation(.easeInOut(duration: 0.8)) { angle = 5 }
                    try await Task.sleep(for: .seconds(0.8))
                    withAnimation(.easeInOut(duration: 1.6)) { angle = -5 }
                    try await Task.sleep(for: .seconds(1.6))
                    withAnimation(.easeInOut(duration: 0.8)) { angle = 0 }
                    try await Task.sleep(for: .seconds(0.8))
                }
                try Task.checkCancellation()
                onFinished()
            } catch {
                // Disappearing or changing Reduce Motion cancels this presentation.
            }
        }
    }
}

#Preview {
    SplashScreenView(onFinished: {})
}
