DEPS=history.tex tex/*.tex cover.jpg

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
	pandoc -f latex history.tex -t epub3 -o history.epub --epub-cover-image cover.jpg
.PHONY: upload-epub

pdf: $(DEPS)
	latexmk -pdf -quiet -pdflatex=pdflatex --shell-escape history.tex
.PHONY: upload-pdf

clean:
	$(RM) history.epub
	latexmk -C
.PHONY: clean
