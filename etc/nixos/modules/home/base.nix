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
    xdg.configFile = {
      "nix/nix.conf".text = ''
        auto-optimise-store = true
        keep-outputs = true
        keep-derivations = true
      '';
      "nixpkgs/config.nix".source = ./files/nixpkgs.nix;
    };

    home = {
      username = "vonfry";
      homeDirectory = mkDefault "/home/vonfry";
      stateVersion = mkDefault "25.05";

      keyboard = {
        variant = "dvp";
        layout = "us";
      };

      file = {
        # make it auto cite
        ".parallel/will-cite".text = "";
      };

      packages = with pkgs; [
        patch
        parallel
        file

        ouch
        zstd
        ripgrep
        fd
      ];
    };

    programs = {
      man.enable = true;
      ssh = {
        enable = true;
        compression = true;
        forwardAgent = true;
        serverAliveInterval = 60;
        serverAliveCountMax = 4;
        # TODO remove this if I use gpg to manage all ssh keys.
        addKeysToAgent = "yes";
      };
    };
  };
}
