{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
  sessions = config.home.sessionVariables;
  inherit (sessions) DOTFILES_DIR;

  rebuildOS = with pkgs; writeScriptBin "fryos-rebuild" ''
    #!/usr/bin/env bash
    ${pkgs.nixos-rebuild}/bin/nixos-rebuild --flake \
      "path:${DOTFILES_DIR}/etc/nixos#vonfry"   \
      "$@"
  '';

  checkedRebuildOS = if sessions ? "DOTFILES_DIR" then rebuildOS
    else throw "home.sessionVariables.DOTFILES_DIR must be set for this repo.";
in {
  config = mkIf cfg.enable {
    home.packages = [ checkedRebuildOS ];
  };
}
