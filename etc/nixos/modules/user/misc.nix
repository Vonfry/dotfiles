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

  easyeffctsCommunityPresets = optionals config.services.easyeffects.enable
    (with pkgs.vonfryPackages.easyeffects-presets; [ easypulse jackhack96 ]);
in
{
  config = mkIf cfg.enable {
    home.packages = [ checkedRebuildOS ] ++ easyeffctsCommunityPresets;

    services.easyeffects.enable = mkDefault (!cfg.workspace.server);

  };
}
