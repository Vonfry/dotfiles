#!/usr/bin/env bash
script_dir=$( cd "$( dirname "$0" )/.." && pwd )
nix develop '$script_dir/../..' --command runghc Update.hs "$@"
