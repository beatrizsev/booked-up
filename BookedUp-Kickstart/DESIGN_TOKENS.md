# Booked Up visual system — reference for Codex

## Colours
| Role | Name | Hex |
| --- | --- | --- |
| Title/primary text | Dark Cocoa | `#352B25` |
| Body | Soft Cocoa | `#645750` |
| Metadata | Muted Cocoa | `#877A71` |
| App background | Main Background | `#FFFCF7` |
| Cards | Paper Cream | `#F5E8D5` |
| Brand | Sage Green | `#758773` |
| Decorative | Dusty Pink | `#E7A8AE` |
| Accent | Warm Taupe | `#C8AE8E` |
| Border | Default Border | `#DDD0BF` |

## Typography
- Page title: Playfair Display Regular, 30pt / 36pt line height.
- Large editorial heading: Playfair Display Regular, 36pt / 43pt.
- Section heading: SF Pro Semibold, 20pt / 26pt.
- Book/card title: SF Pro Semibold, 17pt / 22pt.
- Body: SF Pro Regular, 16pt / 24pt.
- Secondary body: SF Pro Regular, 14pt / 20pt.
- Button label: SF Pro Semibold, 15pt / 20pt.
- Caption: SF Pro Regular, 12pt / 16pt.

Use Dynamic Type-friendly SwiftUI constructs. Prefer text/background contrast over mechanical fidelity to a mockup.

### Adding Playfair Display later

Today’s app uses a native serif fallback for page titles and editorial headings, with SF Pro for all other text. `BookedUp/DesignSystem/AppTypography.swift` scales the specified point sizes with Dynamic Type and checks for `PlayfairDisplay-Regular` at runtime.

1. Obtain the font from its authorised source and check the licence permits bundling it in an iOS app. Keep the required licence / attribution with the project. No font has been downloaded or redistributed in this checkpoint.
2. Add the licensed Regular `.ttf` or `.otf` file to the existing BookedUp target (for example under `BookedUp/Fonts/`). Verify it is included in **Build Phases → Copy Bundle Resources**.
3. In **Target → Info**, add **Fonts provided by application** (`UIAppFonts`) as an array containing the bundled filename, including its extension, such as `PlayfairDisplay-Regular.ttf`.
4. Confirm the font’s actual PostScript name. If it differs from `PlayfairDisplay-Regular`, update `playfairName` in `AppTypography.swift`.
5. Rebuild and relaunch. Check the title in the simulator at default and accessibility text sizes. The helper switches to Playfair only when registration succeeds; otherwise the serif fallback remains.

## Components
PrimaryButton; BookCover/BookCard; ReadingProgress; MoodTag; SearchField; TabView shell; Info/Stat card; EmptyState.

## Figma source
Design collage included under `DesignReferences/`. Real frame links and exported assets should be added later; do not infer precise layout metrics from the collage alone.
