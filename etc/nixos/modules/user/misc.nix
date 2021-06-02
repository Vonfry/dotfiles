{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    xdg = {
      dataFile = {
        "fcitx5/rime/default.custom.yaml" = {
          source = ./files/rime/default.custom.yaml;
          onChange = ''
          [ -f ${toString config.xdg.dataHome}/fcitx5/rime/default.yaml ] && rm ${toString config.xdg.dataHome}/fcitx5/rime/default.yaml
          fcitx5-remote -r
        '';
        };
        "fcitx5/rime" = {
          source = with pkgs; with vonfryPackages.rimePlugins;
            runCommand "fcitx-rime-plugins" {} ''
            mkdir $out
            ln -s ${cangjie}/share/rime-plugins/*.yaml $out
            ln -s ${wubi86-jidian}/share/rime-plugins/wubi86*.yaml $out
            ln -s ${wubi86-jidian}/share/rime-plugins/pinyin_simp.*.yaml $out
            ln -s ${wubi86-jidian}/share/rime-plugins/numbers.*.yaml $out
            ln -s ${japanese}/share/rime-plugins/*.yaml $out
          '';
          recursive = true;
        };
        "fcitx5/themes/Material-Color/theme.conf".source = "${pkgs.vonfryPackages.fcitx5-theme.material-color}/theme-deepPurple.conf";
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
