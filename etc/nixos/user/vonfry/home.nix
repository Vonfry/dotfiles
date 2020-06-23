args@{ pkgs, lib, isNixOS ? false, ... }:

{
  lib = if !isNixOS then import ../../lib else { };

  programs.home-manager.enable = true;

  home.packages = import ./package args;

  imports = [ ./home ];
}
