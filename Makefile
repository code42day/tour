PROJECT=tour

all: check compile

check: lint

lint:
	jshint index.js

compile: build/build.js build/build.css

build:
	mkdir -p $@

build/build.js: node_modules index.js | build
	browserify --require ./index.js:$(PROJECT) --outfile $@

.DELETE_ON_ERROR: build/build.js

build/build.css: \
	node_modules/@pirxpilot/overlay/overlay.css \
	node_modules/@pirxpilot/confirmation-popover/popover.css \
	node_modules/@pirxpilot/tip/tip.css \
	| build
	cat $^ > $@

node_modules: package.json
	yarn && touch $@

clean:
	rm -fr build node_modules

.PHONY: clean lint check all build
