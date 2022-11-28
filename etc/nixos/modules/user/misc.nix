{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;

  sVar = config.home.sessionVariables;
  hasCloud = sVar ? "CLOUD_DIR";
  inherit (sVar) DOTFILES_DIR CLOUD_DIR;

  syncLocal = with pkgs; writeScriptBin "fryos-sync" ''
    #!/usr/bin/env bash
    ${optionalString hasCloud ''
      ${pkgs.rsync}/bin/rsync -auPL \
        ${CLOUD_DIR}/dotfiles/etc/nixos/local/ \
        ${DOTFILES_DIR}/etc/nixos/local/
      ${pkgs.rsync}/bin/rsync -auPL \
        ${CLOUD_DIR}/dotfiles/config/nixpkgs/home/local/ \
        ${DOTFILES_DIR}/etc/nixos/local/vonfry
      ''}
    '';

    rebuildOS = with pkgs; writeScriptBin "fryos-rebuild" ''
    #!/usr/bin/env bash
    ${pkgs.nixos-rebuild}/bin/nixos-rebuild --flake \
      "path:${DOTFILES_DIR}/etc/nixos#vonfry"       \
      "$@"
  '';
in {
  config = mkIf cfg.enable {
    home.packages = [ syncLocal rebuildOS ];
  };
}
