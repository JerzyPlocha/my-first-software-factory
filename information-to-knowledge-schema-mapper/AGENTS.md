# information-to-knowledge-schema-mapper

## Meaning of "schema"
"Schema" here is the learning-science term: a network of connected concepts in a learner's mind.
It is NOT a database schema and NOT a JSON schema.

## Scope of v0
Only three commands: import-concept-graph, generate-flashcard-deck and answer-metric-questions.
Out of scope: extracting concepts from text, AI features, user interface, export formats.
Everything else is in specs/backlog.md. Do not implement backlog items.

## Definition of done
All scenarios in specs/features/ pass through tests/acceptance/.
The command-line interface follows specs/command-line-contract.md exactly.

## Protected paths (never edit)
specs/features/, specs/needs.md, specs/command-line-contract.md, specs/application-metrics.md,
tests/acceptance/, tests/fixtures/

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
