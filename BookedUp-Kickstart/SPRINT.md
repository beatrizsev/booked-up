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
- [ ] Implement two welcome/onboarding slides with a functioning Continue/Get Started flow if time allows.
- [ ] Fix UI discrepancies, loading/empty states, accessibility and crashes.
- [ ] Cut live API integration if it interferes with delivery.

## Fri, Nov 6 — GitHub + Portfolio + LinkedIn (3h)
- [ ] Final simulator QA and app screenshots.
- [ ] Create GitHub repository / push local commits; verify README and LICENSE (if desired).
- [ ] Write concise case study: challenge, role, process, visual system, features, technical decisions, trade-offs, demo/screenshots.
- [ ] Publish portfolio project and LinkedIn post with correct links.

## Out of scope
Working account creation/login/password reset, social features, notification systems, cloud sync, App Store release, API-backed recommendations. A Google Books search is stretch only.
