import SwiftUI
import UIKit
import CoreText

enum AppTypography {
    case pageTitle, editorial, sectionHeading, bookTitle, body, secondaryBody, button, caption

    static func registerFonts() {
        guard let url = Bundle.main.url(forResource: "PlayfairDisplay", withExtension: "ttf") else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }

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

    // Lazily register here too so Xcode previews use the bundled face.
    private static let playfairName = "PlayfairDisplayRoman-SemiBold"
    private static let hasPlayfair: Bool = {
        AppTypography.registerFonts()
        return UIFont(name: playfairName, size: 30) != nil
    }()

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
