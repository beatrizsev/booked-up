# Booked Up — Codex project rules

## Product
Booked Up is a calm, editorial, personal reading companion for iOS. The user already designed its screens in Figma. This repository is a portfolio MVP, to be completed during November 2–6, 2026. Prioritise a runnable app over a long architecture or a premature feature set.

## Technologies
- Swift, SwiftUI, Xcode iOS App template. Keep the minimum iOS target chosen in the Xcode project.
- SwiftData for local persistence when the core UI is ready.
- No external Swift packages unless absolutely required; use native navigation and controls.
- No authentication, custom backend, user accounts, social features or cloud sync in this MVP.
- Begin with a small curated local sample book dataset. Integrate a live books API only if all core flows are already working.

## Design — follow Figma
- Figma screenshots: `DesignReferences/BookedUp-Figma-Screens.png`; request individual frame links or exported assets if the screenshot is insufficient.
- Page titles: Playfair Display, if the font is provided and registered; until then use a native serif fallback. Do not download or claim to redistribute font files without checking licensing.
- All other text: SwiftUI system font (SF Pro).
- Colours: primary text Dark Cocoa #352B25, body Soft Cocoa #645750, tertiary #877A71, primary background #FFFCF7, card background Paper Cream #F5E8D5, brand Sage Green #758773, Dusty Pink #E7A8AE, Warm Taupe #C8AE8E, default border #DDD0BF.
- Keep the interface warm, restrained, accessible, responsive and similar to the supplied screen designs.

## Scope, ordered by business value
1. Four-tab shell: Home, Discover, Library, Stats (Profile tab may link to Stats).
2. Home with currently-reading, reading goal, book recommendations using local samples.
3. Discover with search of samples, a book detail page, and Add to Library.
4. My Library filtered by Want to Read / Reading / Finished / DNF.
5. Currently Reading progress update, reading note creation/editing and book rating.
6. Derived reading stats from local book records.
7. Onboarding as visual welcome flow; no nonfunctional login or registration buttons.

## Work habits
- Implement one coherent slice per request, then build/test.
- Prefer small, understandable SwiftUI views. Extract components when reused.
- Avoid unnecessary MVVM, protocol abstractions and libraries.
- Have a single @main App entry point; preserve Xcode's generated project settings.
- Do not add fake-looking calls to unavailable web services or credentials.
- Preserve book status/notes/rating/progress across app launches once persistence is implemented.
- Explain each change in 3 parts: files changed, what to test, and any remaining risks.
- If you can run xcodebuild, do so and correct build errors; if not, say that compilation remains unverified.
- Only stage/commit with the user's existing Git preferences; never overwrite a remote repository or force push.

## Definition of done
- App compiles and runs in iOS Simulator.
- User can find a sample book, save it, change reading status, edit progress, add a note, mark as finished, and rate it.
- Data survives relaunch.
- Stats reflect actual locally saved data.
- Screens look coherent with Figma (not necessarily pixel-perfect).
- No dead buttons, unhandled errors or obvious crashes along the demo flow.
- Screenshots, README and GitHub repository are ready for portfolio sharing.
