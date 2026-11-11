# Business needs

| ID | Need | In v0 | Answered by |
|---|---|---|---|
| <a id="need-1.1.2.1"></a>1.1.2.1 | Build decks of flashcards for any topic | yes | metric [cards-available](application-metrics.md#cards-available) |
| <a id="need-1.1.2.2"></a>1.1.2.2 | Facilitate learning and connecting knowledge | part | metrics [concepts-connected](application-metrics.md#concepts-connected), [relationships-named](application-metrics.md#relationships-named) |
| <a id="need-1.1.2.3"></a>1.1.2.3 | Make analogies | backlog | [backlog.md](backlog.md) |
| <a id="need-1.1.2.4"></a>1.1.2.4 | Improve knowledge quality (definition pending) | backlog | [backlog.md](backlog.md) |
| <a id="need-1.1.2.5"></a>1.1.2.5 | Ask more questions | part | metric [questions-present](application-metrics.md#questions-present) |
| <a id="need-1.1.2.6"></a>1.1.2.6 | Relationships between concepts are stable | yes | metric [schema-stored](application-metrics.md#schema-stored) |
| <a id="need-1.1.2.7"></a>1.1.2.7 | Capture concepts, relationships and questions by drawing them | part | [the schema printed as a list after import](command-line-contract.md#import-concept-graph) |

Metrics are defined in [application-metrics.md](application-metrics.md) and answered yes or no by
[answer-metric-questions](command-line-contract.md#answer-metric-questions).

## Acceptance criteria for v0

### 1.1.2.7 Capture by drawing (part)
Need: [1.1.2.7](#need-1.1.2.7). Command: [import-concept-graph](command-line-contract.md#import-concept-graph).
- 1.1.2.7.1 After import, the app prints the schema as a list: each concept, relationship and question it recognized.

### 1.1.2.1 Flashcards
Need: [1.1.2.1](#need-1.1.2.1). Command: [generate-flashcard-deck](command-line-contract.md#generate-flashcard-deck).
- 1.1.2.1.1 One card per concept that has a definition.
- 1.1.2.1.2 One card per relationship that has a type.
- 1.1.2.1.3 No card for anything else: concepts without a definition, relationships without a type, question nodes.

### 1.1.2.6 Stability
Need: [1.1.2.6](#need-1.1.2.6). Command: [import-concept-graph](command-line-contract.md#import-concept-graph).
- 1.1.2.6.1 The schema is still there in a later, separate run.
- 1.1.2.6.2 An arrow not connected at both ends rejects the whole import; nothing is stored.
