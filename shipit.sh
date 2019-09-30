#!/bin/bash
set -e
export HAB_ORIGIN=jvogt-fundamentals
if ! ls ~/.hab/cache/keys/${HAB_ORIGIN}* ; then
  hab origin key generate $HAB_ORIGIN
fi
hab pkg build .
source results/last_build.env
hab pkg upload results/$pkg_artifact
