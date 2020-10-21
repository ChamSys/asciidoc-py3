#!/bin/bash

set -e -u

COMMIT=$(git show-ref --hash --abbrev | head -n 1)

docker build \
  -t chamsys/asciidoc:latest \
  -t chamsys/asciidoc:$COMMIT \
  -t registry.gitlab.com/chamsys/magicq-manual/asciidoc:latest \
  -t registry.gitlab.com/chamsys/magicq-manual/asciidoc:$COMMIT \
  .

