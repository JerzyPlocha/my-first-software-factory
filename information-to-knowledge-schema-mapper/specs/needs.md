# Business needs

| ID | Need | In v0 |
|---|---|---|
| 1.1.2.1 | Build decks of flashcards for any topic | yes |
| 1.1.2.2 | Facilitate learning and connecting knowledge | part |
| 1.1.2.3 | Make analogies | backlog |
| 1.1.2.4 | Improve knowledge quality (definition pending) | backlog |
| 1.1.2.5 | Ask more questions | part |
| 1.1.2.6 | Relationships between concepts are stable | yes |
| 1.1.2.7 | Capture concepts, relationships and questions by drawing them | yes |

## Acceptance criteria for v0

### 1.1.2.7 Capture by drawing
- 1.1.2.7.1 A box becomes a node of type concept: line 1 is its name, further lines are its definition.
- 1.1.2.7.2 A box whose text ends with "?" becomes a node of type question, attached to the concept
  its arrow connects to; that arrow is not a relationship.
- 1.1.2.7.3 An arrow between two concepts becomes a relationship; its label, if any, is the type.

### 1.1.2.1 Flashcards
- 1.1.2.1.1 One card per concept that has a definition.
- 1.1.2.1.2 One card per relationship that has a type.
- 1.1.2.1.3 No card for anything else: concepts without a definition, relationships without a type, question nodes.

### 1.1.2.2 Connecting knowledge (part)
- 1.1.2.2.1 The app answers yes or no: is every concept connected to the rest as one whole?
  A "no" names the concepts outside.
- 1.1.2.2.2 The app answers yes or no: does every relationship have a type?
  A "no" names the relationships without one.

### 1.1.2.5 Ask more questions (part)
- 1.1.2.5.1 The app answers yes or no: does the concept graph hold at least one question node?

### 1.1.2.6 Stability
- 1.1.2.6.1 The graph is still there in a later, separate run.
- 1.1.2.6.2 An arrow not connected at both ends rejects the whole import; nothing is stored.
