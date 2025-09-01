
#!/usr/bin/env bash
set -euo pipefail
mkdir -p dist
riot --formatted=TURTLE src/ontology.ttl > dist/ontology.ttl
riot --formatted=RDFXML src/ontology.ttl > dist/ontology.rdf
riot --formatted=JSONLD src/ontology.ttl > dist/ontology.jsonld
echo "✅ Serializations created in dist/"
