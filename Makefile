DEPS=history.adoc adoc/*.adoc themes/*.yml

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
	asciidoctor-epub3 history.adoc
.PHONY: epub

pdf: $(DEPS)
	asciidoctor-pdf -a pdf-themesdir=themes/ -a pdf-theme=history.yml -a pdf-fontsdir=fonts/ history.adoc
.PHONY: pdf

html: $(DEPS)
	asciidoctor history.adoc
.PHONY: html

clean:
	$(RM) history.epub
	latexmk -C
.PHONY: clean
