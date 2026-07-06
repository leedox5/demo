# AGENTS.md

## Project Overview
- This project is a Rails-based learning notebook focused on storing vocabulary, terms, and key phrases.
- Core user flow: sign in, create an item, assign it to a group, search/filter items, and add memo-style comments.
- Current domain naming in code uses Post as the item entity and Group for categorization.

## Product Concept
- Product name: LexiNote.
- LexiNote is a personal learning notebook for collecting newly encountered words, phrases, terms, examples, and memory cues.
- The user-facing experience should feel like a calm vocabulary and expression notebook, not a community board or generic CRUD app.
- Use "item", "word/phrase", "group", and "memo/note" language in UI copy; keep internal Rails model names such as Post and Comment only in code.
- Korean remains the primary UX language, with selective English brand terms such as "LexiNote", "Words & phrases", and "Notes" when they strengthen the product identity.

## Tech Stack
- Backend: Ruby on Rails 8.1.x
- Language: Ruby 3.3.x
- Database: SQLite3 (development/test)
- Authentication: Devise
- Frontend: ERB templates + Tailwind CSS
- JS behavior: Hotwire stack (Turbo + Stimulus), importmap
- Testing: Rails Minitest

## Development Philosophy
- Prefer incremental delivery over large rewrites.
- Keep the app usable at every step: each change should preserve a working end-to-end flow.
- Favor readability and explicitness over clever abstractions.
- Keep terminology user-facing and consistent with the product intent (learning notebook, item, group, memo).
- Ship small, verifiable units with tests or concrete runtime checks.

## Decision Making
- Prioritize decisions by impact order:
  1. Data integrity and security
  2. Correct behavior and testability
  3. UX clarity and consistency
  4. Performance optimization
  5. Developer convenience
- For trade-offs, choose the option that minimizes migration cost later.
- If uncertain, prefer reversible changes and add TODO notes with clear context.

## Architecture
- MVC Rails structure is the source of truth.
- Models own data rules and relationships.
  - User has many posts/comments/groups.
  - Post belongs to user and optional group, has many comments (polymorphic commentable).
  - Group belongs to user and has many posts.
- Controllers should remain thin: orchestration, auth checks, strong params, response flow.
- Views should contain presentation logic only; avoid business rules in templates.
- Keep comments polymorphic usage consistent if reply depth is expanded.

## UI Rules
- Keep language consistent: use item/term vocabulary tone instead of community-board tone.
- Prefer Korean labels/messages for primary UX, unless a screen is intentionally English.
- Every CRUD page should include a clear primary action and a clear return path.
- Empty states must explain what to do next.
- Search/filter UI must be visible near the list context (not hidden in separate screens).

## Styling Rules
- Use existing Tailwind utility style and spacing rhythm already present in the project.
- Reuse current color tokens and component patterns before adding new visual variants.
- Preserve responsive behavior (mobile-first; verify md breakpoints at minimum).
- Avoid introducing one-off class clutter; group repeated styles into partials/components when repetition appears.
- Maintain accessible contrast, focus visibility, and actionable hit areas.

## Testing Rules (Recommended)
- Run full test suite before commit: DISABLE_SPRING=1 bin/rails test
- Add or update controller/model tests when behavior changes.
- Prefer behavior-focused tests over implementation-detail assertions.
- Fix broken route helpers and fixtures immediately to keep suite stable.

## Git Workflow (Recommended)
- Commit small, coherent changes with clear messages.
- Do not mix refactor and feature work in a single commit unless tightly coupled.
- Keep working tree clean after verification.

## Security and Data Safety (Recommended)
- Enforce authentication for non-public actions.
- Always use strong parameters.
- Do not trust client-sent ownership IDs; derive ownership from current_user.
- Use foreign keys and model validations for relationship safety.

## Definition of Done
- Feature behavior works in browser for primary flow.
- Relevant tests pass locally.
- UI copy is consistent with product tone.
- No unrelated file churn in commit.
- A short change summary is recorded in the PR/commit message.
