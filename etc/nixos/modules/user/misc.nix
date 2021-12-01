{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;

  sVar = config.home.sessionVariables;
  hasCloud = sVar ? "CLOUD_DIR";
  inherit (sVar) DOTFILES_DIR CLOUD_DIR;

  syncConfig = with pkgs; writeScriptBin "nixos-sync-config" ''
    #!/usr/bin/env bash
    sudo mkdir -p /etc/nixos/modules
    sudo cp -rl ${DOTFILES_DIR}/etc/nixos/modules/* /etc/nixos/modules
      ${optionalString hasCloud ''
        sudo mkdir -p /etc/nixos/local
        sudo cp -rl ${CLOUD_DIR}/dotfiles/etc/nixos/local/* /etc/nixos/local
        sudo cp -rl ${CLOUD_DIR}/dotfiles/config/nixpkgs/home/local/* /etc/nixos/local
      ''}
  '';
in {
  config = mkIf cfg.enable {
    home.packages = [ syncConfig ];
  };
}
