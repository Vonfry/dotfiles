{ pkgs, lib, ... }:

{
  imports = [ ./home ../../lib ./package ];

  programs.home-manager.enable = true;
}
