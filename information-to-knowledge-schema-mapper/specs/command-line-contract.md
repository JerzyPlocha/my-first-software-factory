# Command-line contract (v0)

Purpose: transform a drawing made in draw.io into the schema (stored as the concept graph),
a flashcard deck, and answers to where the schema is not yet cohesive.
Needs: [needs.md](needs.md). Metrics: [application-metrics.md](application-metrics.md).

## import-concept-graph
    information-to-knowledge-schema-mapper import-concept-graph <drawing-file> --datastore-path <path>
- Needs: [1.1.2.6](needs.md#need-1.1.2.6), [1.1.2.7](needs.md#need-1.1.2.7).
- Reads an uncompressed draw.io file, transforms it into the schema (transformation rules below)
  and stores it as the concept graph in the datastore at <path>.
- Prints the stored schema as a list, one line per item, in any order:
  concept<TAB>{name}, relationship<TAB>{source} -> {target}<TAB>{type}, question<TAB>{text}<TAB>{concept}
- If any arrow is not connected at both ends, the import fails and nothing is stored.

## generate-flashcard-deck
    information-to-knowledge-schema-mapper generate-flashcard-deck --datastore-path <path>
- Need: [1.1.2.1](needs.md#need-1.1.2.1).
- Prints one card per line, in any order, as: front<TAB>back
- Per concept with a definition: front "What is {name}?", back "{definition}"
- Per relationship with a type: front "How does {source} relate to {target}?", back "{source} {type} {target}"

## answer-metric-questions
    information-to-knowledge-schema-mapper answer-metric-questions --datastore-path <path>
- Answers the questions defined in [specs/application-metrics.md](application-metrics.md), one line per metric, in this order:
  [cards-available](application-metrics.md#cards-available),
  [concepts-connected](application-metrics.md#concepts-connected),
  [relationships-named](application-metrics.md#relationships-named),
  [questions-present](application-metrics.md#questions-present),
  [schema-stored](application-metrics.md#schema-stored).
- Each line is metric-id<TAB>yes, or metric-id<TAB>no<TAB>item; item; ...
- Items for [concepts-connected](application-metrics.md#concepts-connected): the concepts outside the largest connected group.
- Items for [relationships-named](application-metrics.md#relationships-named): the relationships without a type, as "{source} -> {target}".
- Other metrics have no items. Items may be in any order.

## All commands
- Exit code 0 on success; 1 with a message on stderr on any error.
- The datastore keeps the graph between runs.

## Transformation rules: drawing into schema
The learner makes the drawing in draw.io, outside the app. [import-concept-graph](#import-concept-graph) only transforms it,
by these rules:
1. A box is a node of the concept graph. Its node type is question if its text ends with "?", otherwise concept.
2. A concept's line 1 is its name; further lines, joined by spaces, are its definition, which may be empty.
3. An arrow between a question and a concept attaches the question to that concept.
4. An arrow from one concept to another is a relationship. Its label is the type and may be empty.
5. Every arrow must be connected at both ends.
6. Only the first page of the drawing is read; further pages are free for notes.
7. Text formatting such as bold is ignored; a line break counts as a new line.
