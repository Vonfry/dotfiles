{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.vonfry;
  envcfg = config.vonfry.environment;

  rebuildOS =
    with pkgs;
    writeScriptBin "fryos-rebuild" ''
      #!/usr/bin/env bash
      ${pkgs.nixos-rebuild}/bin/nixos-rebuild --flake \
        "path:${envcfg.dotfiles.absolute_path}/etc/nixos#vonfry"   \
        "$@"
    '';
  easyeffctsCommunityPresets = optionals config.services.easyeffects.enable (
    with pkgs.vonfryPackages.easyeffects-presets;
    [
      easypulse
      jackhack96
    ]
  );
in
{
  config = mkIf cfg.enable {
    home.packages =
      with pkgs; [
        convmv
        libuchardet
      ]
      ++ optional envcfg.dotfiles.enable rebuildOS
      ++ easyeffctsCommunityPresets;

    services.easyeffects.enable = mkDefault (!cfg.workspace.server);

  };
}
