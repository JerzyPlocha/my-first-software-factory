#!/usr/bin/env bash
# Writes the essential content into the empty setup files of my-first-software-factory.
# Run from the root folder:  bash write-essential-files.sh
# Safety: a file that already has content is SKIPPED, never overwritten.
set -euo pipefail

if [ ! -d my-factory ] || [ ! -d learning ] || [ ! -d information-to-knowledge-schema-mapper ]; then
  echo "Run this from the my-first-software-factory root folder." >&2
  exit 1
fi
if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required by the git-blocking hook. Install it first: brew install jq" >&2
  exit 1
fi

ROOT="$(pwd)"
MAPPER="information-to-knowledge-schema-mapper"

# A file counts as empty if it has no content or only "{}".
is_empty_file() {
  [ ! -e "$1" ] && return 0
  [ ! -s "$1" ] && return 0
  [ "$(tr -d '[:space:]' < "$1")" = "{}" ] && return 0
  return 1
}

write_if_empty() {
  local target="$1"
  mkdir -p "$(dirname "$target")"
  if is_empty_file "$target"; then
    cat > "$target"
    echo "written: $target"
  else
    cat > /dev/null
    echo "SKIPPED (has content, merge by hand): $target"
  fi
}

# ---------------------------------------------------------------------------
# 1. Shared hook: blocks git commits and history changes in sessions that use it
# ---------------------------------------------------------------------------
write_if_empty ".claude/hooks/block-git-writes.sh" <<'EOF'
#!/usr/bin/env bash
# PreToolUse hook for Bash. Exit 2 blocks the call; stderr is shown to Claude.
command=$(jq -r '.tool_input.command // empty')
if printf '%s' "$command" | grep -Eq '\bgit\b.*\b(commit|push|merge|rebase|tag|cherry-pick|am|reset)\b'; then
  echo "Blocked: commits and history changes are done by Jurek manually, after his own review." >&2
  exit 2
fi
exit 0
EOF
chmod +x ".claude/hooks/block-git-writes.sh"

GIT_DENY_RULES='"Bash(git commit:*)", "Bash(git push:*)", "Bash(git merge:*)", "Bash(git rebase:*)", "Bash(git tag:*)", "Bash(git reset:*)"'

# ---------------------------------------------------------------------------
# 2. Root session settings: git denied. (No CLAUDE.md at root, on purpose.)
# ---------------------------------------------------------------------------
write_if_empty ".claude/settings.json" <<EOF
{
  "permissions": {
    "deny": [ ${GIT_DENY_RULES} ]
  },
  "hooks": {
    "PreToolUse": [
      { "matcher": "Bash",
        "hooks": [ { "type": "command", "command": "\"\$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-git-writes.sh" } ] }
    ]
  }
}
EOF

# ---------------------------------------------------------------------------
# 3. learning/ : teacher mode
# ---------------------------------------------------------------------------
write_if_empty "learning/CLAUDE.md" <<'EOF'
# Learning: teacher mode

## Goal
Jurek masters the nine software factory concepts by building my-factory himself.
Exit test: a one-page design note mapping the nine concepts onto Temporal and OpenHands,
approved by the concept-reviewer subagent.

## Sources
- Reference implementation (read-only): ../reference/sssf
- Milestones and status: @../my-factory/docs/ROADMAP.md

## Rules
1. Never write code or files outside this folder. Settings enforce this.
2. Before explaining, ask what Jurek already understands.
3. Review against the nine concepts, not style. Use the concept-reviewer subagent.
4. Show the matching SSSF file and function as the worked example.
5. Challenge weak decisions directly. Honest disagreement beats agreement.
6. Never commit or push. Jurek commits manually after his own review.

## Session start
Ask these, answered by running something, never from memory:
1. Which milestone proof passes right now?
2. Last 5 factory runs: pass rate, median time, tokens?
3. Manual edits to the target app in the last run?
4. Failure in my code or in the model? (fake-agent tests green means the model)
5. What is blocked, and for how many sessions?

## Session end
Propose the exact ROADMAP.md status update as text. Jurek applies it
(this session cannot write outside learning/).
EOF

write_if_empty "learning/.claude/settings.json" <<EOF
{
  "permissions": {
    "additionalDirectories": [
      "${ROOT}/my-factory",
      "${ROOT}/${MAPPER}",
      "${ROOT}/reference/sssf"
    ],
    "deny": [
      "Edit(/${ROOT}/my-factory/**)", "Write(/${ROOT}/my-factory/**)",
      "Edit(/${ROOT}/${MAPPER}/**)", "Write(/${ROOT}/${MAPPER}/**)",
      "Edit(/${ROOT}/reference/**)", "Write(/${ROOT}/reference/**)",
      ${GIT_DENY_RULES}
    ]
  },
  "hooks": {
    "PreToolUse": [
      { "matcher": "Bash",
        "hooks": [ { "type": "command", "command": "\"\$CLAUDE_PROJECT_DIR\"/../.claude/hooks/block-git-writes.sh" } ] }
    ]
  }
}
EOF

# ---------------------------------------------------------------------------
# 4. my-factory/ : builder mode (git allowed here, by Jurek's choice)
# ---------------------------------------------------------------------------
write_if_empty "my-factory/CLAUDE.md" <<'EOF'
# my-factory: builder mode

## Goal (draft)
Given a spec Jurek writes as acceptance tests, my-factory produces an app that passes all of them,
with zero manual edits, in at least 3 of 5 local runs, within a time and token budget,
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
EOF

write_if_empty "my-factory/.claude/settings.json" <<EOF
{
  "outputStyle": "Explanatory",
  "permissions": {
    "additionalDirectories": [ "${ROOT}/reference/sssf" ],
    "deny": [
      "Edit(/${ROOT}/reference/**)", "Write(/${ROOT}/reference/**)",
      "Edit(/${ROOT}/learning/**)", "Write(/${ROOT}/learning/**)",
      "Edit(/${ROOT}/${MAPPER}/**)", "Write(/${ROOT}/${MAPPER}/**)"
    ]
  }
}
EOF

write_if_empty "my-factory/docs/copied-from-reference.md" <<'EOF'
# Code copied or adapted from the reference

Source: Super Simple Software Factory by IndyDevDan (github.com/disler/super-simple-software-factory),
MIT License. Copied and adapted parts keep that license; see the LICENSE file in the source repository.

| Our file | Source file in reference/sssf | What it does and why we need it |
|---|---|---|
EOF

write_if_empty "my-factory/README.md" <<'EOF'
# my-factory

A local-only software factory: deterministic Python owns the workflow, coding agents do bounded steps,
and every run is checked against acceptance tests and logged to SQLite.

Status: see docs/ROADMAP.md
EOF

# ---------------------------------------------------------------------------
# 5. information-to-knowledge-schema-mapper/ : the app the factory builds
# ---------------------------------------------------------------------------
write_if_empty "${MAPPER}/AGENTS.md" <<'EOF'
# information-to-knowledge-schema-mapper

## Meaning of "schema"
"Schema" here is the learning-science term: a network of connected concepts in a learner's mind.
It is NOT a database schema and NOT a JSON schema.

## Scope of v0
Only two commands: import-concept-graph and generate-flashcard-deck.
Out of scope: extracting concepts from text, AI features, user interface, export formats.
Everything else is in specs/backlog.md. Do not implement backlog items.

## Definition of done
All scenarios in specs/features/ pass through tests/acceptance/.
The command-line interface follows specs/command-line-contract.md exactly.

## Protected paths (never edit)
specs/features/, specs/needs.md, specs/command-line-contract.md, tests/acceptance/, tests/fixtures/

## Where you may write
src/, tests/unit/, specs/plans/

## Technology
Python, packaged with uv. Package name: information_to_knowledge_schema_mapper.
Storage: SQLite. No network access. No LLM calls.

## Naming
No abbreviations or acronyms. Descriptive verb plus object, two to three words.
Dashes for files and commands. Underscores for Python modules and functions (PEP 8).

## Commands
- Tests: uv run pytest -q
- Lint: uv run ruff check .
EOF

write_if_empty "${MAPPER}/specs/needs.md" <<'EOF'
# Business needs

| ID | Need | In v0 |
|---|---|---|
| 1.1.2.1 | Build decks of flashcards for any topic | yes |
| 1.1.2.2 | Facilitate learning and connecting knowledge | backlog |
| 1.1.2.3 | Make analogies | backlog |
| 1.1.2.4 | Improve knowledge quality (definition pending) | backlog |
| 1.1.2.5 | Ask more questions | backlog |
| 1.1.2.6 | Relationships between concepts are stable | yes |

## Acceptance criteria for v0
- 1.1.2.1: a deck contains exactly one card per concept that has a definition,
  plus one card per relationship.
- 1.1.2.6: the graph survives a process restart, and a relationship to a missing concept is rejected.
EOF

write_if_empty "${MAPPER}/specs/command-line-contract.md" <<'EOF'
# Command-line contract (v0)

Program name: information-to-knowledge-schema-mapper

## import-concept-graph
    information-to-knowledge-schema-mapper import-concept-graph <graph-file> --database-path <path>
- Reads a YAML graph file (format below) and stores it in the SQLite database at <path>.
- The import is all or nothing: on any error, nothing is stored.
- Exit code 0 on success.
- Exit code 1 with a message on stderr on any error, including a relationship
  whose source or target concept does not exist.

## generate-flashcard-deck
    information-to-knowledge-schema-mapper generate-flashcard-deck --database-path <path>
- Prints one card per line to stdout, as: front<TAB>back
- Concept card, only for concepts with a definition:
  front "What is {name}?", back "{definition}"
- Relationship card:
  front "How does {source} relate to {target}?", back "{source} {type} {target}"
- Card order is not specified.
- Exit code 0 on success, 1 with a message on stderr on error.

## Graph file format
    concepts:
      - name: <unique name>
        definition: <text>       # optional
        tags: [<text>, ...]      # optional
        questions: [<text>, ...] # optional
    relationships:
      - source: <concept name>
        target: <concept name>
        type: is-a | part-of | causes | prerequisite-of | contrasts-with

## Storage rules
- Data persists in the SQLite file across separate processes.
- A relationship may only reference concepts that exist.
EOF

write_if_empty "${MAPPER}/specs/backlog.md" <<'EOF'
# Backlog (not in v0: do not implement)

- Needs 1.1.2.2 to 1.1.2.5 (see needs.md)
- Export the deck as an Anki-importable file
- Byte-identical output for the same graph
- Rules for duplicate relationships, self-relationships and two-way relationship types
- Renaming a concept while keeping its relationships
- Delete behaviour for a concept that has relationships
- Graph metrics: unconnected concepts, clusters, cards per concept, open questions per concept
- Extracting concepts from text
EOF

echo
echo "Done. Not touched on purpose: ROADMAP.md, *.feature files, tests/fixtures/claude-code.yaml (yours to write)."