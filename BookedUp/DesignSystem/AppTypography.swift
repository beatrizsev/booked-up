import SwiftUI
import UIKit

enum AppTypography {
    case pageTitle, editorial, sectionHeading, bookTitle, body, secondaryBody, button, caption

    var size: CGFloat {
        switch self {
        case .pageTitle: 30
        case .editorial: 36
        case .sectionHeading: 20
        case .bookTitle: 17
        case .body: 16
        case .secondaryBody: 14
        case .button: 15
        case .caption: 12
        }
    }

    var textStyle: Font.TextStyle {
        switch self {
        case .pageTitle, .editorial: .largeTitle
        case .sectionHeading: .title2
        case .bookTitle: .headline
        case .body: .body
        case .secondaryBody: .subheadline
        case .button: .callout
        case .caption: .caption
        }
    }

    var weight: Font.Weight {
        switch self {
        case .sectionHeading, .bookTitle, .button: .semibold
        default: .regular
        }
    }

    var isEditorial: Bool { self == .pageTitle || self == .editorial }
}

private struct BookedUpTextStyle: ViewModifier {
    let style: AppTypography
    @ScaledMetric private var scaledSize: CGFloat

    // Only use Playfair when an actual font file has been bundled and registered.
    private static let playfairName = "PlayfairDisplay-Regular"
    private static let hasPlayfair = UIFont(name: playfairName, size: 30) != nil

    init(_ style: AppTypography) {
        self.style = style
        _scaledSize = ScaledMetric(wrappedValue: style.size, relativeTo: style.textStyle)
    }

    func body(content: Content) -> some View {
        content.font(font)
    }

    private var font: Font {
        if style.isEditorial, Self.hasPlayfair {
            return .custom(Self.playfairName, fixedSize: scaledSize)
        }
        return .system(
            size: scaledSize,
            weight: style.weight,
            design: style.isEditorial ? .serif : .default
        )
    }
}

extension View {
    func bookedUpText(_ style: AppTypography) -> some View {
        modifier(BookedUpTextStyle(style))
    }
}
