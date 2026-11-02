# Booked Up

A SwiftUI reading companion. This checkpoint implements the November 2 Home slice of the November 2–6, 2026 portfolio sprint.

## Available today

- Native bottom tabs: Home, Discover, Library and Stats.
- Home greeting, currently reading card, page progress, yearly challenge and three recommendations.
- Local sample books, reusable `BookCard` / `BookCover` and linear / circular `ReadingProgress` views.
- Named colour assets and scalable typography helpers. Titles use the native serif fallback; other text uses SF Pro.
- Explicit “Coming soon” screens for Discover, Library and Stats.

Home is a read-only preview. Its reader, progress, challenge and ratings are sample data. Search, details, saving, editing and actual statistics belong to later sprint slices. There is no persistence, networking, authentication or external package dependency.

## Run in Simulator

1. Open `BookedUp.xcodeproj` from this directory in Xcode 26.5 or later.
2. Select the **BookedUp** scheme and an **iOS 26.5** simulator, such as iPhone 17 Pro.
3. Press **⌘R**. The existing project’s minimum iOS target remains 26.5.

Command-line build from the repository root:

```sh
xcodebuild -project BookedUp.xcodeproj -scheme BookedUp \
  -configuration Debug -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath /private/tmp/BookedUp-DerivedData \
  build CODE_SIGNING_ALLOWED=NO
```

The project uses Xcode’s synchronised source folder, so new Swift files and assets are included without editing the project file.

## Design and implementation

The [Figma Home frame](https://www.figma.com/design/wIN9ZzzmMFiewB0Mv0ojkf/booked-up--case-study-?node-id=29-1149) is the visual reference. The supplied link targets the surrounding canvas. The four book covers were exported from that frame and are bundled locally in `Assets.xcassets`; they do not need network access. Book titles and authors follow the visible content, rather than the outdated Figma component names.

The native tab bar uses iOS 26 styling and Stats replaces Figma’s Profile destination. The notification bell and card chevrons are omitted until their actions exist. Recommendation text has room for two lines, and metadata on cream cards uses Soft Cocoa for legibility. The screen scrolls and the reading cards stack vertically at accessibility text sizes. This checkpoint uses the supplied light palette throughout; a dark theme remains future work.

| Files | Purpose |
| --- | --- |
| `BookedUp/ContentView.swift` | Four-tab app shell |
| `BookedUp/DesignSystem/` | App colours and Dynamic Type typography |
| `BookedUp/Models/SampleBooks.swift` | Stable book IDs and read-only Home fixtures |
| `BookedUp/Views/Home/HomeView.swift` | Greeting, reading card, challenge and shelf |
| `BookedUp/Views/Components/` | Book covers/cards and reading progress |
| `BookedUp/Views/Shared/PlaceholderView.swift` | Honest unfinished destinations |
| `BookedUp/Assets.xcassets/` | Palette and four Figma book covers |

Font installation guidance is in `BookedUp-Kickstart/DESIGN_TOKENS.md`. No Playfair font file is currently bundled. Cover artwork remains the property of its respective rights holders; the original Figma source is recorded here for provenance.

## Manual QA

- Launch into Home and verify the four covers, greeting and section spacing.
- Verify **162 / 384 pages → 42%** and **14 / 20 books → 70%**.
- Scroll to the recommendation authors, ratings and sample-data footer; swipe the shelf on smaller widths.
- Tap all four tabs and return to Home. Unfinished destinations must show “Coming soon”.
- Test portrait / landscape, a smaller phone, and an iPad.
- Increase Dynamic Type to an accessibility size. Text and cards should grow and remain reachable by scrolling.
- With VoiceOver, check book titles/authors/sample ratings and reading-progress announcements. Artwork should not duplicate the adjacent title.

Build and simulator verification results for this checkpoint are recorded in `BookedUp-Kickstart/SPRINT.md`.
