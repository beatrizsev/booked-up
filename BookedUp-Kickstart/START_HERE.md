# Start here

1. Open Xcode → File → New → Project → iOS App. Product Name `BookedUp`, Interface `SwiftUI`, Language `Swift`, Storage `None` (if presented). Enable Git if offered. Save it in a dedicated `BookedUp` folder.
2. Run the generated app once in an iPhone Simulator (Cmd+R).
3. Copy the **contents** of this Kickstart folder (including `AGENTS.md`, `SPRINT.md`, `DESIGN_TOKENS.md` and `DesignReferences/`) into the same `BookedUp` project folder that contains `BookedUp.xcodeproj` — not inside the `.xcodeproj` bundle.
4. In the Codex desktop app, open the local `BookedUp` folder. In Codex Plugins, install/authorise the Figma plugin if available. If you cannot connect now, continue with the included screenshot.
5. Copy the contents of `CODEX_FIRST_PROMPT.md` into Codex, replacing the Home frame placeholder with its actual Figma link if available.
6. Review generated changes, run Cmd+R again in Xcode and take a screenshot.
7. Commit in Xcode's source control UI, or use Terminal: `git add . && git commit -m "feat: scaffold Booked Up home"` (only if a repository is already initialised).
8. Create a new blank GitHub repository named `booked-up` at https://github.com/new (choose Public for portfolio; do not initialise with README if the local repo already has commits). Then follow GitHub's existing-repository instructions to add origin and push.

Note: no Xcode project files are bundled here. Xcode must generate the project on your Mac first. Swift compilation was not performed while creating this reference pack.
