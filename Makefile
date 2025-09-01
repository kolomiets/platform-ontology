
DOCKERIMAGE=ontology-kit:latest
DOCKER=docker run --rm -v $(PWD):/workspace -w /workspace $(DOCKERIMAGE)
SRC=src/ontology.ttl
DIST=dist
DOCS=docs

all: clean build verify serialize docs test

clean:
	@rm -rf $(DIST) $(DOCS); mkdir -p $(DIST)

build:
	docker build -t $(DOCKERIMAGE) tools/docker

verify:
	$(DOCKER) -lc "tools/scripts/reason_and_report.sh"

serialize:
	$(DOCKER) -lc "tools/scripts/build_serializations.sh"

docs:
	$(DOCKER) -lc "mkdir -p $(DOCS) && java -jar /opt/widoco.jar -ontFile $(SRC) -outFolder $(DOCS) -rewriteAll -getOntologyMetadata -noPlaceHolderText -doNotDisplaySerializations -oops -webVowl"

test: shacl sparql

shacl:
	$(DOCKER) tools/scripts/validate_shacl.sh

sparql:
	$(DOCKER) tools/scripts/run_sparql_tests.sh