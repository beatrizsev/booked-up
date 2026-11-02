# Send this prompt in Codex after opening the Xcode project directory

You are helping me ship **Booked Up**, a SwiftUI personal reading companion, for my UX + iOS portfolio by Friday November 6, 2026. I have only three focused hours per day, so prioritize a runnable, polished MVP over implementing everything.

Read `AGENTS.md`, `SPRINT.md`, `DESIGN_TOKENS.md` and `DesignReferences/BookedUp-Figma-Screens.png` first. Also inspect the existing Xcode project before making changes.

If Figma MCP is connected, use this frame link for Home: https://www.figma.com/design/wIN9ZzzmMFiewB0Mv0ojkf/booked-up--case-study-?node-id=29-1109. If not, use the provided screenshot and ask for the frame link only if it is essential.

**Task for today only:**
1. Create app-wide colours and typography helpers. Use Playfair Display for page titles if it is already installed; otherwise apply a serif fallback and document how to add the licensed font later. Keep native SF Pro for the rest.
2. Create a bottom tab bar for Home, Discover, Library and Stats. Tabs that are not implemented yet must show clear placeholder screens, not fake functionality.
3. Implement the Home screen close to Figma: greeting, Currently Reading card with cover/progress, yearly reading challenge, and book recommendations.
4. Add a small local mock dataset and reusable `BookCard` and `ReadingProgress` views. Do not add a backend, auth, API, package dependencies or persistence today.
5. Build using xcodebuild if available and fix compile errors.

Please work in small, reviewable steps and update the existing project rather than generating a second app. At the end, show which files changed, how to run the simulator, and what to test. Do not make unrelated changes.
