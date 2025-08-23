#!/usr/bin/env bash
script_dir="$( dirname "$0" )"
pushd $script_dir
nix develop ../.. --command runghc Update.hs "$@"
popd
