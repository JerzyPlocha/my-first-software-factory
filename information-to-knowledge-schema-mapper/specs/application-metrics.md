# Application metrics (v0)

Each row is one question the app answers with yes or no, through
[answer-metric-questions](command-line-contract.md#answer-metric-questions).
The need column links back to [needs.md](needs.md).

| metric_id | need | factor_node | question | scale | success_threshold_value | failed_value | scale_type | diagnostic_goal | intervention_trigger | data_source |
|---|---|---|---|---|---|---|---|---|---|---|
| <a id="concepts-connected"></a>concepts-connected | [1.1.2.2](needs.md#need-1.1.2.2) | Mental Model Architecture | Is every concept connected to the rest as one whole? | yes \| no | yes | no (names the concepts outside the largest connected group) | Nominal | Detect isolated knowledge that is not yet part of the schema. | Connect each concept outside with a named relationship or ask why it stands apart. | The concept graph: concept nodes and relationships |
| <a id="concepts-defined"></a>concepts-defined | [1.1.2.2](needs.md#need-1.1.2.2) | Active Generation | Does every concept have a definition? | yes \| no | yes | no (names the concepts without a definition) | Nominal | Make sure every concept is explained, not only named. | Write each missing definition from memory, in your own words. | The concept graph: concept definitions |
| <a id="relationships-named"></a>relationships-named | [1.1.2.2](needs.md#need-1.1.2.2) | Active Generation | Does every relationship say how its concepts relate? | yes \| no | yes | no (names the relationships without a type) | Nominal | Turn vague links into explained relationships. | Ask yourself: how are {source} and {target} related, and why? Then write the answer as the arrow's label. | The concept graph: relationship types |
| <a id="questions-present"></a>questions-present | [1.1.2.5](needs.md#need-1.1.2.5) | Targeted Questioning | Does the concept graph hold at least one question node? | yes \| no | yes | no (only locked conclusions) | Nominal | Make confusion visible as questions instead of hiding it in conclusions. | Attach a question to the concept you are least sure about. | The concept graph: question nodes |
| <a id="schema-stored"></a>schema-stored | [1.1.2.6](needs.md#need-1.1.2.6) | Stability | Does the datastore hold the imported schema? | yes \| no | yes | no (nothing imported, or the import failed) | Nominal | Confirm the schema survives between runs. | Import the diagram again and check that every arrow is connected at both ends. | The datastore |
