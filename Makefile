DIR0 = $(shell pwd)
HOMEDIR = $(shell echo ${HOME})
FONTSDIR = $(HOMEDIR)/.local/share/fonts

all: build run

build:
	latexmk -xelatex -synctex=1 -jobname=qtcreator-guide main.tex

run:
	xdg-open qtcreator-guide.pdf

clean:
	rm -fv *.aux \
	*.fdb_latexmk \
	*.fls \
	*.lof \
	*.lot \
	*.log \
	*.out \
	*.synctex.gz \
	*.toc \
	*.xdv

docker-image:
	docker build -t docker-latex .

docker:
	# add your user to group 'docker' to run docker without root
	docker run --rm -ti -v $(DIR0):/qtcreator-guide:Z docker-latex bash -c "cd /qtcreator-guide && make build && make clean"

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
