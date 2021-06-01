{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    xdg.configFile = {
      "fcitx/rime/default.custom.yaml" = {
        source = ./files/rime/default.custom.yaml;
        onChange = ''
          [ -f ${toString config.xdg.configHome}/fcitx/rime/default.yaml ] && rm ${toString config.xdg.configHome}/fcitx/rime/default.yaml
          fcitx-remote -r
        '';
      };

      "fcitx/rime" = {
        source = with pkgs; with vonfryPackages.rimePlugins;
          runCommand "fcitx-rime-plugins" {} ''
            mkdir $out
            ln -s ${cangjie}/share/rime-plugins/*.yaml $out
            ln -s ${wubi86-jidian}/share/rime-plugins/wubi86.*.yaml $out
            ln -s ${wubi86-jidian}/share/rime-plugins/pinyin_simp.*.yaml $out
            ln -s ${wubi86-jidian}/share/rime-plugins/numbers.*.yaml $out
          '';
        recursive = true;
      };
    };

    home = {
      packages = with pkgs; [
        hack-font
        sarasa-gothic
        symbola
        liberation_ttf
        source-han-sans-simplified-chinese
        source-han-serif-simplified-chinese
        font-awesome
      ];
    };
  };
}
