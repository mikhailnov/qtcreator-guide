FROM ubuntu:19.04
LABEL maintainer="mikhailnov"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV DIR /qtcreator-guide

RUN mkdir $DIR
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
RUN apt update && \
    apt install -y wget \
        make && \
    apt install -y \
        texlive-base \
        texlive-latex-extra \
        texlive-xetex \
        texlive-lang-cyrillic \
        texlive-science \
        texlive-latex-recommended \
        latexmk \
        fonts-liberation2 \
        fonts-freefont-ttf \
        texlive-fonts-extra \
        python3-pygments

# Times New Roman and other fonts
RUN apt install -y --reinstall ttf-mscorefonts-installer && \
    wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    fc-cache -f -v

VOLUME $DIR
WORKDIR $DIR
