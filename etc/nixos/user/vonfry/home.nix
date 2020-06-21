args@{ pkgs, lib, isNixOS ? false, ... }:

{
  lib = if !isNixOS then import ../../lib else { };

  programs.home-manager.enable = true;

  home.packages = lib.optional (!isNixOS) (import ./package args);

  imports = [ ./home ];
}
