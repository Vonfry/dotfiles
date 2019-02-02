{ config, pkgs, ... }:

{
  imports = with import (dirOf <nixos-config> + /libs);
    matchFiles ./. "[A-z0-9\\-]*\\.local\\.nix" [];
}
