# Booked Up

A SwiftUI reading companion for the November 2–6, 2026 portfolio sprint, with Home, onboarding and a local demo account flow.

## Available today

- Native bottom tabs: Home, Discover, Library and Stats.
- Home greeting, currently reading card, page progress, yearly challenge and three recommendations.
- Local sample books, reusable `BookCard` / `BookCover` and linear / circular `ReadingProgress` views.
- Two swipeable welcome pages using the original Figma illustrations and logo, with native page indicators.
- Create Account, Log In, Log Out and clearly labelled recovery-preview sheets.
- One local account: email and non-sensitive session state in `@AppStorage`, password in device-local Keychain.
- Named colour assets and scalable typography helpers. Titles use bundled Playfair Display; other text uses SF Pro.
- Explicit “Coming soon” screens for Discover, Library and Stats.

Home is a read-only preview. Its reader, progress, challenge and ratings are sample data. Search, details, saving, editing and actual statistics belong to later sprint slices. There is no book database, external authentication, networking or external package dependency. Local demo authentication is for demonstrating the case-study flow, not production account security.

## Local demo account

First launch shows onboarding. **Get started** opens Create Account; **I already have an account** opens Log In. Completing either welcome action persists onboarding completion. Creating an account signs in immediately. Relaunching restores a signed-in session; after logout, relaunching shows Log In. Use Home’s account icon to log out without deleting the account.

The email is trimmed and normalised to lowercase. Passwords require 8–128 characters and cannot contain only spaces; passwords are compared exactly, without trimming. The app prevents creating a second account. A Keychain failure shows an error and never signs the reader in.

The single password uses a scoped generic Keychain item, with `kSecAttrAccessibleWhenUnlockedThisDeviceOnly` and synchronisation disabled. It is never stored in UserDefaults or logs. The local session flag is only a demo convenience, not a server-issued authentication token.

**Forgot password?** opens the Reset Password sheet. **Preview reset link** opens Check Your Inbox, which explicitly says no email was sent and no password changed. This flow never contacts an email service.

### Reset for testing

- Signed in: Home → account icon → **Reset local demo account** → **Reset demo**.
- Signed out with a saved account: Log In → **Reset local demo account** → **Reset demo**. Scroll below the form if needed.
- Reset deletes this demo’s Keychain password, saved email and session, and clears onboarding completion. It returns to the first welcome page. It does not erase the simulator or other apps.
- Uninstalling can leave Keychain items behind; on a fresh installation, the app clears its orphaned password when no account email exists. The in-app reset is the explicit way to repeat the full demo.

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
  build
```

The project uses Xcode’s synchronised source folders. The shared BookedUp scheme includes an authentication UI test target.

## Simulator tests

Press **⌘U** in Xcode, or run:

```sh
xcodebuild -project BookedUp.xcodeproj -scheme BookedUp \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -parallel-testing-enabled NO test
```

`BookedUpUITests/AuthenticationFlowTests.swift` covers onboarding swipes and both entry actions, validation, account creation, duplicate-account protection, logout, incorrect credentials, successful login, signed-in/signed-out process restarts, reset, and both recovery sheets. It verifies both masked password entry and password visibility toggling, plus cancelling and confirming the native reset prompt. Test screenshots are attached to the Xcode test results.

Verified November 2, 2026: the signed Debug build and all four UI tests passed on iPhone 17 Pro / iOS 26.5 using Xcode 26.5, with zero failures (155 seconds).

Keep Xcode’s normal simulator code signing enabled: an unsigned app can compile and launch but cannot reliably access Keychain. Simulator signing does not require an external authentication service.

Debug UI tests pass `--ui-testing` to use a separate defaults suite and Keychain service. `--reset-ui-tests` clears only that isolated test account at the start of each test. Relaunch tests omit the reset flag. These test switches are excluded from Release builds; the normal demo account remains untouched by the tests.

## Design and implementation

The [Figma Home frame](https://www.figma.com/design/wIN9ZzzmMFiewB0Mv0ojkf/booked-up--case-study-?node-id=29-1149) is the visual reference. The supplied link targets the surrounding canvas. The four book covers were exported from that frame and are bundled locally in `Assets.xcassets`; they do not need network access. Book titles and authors follow the visible content, rather than the outdated Figma component names.

The native tab bar uses iOS 26 styling and Stats replaces Figma’s Profile destination. The notification bell and card chevrons are omitted until their actions exist. Recommendation text has room for two lines, and metadata on cream cards uses Soft Cocoa for legibility. The screen scrolls and the reading cards stack vertically at accessibility text sizes. This checkpoint uses the supplied light palette throughout; a dark theme remains future work.

| Files | Purpose |
| --- | --- |
| `BookedUp/AppRootView.swift` | Onboarding, signed-out and signed-in routing |
| `BookedUp/Authentication/` | Single-account state and scoped Keychain password storage |
| `BookedUp/Views/Onboarding/` | Two original welcome screens and swipe navigation |
| `BookedUp/Views/Authentication/` | Account forms, recovery preview, account menu and reset |
| `BookedUp/ContentView.swift` | Four-tab app shell |
| `BookedUp/DesignSystem/` | App colours and Dynamic Type typography |
| `BookedUp/Models/SampleBooks.swift` | Stable book IDs and read-only Home fixtures |
| `BookedUp/Views/Home/HomeView.swift` | Greeting, reading card, challenge and shelf |
| `BookedUp/Views/Components/` | Book covers/cards and reading progress |
| `BookedUp/Views/Shared/PlaceholderView.swift` | Honest unfinished destinations |
| `BookedUp/Assets.xcassets/` | Palette, original welcome artwork/logo and four Figma book covers |
| `BookedUp/Fonts/` | Playfair Display and its licence |
| `BookedUpUITests/` | Simulator coverage of the local demo flows |

The welcome illustrations are unmodified SVG exports of Figma nodes `29:1113` and `29:1189`; the logo comes from `78:2986`. Their original proportions are preserved in local asset catalog image sets. Authentication follows Figma frames `92:707`, `92:708`, `93:779` and `93:790`, with recovery copy adapted to describe the local preview honestly.

Playfair Display is bundled unmodified from [Google Fonts](https://github.com/google/fonts/tree/main/ofl/playfairdisplay), under the [SIL Open Font License](https://github.com/google/fonts/blob/main/ofl/playfairdisplay/OFL.txt). The full licence is included at `BookedUp/Fonts/PlayfairDisplay-OFL.txt` and accessible from the account sheet. Runtime Core Text registration keeps the existing generated Info.plist. The Semibold face matches the current Figma frames; text scales with Dynamic Type. Cover artwork remains the property of its respective rights holders.

## Manual QA

- Follow onboarding and create a local demo account, then verify Home’s four covers, greeting and section spacing.
- Verify **162 / 384 pages → 42%** and **14 / 20 books → 70%**.
- Scroll to the recommendation authors, ratings and sample-data footer; swipe the shelf on smaller widths.
- Tap all four tabs and return to Home. Unfinished destinations must show “Coming soon”.
- Test portrait / landscape, a smaller phone, and an iPad.
- Increase Dynamic Type to an accessibility size. Text and cards should grow and remain reachable by scrolling.
- With VoiceOver, check book titles/authors/sample ratings and reading-progress announcements. Artwork should not duplicate the adjacent title.

Build and simulator verification results for this checkpoint are recorded in `BookedUp-Kickstart/SPRINT.md`.
