HOMEDIR = $(shell echo ${HOME})
FONTSDIR = $(HOMEDIR)/.local/share/fonts

all: build run

build:
	latexmk -xelatex -synctex=1 -jobname=master-thesis main.tex

run:
	xdg-open master-thesis.pdf

clean:
	rm *.aux \
	*.fdb_latexmk \
	*.fls \
	*.lof \
	*.lot \
	*.log \
	*.out \
	*.synctex.gz \
	*.toc

docker:
	docker build -t docker-latex .
	docker run --rm -ti -v ${PWD}:/master-thesis:Z docker-latex bash -c "make build && make clean"
	docker run --rm -ti -v ${PWD}:/master-thesis:Z docker-latex bash -c "make -C presentation && make -C presentation clean"

pres:
	make -C presentation run

pres_it_planet:
	make -C presentation_it_planet run

install-fonts:
	mkdir -p $(FONTSDIR)
	wget -O $(FONTSDIR)/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf
	#wget http://www.paratype.ru/uni/public/PTSansOFL.zip
	#wget http://www.paratype.ru/uni/public/PTMono.zip
	#unzip PTSansOFL.zip -d $(FONTSDIR)/ && unzip PTMono.zip -d $(FONTSDIR)/
	#rm -f PTSansOFL.zip PTMono.zip
	fc-cache -f -v
