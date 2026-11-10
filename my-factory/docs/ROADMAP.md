# Roadmap (draft, to refine further)

Reference: SSSF @ de31374

Recreate reference: git clone https://github.com/disler/super-simple-software-factory reference/sssf && git -C reference/sssf checkout de31374

**Goal:** one command runs my factory on the mapper's specs, and the result is a working
information-to-knowledge-schema-mapper that passes its acceptance tests, with no code edited by me.

**Approach:** copy and adapt SSSF code where it helps; every copied file is explained and listed
in docs/copied-from-reference.md. Models: remote first, local mixed in later.

| Step | I can… | How I check | Status |
|---|---|---|---|
| 1 | Ask a remote model a question through Pi, the coding agent the factory uses | One command prints an answer; the call shows on the provider's usage page | not started |
| 2 | Run SSSF's own demo on my machine | just demo finishes green and the run shows in its log | not started |
| 3 | Point the mapper at a finished spec: 4 scenarios, their test steps and the test graph (my work) | uv run pytest runs the 4 scenarios and all fail (nothing built yet) | not started |
| 4 | Run my factory's first step: it reads the mapper's spec and writes a plan | A plan file appears in specs/plans/ and the run is logged | not started |
| 5 | Run my factory from plan to tested code: plan, build, test, retry on failure | The factory reports pass or fail by itself and the run is logged | not started |
| 6 | Goal reached: the factory produces a mapper that passes all 4 scenarios | Tests green, and git diff -- information-to-knowledge-schema-mapper/src/ shows no edits by me | not started |
| 7 | (Later) Same result in 3 of 5 runs | Run report for the last 5 runs | not started |
| 8 | (Later) Mix in a local model (Ollama on the M3 Max) for one light role | That role's runs show the local model in the log; network-off test passes for it | not started |
