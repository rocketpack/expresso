
PREFIX ?= /usr/local
BIN = bin/expresso
DOCS = docs/index.md
HTMLDOCS = $(DOCS:.md=.html)

test: $(BIN)
	@./$(BIN) --growl $(TEST_FLAGS)

test-cov:
	@./$(BIN) -I lib --cov $(TEST_FLAGS)

test-serial:
	@./$(BIN) --serial $(TEST_FLAGS) test/serial/*.test.js

install: install-expresso

uninstall:
	rm -f $(PREFIX)/bin/expresso

install-expresso:
	install $(BIN) $(PREFIX)/bin

docs: docs/api.html $(HTMLDOCS)

%.html: %.md
	@echo "... $< > $@"
	@ronn --html $< \
		| cat docs/layout/head.html - docs/layout/foot.html \
		> $@

docs/api.html: bin/expresso
	dox \
		--title "Expresso" \
		--ribbon "http://github.com/visionmedia/expresso" \
		--desc "Insanely fast TDD framework for [node](http://nodejs.org) featuring code coverage reporting." \
		$< > $@

docclean:
	rm -f docs/*.html

.PHONY: test test-cov install uninstall install-expresso clean docs docclean
