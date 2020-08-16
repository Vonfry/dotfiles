{ config, lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  xdg.configFile = {
    "fcitx/rime/default.custom.yaml" = {
      source = ./files/rime/default.custom.yaml;
      onChange = ''
        [ -f ${toString config.xdg.configHome}/fcitx/rime/default.yaml ] && rm ${toString config.xdg.configHome}/fcitx/rime/default.yaml
        fcitx-remote -r
      '';
    };
  };

  home = {
    activation.rimeActivation =
      let
        inherit (config.home.sessionVariables) CLONE_LIB;
      in lib.hm.dag.entryAfter [ "shellActivation" ] ''
        _rime_user_dir=${toString config.xdg.configHome}/fcitx/rime
        if ! [ -d ${CLONE_LIB}/rime-cangjie ]; then
          $DRY_RUN_CMD git $VERBOSE_ARG clone https://github.com/rime/rime-cangjie.git ${CLONE_LIB}/rime-cangjie
          ln -s -f ${CLONE_LIB}/rime-cangjie/*.yaml $_rime_user_dir
        fi
        if ! [ -d ${CLONE_LIB}/rime-wubi ]; then
          $DRY_RUN_CMD git $VERBOSE_ARG clone https://github.com/KyleBing/rime-wubi86-jidian.git ${CLONE_LIB}/rime-wubi
          ln -s -f ${CLONE_LIB}/rime-wubi/wubi86.*.yaml $_rime_user_dir
          ln -s -f ${CLONE_LIB}/rime-wubi/pinyin_simp.*.yaml $_rime_user_dir
          ln -s -f ${CLONE_LIB}/rime-wubi/numbers.*.yaml $_rime_user_dir
        fi
        unset _rime_user_dir
      '';

    packages = with pkgs; [
      _1password

      tdesktop
      filezilla
      fontforge-gtk

      hack-font
      sarasa-gothic
      symbola
      liberation_ttf
      source-han-sans-simplified-chinese
      source-han-serif-simplified-chinese
    ];
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 14400;
    enableSshSupport = true;
    extraConfig = ''
      allow-emacs-pinentry
      allow-preset-passphrase
    '';
  };
}
