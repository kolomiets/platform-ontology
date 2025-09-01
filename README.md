
# Ontology Kit (Starter)

A minimal, Dockerized setup for ontology development with:

- Multi-format serializations (TTL, RDF/XML, JSON-LD)
- Reasoning and ROBOT report
- SHACL validation suites
- SPARQL assertion tests
- One-command build via `make`
- GitHub Actions CI for build + docs + releases

## Quickstart

```bash
# Build tool image
docker build -t ontology-kit:latest tools/docker

# Run full pipeline locally
make

# Run tests only
make test
```
