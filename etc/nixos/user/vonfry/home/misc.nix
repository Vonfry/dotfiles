{ pkgs, ... }:

let
  conf = {
    fonts.fontconfig.enable = true;
    home.file = {
      ".config/fctix/rime" = {
        source = ./files/rime;
        recursive = true;
        onChange = [
          "rm ~/.config/fcitx/rime/default.yaml"
          "fcitx-remote -r"
        ];
      };
    };
  };
in if (!pkgs.stdenv.isDarwin) then conf else {}
