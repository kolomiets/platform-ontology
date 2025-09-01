
#!/usr/bin/env bash
set -euo pipefail
mkdir -p dist
echo "⏳ Reasoning with ELK..."
java -jar /opt/robot.jar reason   --input src/ontology.ttl   --reasoner ELK   --equivalent-classes-allowed all   --output dist/ontology.reasoned.ttl

echo "⏳ Running ROBOT report..."
java -jar /opt/robot.jar report   --input src/ontology.ttl   --fail-on WARN   --output dist/robot-report.csv

echo "✅ Reasoning + report completed"
