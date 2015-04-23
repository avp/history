all: history.epub

.PHONY: all

epub: history.epub

.PHONY: epub

history.epub: history.tex tex/*.tex cover.jpg
	pandoc history.tex -o $@ --epub-cover-image cover.jpg

clean:
	$(RM) history.epub
.PHONY: clean
