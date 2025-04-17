---
title: "louvain_community_detection"
output: html_document
---

# Louvain Community Detection [neo4j/ckg]

## Neo4j characteristics

Neo4j version 4.2.19 GDS version 1.5.1

## Note:

Each time you run the following queries change - Gene.id (e.g. "NOTCH1") \* STEP 1 *- n (e.g. MySubgraphNode )* STEPS 1, 2 & 5 *- Subgraph name (e.g. 'MySubgraph')* STEP 2 & 6 \*

## STEP 1: Generate the gene-specific subgraph

``` bash
MATCH (o:Drug)-[:CURATED_TARGETS]-(z:Gene {id: "NOTCH1"})-[:TRANSLATED_INTO]-(d:Protein)-[:ASSOCIATED_WITH]-(g:Disease {name: "chronic lymphocytic leukemia"}), 
      (z)-[:RELATED_TO]-(s:Gene)
WITH collect(o) + collect(z) + collect(d) + collect(g) + collect(s) AS allNodes
UNWIND allNodes AS n
SET n:MySubgraphNode
```

## STEP 2: Create and save the subgraph

``` bash
CALL gds.graph.create(
  'MySubgraph',
  {
    SubgraphNode: {
      label: 'MySubgraphNode'
    }
  },
  {
    ALL: {
      type: '*',
      orientation: 'UNDIRECTED'
    }
  }
)
```

## STEP 3: Run Louvain Community Detection

``` bash
CALL gds.louvain.write('MySubgraph', {
  writeProperty: 'community'
})
YIELD communityCount, modularity
```

## STEP 4: Check the graphs you creted

``` bash
CALL gds.graph.list()
```

## STEP 5: Delete the node labels you created

``` bash
MATCH (n:MySubgraphNode)
REMOVE n:MySubgraphNode
```

## STEP 6: Delete the subgraph from memory

``` bash
CALL gds.graph.drop('MySubgraph');
```
