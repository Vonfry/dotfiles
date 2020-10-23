{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    programs = {
      zsh.enable = true;
      tmux.enable = true;
    };

    environment.systemPackages = with pkgs; [
      zsh fzf
      tmux
    ];
  };
}
