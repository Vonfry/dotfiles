{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.vonfry;
  sessions = config.home.sessionVariables;
  inherit (sessions) DOTFILES_DIR;

  rebuildOS =
    with pkgs;
    writeScriptBin "fryos-rebuild" ''
      #!/usr/bin/env bash
      ${pkgs.nixos-rebuild}/bin/nixos-rebuild --flake \
        "path:${DOTFILES_DIR}/etc/nixos#vonfry"   \
        "$@"
    '';
  checkedRebuildOS = if sessions ? DOTFILES_DIR then rebuildOS else throw "DOTFILES_DIR isn't set.";
in
{
  config = mkIf cfg.enable {
    home.packages = [ checkedRebuildOS ];

    services.easyeffects.enable = mkDefault (!cfg.workspace.server);
  };
}
