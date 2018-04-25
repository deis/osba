#!/usr/bin/env bash

set -xeuo pipefail

REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
DOCSITE=$REPO_ROOT/$2
DEST=$DOCSITE/_site

clean() {
  # Start fresh so that removed files are picked up
  if [[ -d $DEST ]]; then
    rm -r $DEST
  fi
  mkdir -p $DEST
}

# Serve a live preview of the site
preview() {
  clean

  docker run -it --rm \
    -v $DOCSITE:/srv/jekyll \
    -v $REPO_ROOT/docs:/srv/docs \
    -v $DOCSITE/.bundler:/usr/local/bundle \
    -p 4000:4000 jekyll/jekyll jekyll serve
}

# Generate the static site's content
generate() {
  clean

  echo "Generating site..."
  docker run -it --rm \
    -v $DOCSITE:/srv/jekyll \
    -v $REPO_ROOT/docs:/srv/docs \
    -v $DOCSITE/.bundler:/usr/local/bundle \
    jekyll/jekyll jekyll build
}

$1
