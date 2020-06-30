{ pkgs, lib, ... }:

{
  imports = [ ./home ./package ];

  lib = pkgs.callPackage ./lib { };

  programs.home-manager.enable = true;
}
