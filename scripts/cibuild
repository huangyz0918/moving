#!/bin/sh

set -e

scripts/build

if test -e "./_site/index.html";then
  echo "It builds!"
  rm -Rf _site
else
  echo "Huh. That's odd. The example site doesn't seem to build."
  exit 1
fi

sudo gem build moving.gemspec