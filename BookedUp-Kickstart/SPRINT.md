# Booked Up — 15-hour delivery sprint

**Window:** Monday 2 Nov through Friday 6 Nov 2026. **Budget:** 3 hours each day.

## Mon, Nov 2 — Foundations + Home (3h)
- [ ] (0:00–0:30) Create a new iOS SwiftUI app in Xcode; run starter simulator; initialise Git.
- [ ] (0:30–0:50) Open project in Codex; enable Figma plugin / paste frame link; copy these docs into project.
- [x] (0:50–1:30) Install colour and typography tokens; build tab-shell.
- [x] (1:30–2:40) Implement Home using mock data, reusable book card and progress bar.
- [ ] (2:40–3:00) Test in simulator; fix compile errors; commit `feat: bootstrap Booked Up home`.

### November 2 implementation checkpoint

- Updated the existing Xcode starter; preserved the app entry point, project settings and iOS 26.5 deployment target.
- Home follows Figma frame `29:1149`, including its four locally bundled cover images. Native tabs show Home, Discover, Library and Stats; the last three are explicit placeholders.
- Added named colours, Dynamic Type typography, a native serif fallback, sample books, reusable book cards and both progress treatments. Playfair registration instructions are in `DESIGN_TOKENS.md`.
- Validation: Debug `xcodebuild` succeeded with Xcode 26.5 and the iOS 26.5 simulator SDK, including the final visual adjustments. Installed and launched on iPhone 17 Pro. Checked each tab, default-size Home and its expanded layout at the largest accessibility text size; restored the simulator’s original `large` text size.
- Accessibility inspection reports full book names/authors/sample ratings, 162 / 384 pages at 42%, and 14 of 20 books read. Listening with VoiceOver remains a manual check.
- Remaining manual QA: scroll to the recommendation metadata/footer, swipe the shelf, test a smaller phone, landscape and iPad. Simulator automation did not move the scroll view, so gesture behaviour is not yet verified.
- No backend, API, authentication, package dependencies or persistence added. No Git staging or commit performed; the final checklist item remains open for manual QA and the user’s commit.

### November 2 — requested onboarding and local demo account slice

- Scope extended by the user after the Home checkpoint: two original Figma welcome pages, Create Account, Log In, and truthful recovery-preview sheets. No external authentication service or book database.
- Added simple root routing, one local account, Keychain-only password storage, and `@AppStorage` onboarding/email/session state. Logout preserves the account; confirmed reset removes it and returns to onboarding.
- Bundled licensed Playfair Display and its OFL notice; retained SF Pro elsewhere. Home remains the sample reading dashboard, with an account menu added for logout/reset.
- Added an isolated simulator UI test target covering onboarding, validation, masked/visible password entry, create/login/logout, process restarts, duplicate-account protection, both recovery sheets, and account reset.
- Verification: final signed Debug build and all four UI tests passed on iPhone 17 Pro / iOS 26.5 with Xcode 26.5: 0 failures in 155 seconds. Original Figma illustrations, account forms and both recovery sheets were visually inspected.
- Fixed dropped characters during masked password entry by simplifying the native field’s focus/autofill configuration; verified both masked creation and masked login. The reset-cancellation test supports iOS 26’s native popover dismissal. The simulator keyboard preference used during diagnosis was restored to its original unset state.
- Remaining manual QA: authentication layouts at accessibility text sizes, VoiceOver, landscape, smaller phones and iPad. No commit or push performed.

## Tue, Nov 3 — Discover + Library (3h)
- [ ] Implement searchable curated local books list.
- [ ] Implement Book Details and Add to Library interaction.
- [ ] Implement My Library tabs/filters and navigable book cards.
- [ ] Test flows; commit changes.

## Wed, Nov 4 — Persistence + Journal (3h)
- [ ] Introduce SwiftData model for user's book records; use stable book ID.
- [ ] Persist status, progress, dates and ratings.
- [ ] Implement add/edit reading notes with persisted data.
- [ ] Relaunch app to verify records persist; commit changes.

## Thu, Nov 5 — Stats + Polish (3h)
- [ ] Implement reading stats from actual local records (books finished, pages read, average rating).
- [x] Implement two welcome/onboarding slides with a functioning Continue/Get Started flow (completed in the requested November 2 slice).
- [ ] Fix UI discrepancies, loading/empty states, accessibility and crashes.
- [ ] Cut live API integration if it interferes with delivery.

## Fri, Nov 6 — GitHub + Portfolio + LinkedIn (3h)
- [ ] Final simulator QA and app screenshots.
- [ ] Create GitHub repository / push local commits; verify README and LICENSE (if desired).
- [ ] Write concise case study: challenge, role, process, visual system, features, technical decisions, trade-offs, demo/screenshots.
- [ ] Publish portfolio project and LinkedIn post with correct links.

## Out of scope
External authentication services, real email/password recovery, social features, notification systems, cloud sync, App Store release, API-backed recommendations. Local demo account creation/login was explicitly added by the user on November 2. A Google Books search is stretch only.
