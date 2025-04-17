# Cypher query examples


## Simple query that returns the TP53 gene node

``` bash
MATCH (n:Gene {id: 'TP53'}) RETURN n
```

## Return Disease nodes that contain the string ‘chronic’ in their name

``` bash
MATCH (n:Disease) WHERE n.name CONTAINS 'chronic' RETURN n LIMIT 25
```

## Generate NOTCH1-specific CLL subgraph

``` bash
MATCH (o:Drug)-[i]-(z:Gene {id: "NOTCH1"})-[q]-(d:Protein)-[r]-(g:Disease {name: "chronic lymphocytic leukemia"}),
      (z)-[:RELATED_TO]-(s:Gene)
RETURN d, r, g, z, q, o, i, s
```

## Generate a CLL-specific 4-type of nodes subgraph

``` bash
MATCH (o:Drug)-[i]-(z:Gene)-[q]-(d:Protein)-[r]-(g:Disease {name: "chronic lymphocytic leukemia"})
RETURN d, r, g, z, q, o, i
```