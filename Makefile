all: epub pdf
.PHONY: all

upload: all
	aws s3 cp history.pdf s3://history.avp42.com
	aws s3 cp history.epub s3://history.avp42.com
.PHONY: upload

epub: history.tex tex/*.tex cover.jpg
	pandoc history.tex -o history.epub --epub-cover-image cover.jpg

pdf: history.tex tex/*.tex cover.jpg
	latexmk -pdf -quiet -pdflatex=pdflatex --shell-escape history.tex
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
		-dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH \
		-sOutputFile=/tmp/history.pdf history.pdf
	mv /tmp/history.pdf history.pdf

clean:
	$(RM) history.epub
	latexmk -C
.PHONY: clean
