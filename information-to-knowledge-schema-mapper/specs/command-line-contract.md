# Command-line contract (v0)

Purpose: turn a concept graph drawn in draw.io into a stored concept graph, a flashcard deck,
and answers to where the graph is not yet cohesive.

## import-concept-graph
    information-to-knowledge-schema-mapper import-concept-graph <drawing-file> --database-path <path>
- Reads an uncompressed draw.io file (drawing rules below) and stores its concept graph in the database at <path>.
- If any arrow is not connected at both ends, nothing is stored.

## generate-flashcard-deck
    information-to-knowledge-schema-mapper generate-flashcard-deck --database-path <path>
- Prints one card per line, in any order, as: front<TAB>back
- Per concept with a definition: front "What is {name}?", back "{definition}"
- Per relationship with a type: front "How does {source} relate to {target}?", back "{source} {type} {target}"

## answer-metric-questions
    information-to-knowledge-schema-mapper answer-metric-questions --database-path <path>
- Answers each question in specs/application-metrics.md, one line per metric, in table order:
  metric-id<TAB>yes, or metric-id<TAB>no<TAB>item; item; ...
- Items for concepts-connected: the concepts outside the largest connected group.
- Items for relationships-named: the relationships without a type, as "{source} -> {target}".
- Items may be in any order.

## All commands
- Exit code 0 on success; 1 with a message on stderr on any error.
- The database keeps the graph between runs.

## Drawing rules
1. A box is a concept: line 1 is its name; further lines, joined by spaces, are its definition.
2. A box whose text ends with "?" is a question, not a concept. An arrow between it and a concept attaches it.
3. An arrow from one concept to another is a relationship. Its label is the type and may be empty.
4. Every arrow must be connected at both ends.
