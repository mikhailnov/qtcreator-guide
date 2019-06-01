all: build

build:
	latexmk -xelatex -synctex=1 -jobname=presentation main.tex

run: build clean
	xdg-open presentation.pdf

clean:
	rm *.aux \
	*.fdb_latexmk \
	*.fls \
	*.log \
	*.out \
	*.synctex.gz \
	*.toc \
	*.snm \
	*.nav
