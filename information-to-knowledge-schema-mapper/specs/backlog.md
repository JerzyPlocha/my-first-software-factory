# Backlog (not in v0: do not implement)

## Needs
- Needs 1.1.2.3 and 1.1.2.4, and the parts of 1.1.2.2 and 1.1.2.5 beyond v0 (see needs.md)

## Input
- Graph files written by hand (YAML)
- Compressed draw.io files
- Miro boards as input (Miro's exports leave out connectors; its API needs a token and network access)
- Extracting concepts from text with AI, as readable input to correct before importing
- Tags on concepts
- Questions as a field of a concept (v0 uses question boxes)
- A question on a relationship, written as an arrow label ending with "?"
- A fixed list of relationship types
- Duplicate box names
- Rules for duplicate relationships, self-relationships and two-way relationship types
- Renaming a concept while keeping its relationships
- Delete behaviour for a concept that has relationships

## Output
- Export the deck as an Anki-importable file
- Byte-identical output for the same graph
- Printing the intervention with each metric answer

## Metrics (v0 metrics are in application-metrics.csv)
- Every concept has a definition
- Every question is attached to a concept (targeted questions)
- Clusters, cards per concept, open questions per concept
- GRINDE visual principles: grouped, emphasized, non-verbal
- Learning-session metrics: cognitive friction, metacognitive monitoring, recall type, disconfirming queries
