import SwiftUI

/// Both Home progress treatments share safe, bounded progress calculations.
struct ReadingProgress: View {
    enum Style {
        case linear, ring
    }

    let value: Double
    let total: Double
    let label: String
    var detail: String? = nil
    var style: Style = .linear

    private var fraction: Double {
        guard value.isFinite, total.isFinite, total > 0 else { return 0 }
        return min(max(value / total, 0), 1)
    }

    private var percentage: String {
        fraction.formatted(.percent.precision(.fractionLength(0)))
    }

    var body: some View {
        Group {
            switch style {
            case .linear:
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        ProgressView(value: fraction)
                            .progressViewStyle(ReadingBarStyle())
                        Text(percentage)
                            .bookedUpText(.caption)
                            .monospacedDigit()
                            .fixedSize()
                    }
                    if let detail {
                        Text(detail)
                            .bookedUpText(.caption)
                            .foregroundStyle(AppColor.secondaryText)
                    }
                }
            case .ring:
                ZStack {
                    Circle().stroke(AppColor.border, lineWidth: 10)
                    Circle()
                        .trim(from: 0, to: fraction)
                        .stroke(AppColor.sage, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                }
                .padding(5)
                .frame(width: 76, height: 76)
            }
        }
        .foregroundStyle(AppColor.primaryText)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label)
        .accessibilityValue(detail.map { "\($0), \(percentage)" } ?? percentage)
    }
}

private struct ReadingBarStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            Capsule()
                .fill(AppColor.border)
                .overlay(alignment: .leading) {
                    Capsule()
                        .fill(AppColor.sage)
                        .frame(width: geometry.size.width * (configuration.fractionCompleted ?? 0))
                }
        }
        .frame(height: 10)
    }
}

#Preview("Progress variations") {
    VStack(spacing: 24) {
        ReadingProgress(value: 162, total: 384, label: "Reading progress", detail: "162 / 384 pages")
        ReadingProgress(value: 14, total: 20, label: "Reading challenge", style: .ring)
        ReadingProgress(value: 0, total: 0, label: "No goal yet")
        ReadingProgress(value: 120, total: 100, label: "Finished")
    }
    .padding()
    .background(AppColor.card)
}
