# You can specify a specific python version to use by doing
# --build-arg PYTHON_VERSION=<version> on the build command,
# This defaults to 3.6 if nothing is given.
ARG PYTHON_VERSION=3.6

# These images are based off Debian Buster (slim) using https://hub.docker.com/_/python/ as the "base"
FROM python:${PYTHON_VERSION}-slim-buster

COPY . "/srv/asciidoc"

# Install the dependencies that asciidoc needs. The mkdir line is needed as something pulls in java jdk and it
# will fail if that folder does not already exist because...java.
RUN mkdir /usr/share/man/man1/ \
    && echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list && apt-get update \
    && apt-get install -y --no-install-recommends \
        autoconf \
        dblatex \
        docbook-xml \
        docbook-xsl \
        dvipng \
        epubcheck \
        fop \
        git \
        graphviz \
        highlight \
        imagemagick \
        libxml2-utils \
        lilypond \
        make \
        python3 \
        source-highlight \
        time \
        texlive-latex-base \
        unzip \
        zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /srv/asciidoc \
    && autoconf \
    && ./configure \
    && make \
    && make install

RUN rm -rf /src/asciidoc

CMD "/bin/bash"
