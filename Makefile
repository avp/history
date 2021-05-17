DEPS=history.adoc adoc/*.adoc themes/*.yml themes/*.css

all: history.epub history.pdf history.html
.PHONY: all

history.epub: $(DEPS)
	asciidoctor-epub3 -v -a env-epub history.adoc

history.pdf: $(DEPS)
	asciidoctor-pdf -v -a env-pdf history.adoc

history.html: $(DEPS)
	asciidoctor -v -a env-html history.adoc

watch: $(DEPS)
	watch make history.html
.PHONY: watch

clean:
	$(RM) history.epub
	$(RM) history.pdf
	$(RM) history.html
.PHONY: clean
