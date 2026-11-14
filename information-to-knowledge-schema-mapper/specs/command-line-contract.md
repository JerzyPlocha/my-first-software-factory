# Command-line contract (v0)

Purpose: transform a diagram made in draw.io into the schema (stored as the concept graph),
and answer where the schema is not yet deep and cohesive.
Needs: [needs.md](needs.md). Metrics: [application-metrics.md](application-metrics.md).

## import-concept-graph
    information-to-knowledge-schema-mapper import-concept-graph <diagram-file> --datastore-path <path>
- Needs: [1.1.2.6](needs.md#need-1.1.2.6), [1.1.2.7](needs.md#need-1.1.2.7).
- Reads an uncompressed draw.io diagram, transforms it into the schema (transformation rules below)
  and stores it as the concept graph in the datastore at <path>.
- Prints the stored schema as a list, one line per item, in any order:
  concept<TAB>{name}, relationship<TAB>{source} -> {target}<TAB>{type}, question<TAB>{text}<TAB>{concept}
- If any arrow is not connected at both ends, the import fails and nothing is stored.

## answer-metric-questions
    information-to-knowledge-schema-mapper answer-metric-questions --datastore-path <path>
- Answers the questions defined in [specs/application-metrics.md](application-metrics.md), one line per metric, in this order:
  [concepts-connected](application-metrics.md#concepts-connected),
  [concepts-defined](application-metrics.md#concepts-defined),
  [relationships-named](application-metrics.md#relationships-named),
  [questions-present](application-metrics.md#questions-present),
  [schema-stored](application-metrics.md#schema-stored).
- Each line is metric-id<TAB>yes, or metric-id<TAB>no<TAB>item; item; ...
- Items for [concepts-connected](application-metrics.md#concepts-connected): the concepts outside the largest connected group.
- Items for [concepts-defined](application-metrics.md#concepts-defined): the concepts without a definition.
- Items for [relationships-named](application-metrics.md#relationships-named): the relationships without a type, as "{source} -> {target}".
- Other metrics have no items. Items may be in any order.

## All commands
- Exit code 0 on success; 1 with a message on stderr on any error.
- The datastore keeps the graph between runs.

## Transformation rules: diagram into schema
The learner makes the diagram in draw.io, outside the app. [import-concept-graph](#import-concept-graph) reads it
by these rules:
1. A box is a node of the concept graph. Its node type is question if its text ends with "?", otherwise concept.
2. A concept's line 1 is its name; further lines, joined by spaces, are its definition, which may be empty.
3. An arrow between a question and a concept attaches the question to that concept.
4. An arrow from one concept to another is a relationship. Its label is the type and may be empty.
5. Every arrow must be connected at both ends.
6. Only the first page of the diagram is read; further pages are free for notes.
7. Text formatting such as bold is ignored; a line break counts as a new line.
8. The app never removes or changes what the learner drew. It may add to the schema,
   for example a missing definition, relationship type, relationship or question.
