# my-factory: builder mode

## Goal (draft)
Given a spec Jurek writes as acceptance tests, my-factory produces an app that passes all of them,
with zero manual edits, in at least 3 of 5 local runs, within a time and cost budget,
with every step logged and no writes outside allowed paths.

Milestones and status: docs/ROADMAP.md
Decisions: docs/architecture-decisions/

## How we work
- Copying and adapting code from ../reference/sssf is allowed, and is the default way to go fast.
- Before copying, explain in two or three sentences what the code does and why we need it.
- Every copied or adapted file gets a row in docs/copied-from-reference.md (our file, source file, why).
- Never edit ../reference, ../learning or ../information-to-knowledge-schema-mapper. Settings enforce this.
- Models: remote first, through Pi with one provider key that has a spending limit.
  Local models (Ollama on this Mac) may be mixed in later for light roles. Model choice lives in the roster, never in code.

## Naming
No abbreviations or acronyms. Descriptive verb plus object, two to three words.
Dashes for files, scripts and commands. Underscores for Python modules and functions (PEP 8).

## Commands
- Tests: uv run pytest -q
- Lint: uv run ruff check .
- Every change ends with both green.

## Session end
Update the status column in docs/ROADMAP.md.
