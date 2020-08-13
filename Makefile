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

epub: $(DEPS) pdf
	convert history.pdf[0] pdfcover.jpg
	pandoc -f latex history.tex -t epub3 -o history.epub --epub-cover-image pdfcover.jpg
.PHONY: epub

pdf: $(DEPS)
	asciidoctor-pdf -a pdf-themesdir=themes/ -a pdf-theme=history.yml -a pdf-fontsdir=fonts/ history.adoc
.PHONY: pdf

html: $(DEPS)
	asciidoctor -a pdf-themesdir=themes/ -a pdf-theme=history.yml -a fontsdir=fonts/ history.adoc
.PHONY: pdf


clean:
	$(RM) history.epub
	latexmk -C
.PHONY: clean
