# Command-line contract (v0)

Purpose: transform a drawing made in draw.io into the schema (stored as the concept graph),
a flashcard deck, and answers to where the schema is not yet cohesive.

## import-concept-graph
    information-to-knowledge-schema-mapper import-concept-graph <drawing-file> --database-path <path>
- Reads an uncompressed draw.io file, transforms it into the schema (transformation rules below)
  and stores it as the concept graph in the database at <path>.
- If any arrow is not connected at both ends, the import fails and nothing is stored.

## generate-flashcard-deck
    information-to-knowledge-schema-mapper generate-flashcard-deck --database-path <path>
- Prints one card per line, in any order, as: front<TAB>back
- Per concept with a definition: front "What is {name}?", back "{definition}"
- Per relationship with a type: front "How does {source} relate to {target}?", back "{source} {type} {target}"

## answer-metric-questions
    information-to-knowledge-schema-mapper answer-metric-questions --database-path <path>
- Answers the questions defined in specs/application-metrics.md, one line per metric, in this order:
  concepts-connected, relationships-named, questions-present.
- Each line is metric-id<TAB>yes, or metric-id<TAB>no<TAB>item; item; ...
- Items for concepts-connected: the concepts outside the largest connected group.
- Items for relationships-named: the relationships without a type, as "{source} -> {target}".
- Items may be in any order.

## All commands
- Exit code 0 on success; 1 with a message on stderr on any error.
- The database keeps the graph between runs.

## Transformation rules: drawing into schema
The learner makes the drawing in draw.io, outside the app. import-concept-graph only transforms it,
by these rules:
1. A box is a node of the concept graph. Its node type is question if its text ends with "?", otherwise concept.
2. A concept's line 1 is its name; further lines, joined by spaces, are its definition.
3. An arrow between a question and a concept attaches the question to that concept.
4. An arrow from one concept to another is a relationship. Its label is the type and may be empty.
5. Every arrow must be connected at both ends.
