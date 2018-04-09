.PHONY: deploy dependencies help

.DEFAULT_GOAL = help


require-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "ERROR: Environment variable not set: \"$*\""; \
		exit 1; \
	fi

## deploy dependencies
dependencies:
	@helm --debug \
		upgrade \
		--install \
		-f settings.yaml \
		--set phase1=true \
		fpco-monitoring . \
		--namespace=monitoring

## deploy fpco kube monitoring
deploy:
	@helm --debug \
		upgrade \
		-f settings.yaml \
		--install \
		fpco-monitoring . \
		--set phase1=true \
		--set phase2=true \
		--namespace=monitoring

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

