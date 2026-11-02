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
- Page title: Playfair Display Semibold, 30pt / 36pt line height (current Figma frames).
- Large editorial heading: Playfair Display Semibold, 36pt / 43pt.
- Section heading: SF Pro Semibold, 20pt / 26pt.
- Book/card title: SF Pro Semibold, 17pt / 22pt.
- Body: SF Pro Regular, 16pt / 24pt.
- Secondary body: SF Pro Regular, 14pt / 20pt.
- Button label: SF Pro Semibold, 15pt / 20pt.
- Caption: SF Pro Regular, 12pt / 16pt.

Use Dynamic Type-friendly SwiftUI constructs. Prefer text/background contrast over mechanical fidelity to a mockup.

### Bundled Playfair Display

`BookedUp/Fonts/PlayfairDisplay.ttf` is the unmodified Google Fonts variable font. Its SIL Open Font License is included alongside it as `PlayfairDisplay-OFL.txt` and is viewable from the local account sheet. Source: https://github.com/google/fonts/tree/main/ofl/playfairdisplay.

`AppTypography.registerFonts()` registers the bundled font with Core Text at startup and in previews. `BookedUp/DesignSystem/AppTypography.swift` uses the PostScript face `PlayfairDisplayRoman-SemiBold` for page titles and editorial headings, matching the current Figma frames. All other text remains SF Pro. The helper scales point sizes with Dynamic Type and retains a native serif fallback if font registration ever fails. No external package is required.

## Components
PrimaryButton; BookCover/BookCard; ReadingProgress; MoodTag; SearchField; TabView shell; Info/Stat card; EmptyState.

## Figma source
Design collage included under `DesignReferences/`. Real frame links and exported assets should be added later; do not infer precise layout metrics from the collage alone.
