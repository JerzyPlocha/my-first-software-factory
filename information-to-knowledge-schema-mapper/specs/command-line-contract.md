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
