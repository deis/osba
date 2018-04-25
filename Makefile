.PHONY: docs preview
build:
	./scripts/docs.sh generate "osba.sh"

preview:
	./scripts/docs.sh preview "osba.sh"
