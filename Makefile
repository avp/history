DEPS=history.adoc adoc/*.adoc themes/*.yml themes/*.css

all: epub pdf
.PHONY: all

upload: upload-epub upload-pdf
.PHONY: upload

upload-epub: epub
	aws s3 cp history.epub s3://history.avp42.com
.PHONY: upload-epub

upload-pdf: pdf
	aws s3 cp history.pdf s3://history.avp42.com
.PHONY: upload-pdf

epub: $(DEPS)
	asciidoctor-epub3 -a env-epub history.adoc
.PHONY: epub

pdf: $(DEPS)
	asciidoctor-pdf -a env-pdf history.adoc
.PHONY: pdf

html: $(DEPS)
	asciidoctor -a env-html history.adoc
.PHONY: html

watch: $(DEPS)
	watch make html

clean:
	$(RM) history.epub
	latexmk -C
.PHONY: clean

