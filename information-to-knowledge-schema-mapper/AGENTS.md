# information-to-knowledge-schema-mapper

## Meaning of "schema"
"Schema" here is the learning-science term: a network of connected concepts in a learner's mind,
including the open questions the learner has about them. In the app, both are nodes of the concept graph,
with node type concept or question.
It is NOT a datastore schema and NOT a JSON schema.

## Scope of v0
Only three commands: import-concept-graph, generate-flashcard-deck and answer-metric-questions.
Out of scope: extracting concepts from text, AI features, user interface, export formats.
Everything else is in [specs/backlog.md](specs/backlog.md). Do not implement backlog items.

## Definition of done
All scenarios in specs/features/ pass through tests/acceptance/.
The command-line interface follows [specs/command-line-contract.md](specs/command-line-contract.md) exactly.
Needs and their metrics: [specs/needs.md](specs/needs.md), [specs/application-metrics.md](specs/application-metrics.md).

## Protected paths (never edit)
specs/features/, specs/needs.md, specs/command-line-contract.md, specs/application-metrics.md,
tests/acceptance/, tests/fixtures/

## Where you may write
src/, tests/unit/, specs/plans/, pyproject.toml, uv.lock

## Technology
Python, packaged with uv.
Storage: any local datastore at the --datastore-path the user gives. No network access. No LLM calls.

## Naming
No abbreviations or acronyms. Descriptive verb plus object, two to three words.
Dashes for files and commands. Underscores for Python modules and functions (PEP 8).

## Commands
- Tests: uv run pytest -q
- Lint: uv run ruff check .
