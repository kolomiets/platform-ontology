
#!/usr/bin/env bash
set -euo pipefail

DATA="dist/ontology.ttl data/samples/demo.ttl"
JOINED="dist/test-union.ttl"

mkdir -p dist
riot --formatted=TURTLE $DATA > $JOINED

fail=0

run_folder () {
  folder=$1; mode=$2
  for q in tests/sparql/${folder}/*.rq; do
    [ -e "$q" ] || continue
    echo "SPARQL ${mode^^}: $q"
    out=$(arq --data=$JOINED --query=$q --results=CSV || true)
    rows=$(echo "$out" | sed -n '2,$p' | wc -l | tr -d ' ')
    if [ "$mode" = "empty" ] && [ "$rows" -ne 0 ]; then echo "❌ Expected empty, got $rows"; fail=1; fi
    if [ "$mode" = "nonempty" ] && [ "$rows" -eq 0 ]; then echo "❌ Expected rows, got 0"; fail=1; fi
  done
}

run_folder must_be_empty empty
run_folder must_have_results nonempty

if [ $fail -ne 0 ]; then exit 1; fi
echo "✅ SPARQL tests passed"
