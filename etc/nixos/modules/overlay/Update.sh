#!/usr/bin/env bash
script_dir="$( dirname "$0" )"
nix develop '$script_dir/../..' --command runghc Update.hs "$@"
