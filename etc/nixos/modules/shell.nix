{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.vonfry;
in
{
  config = mkIf cfg.enable {
    programs.command-not-found.enable = false;

    # Let vendors work in hm.
    programs.fish.enable = true;

    console = {
      # set console font to nix path instead of name with package.
      # Because this is needed in stage 1 and etc isn't initialized if using
      # root on tmpfs.
      font = "${pkgs.terminus_font}/share/consolefonts/ter-v12n.psf.gz";
    };
  };
}
