.PHONY: help

DEFAULT_GOAL: help

require-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "ERROR: Environment variable not set: \"$*\""; \
		exit 1; \
	fi

## Builds base image
build-base:
	@cd base && docker build -t locust .

## Build standard test image
build-standard:
	@cd standard && docker build -t loadtest:standard .

## Build broken test image
build-broken:
	@cd broken && docker build -t loadtest:broken .

## Build slow test image
build-slow:
	@cd slow && docker build -t loadtest:slow .

## Run standard load test
run-standard:
	@docker run -it -p 8089:8089 loadtest:standard --host=https://example-monitored-app.fpcomplete.com

## Run slow load test
run-slow:
	@docker run -it -p 8089:8089 loadtest:slow --host=https://example-monitored-app.fpcomplete.com

## Run broken load test
run-broken:
	@docker run -it -p 8089:8089 loadtest:broken --host=https://example-monitored-app.fpcomplete.com


## Show help screen.
help:
	@echo "Please use \`make <target>' where <target> is one of\n\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-30s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

