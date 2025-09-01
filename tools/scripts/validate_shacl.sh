
#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
import yaml, subprocess, sys
cfg = yaml.safe_load(open('tests/shacl/suites.yaml'))
failures=[]
for case in cfg:
  data=case['data']
  for shapes in case['shapes']:
    print(f"SHACL: {data} ⟂ {shapes}")
    r = subprocess.run(['pyshacl','-s',shapes,'-d',data,'-f','human','-m','-a'], capture_output=True, text=True)
    print(r.stdout)
    if r.returncode!=0:
      print(r.stderr)
      failures.append((data,shapes))
if failures:
  print("\n❌ SHACL failures:")
  for d,s in failures: print(f"  - {d} vs {s}")
  sys.exit(1)
print("\n✅ SHACL all passed")
PY
