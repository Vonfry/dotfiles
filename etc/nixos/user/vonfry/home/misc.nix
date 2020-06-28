{ lib, pkgs, ... }:

let isDarwin = pkgs.stdenv.isDarwin;
in {
  fonts.fontconfig.enable = !isDarwin;
  home = {
    activation.rimeActivation = lib.hm.dag.entryAfter [ "shellActivation" ] ''
      _rime_user_dir=${if isDarwin then "~/Library/Rime" else "~/.config/fctix/rime"}
      if ! [ -d $CLONE_LIB/rime-cangjie ]; then
        $DRY_RUN_CMD git $VERBOSE_ARG clone https://github.com/rime/rime-cangjie.git $CLONE_LIB/rime-cangjie
        ln -s -f $CLONE_LIB/rime-cangjie/*.yaml $_rime_user_dir
      fi
      if ! [ -d $CLONE_LIB/rime-wubi ]; then
        $DRY_RUN_CMD git $VERBOSE_ARG clone https://github.com/rime/rime-pinyin-simp $CLONE_LIB/rime-pinyin-simp
        $DRY_RUN_CMD git $VERBOSE_ARG clone https://github.com/rime/rime-wubi.git $CLONE_LIB/rime-wubi
        ln -s -f $CLONE_LIB/rime-pinyin/*.yaml $_rime_user_dir
        ln -s -f $CLONE_LIB/rime-wubi/*.yaml $_rime_user_dir
      fi
      unset _rime_user_dir
    '';
    file =
      if !isDarwin then {
        ".config/fctix/rime/default.custom.yaml" = {
          source = ./files/rime/default.custom.yaml;
          onChange = ''
            rm ~/.config/fcitx/rime/default.yaml
            fcitx-remote -r
          '';
        };
        ".config/fctix/rime/wubi86.custom.yaml" = {
          source = ./files/rime/wubi86.custom.yaml;
          onChange = ''
            rm ~/.config/fcitx/rime/default.yaml
            fcitx-remote -r
          '';
        };
        ".config/fctix/rime/installation.custom.yaml".source = ./files/rime/installation.custom.yaml;
      } else {
        "Library/Rime/default.custom.yaml".source = ./files/rime/default.custom.yaml;
        "Library/Rime/wubi86.custom.yaml".source = ./files/rime/wubi86.custom.yaml;
        "Library/Rime/installation.custom.yaml".source = ./files/rime/installation.custom.yaml;
        "Library/Rime/squirrel.custom.yaml".source = ./files/rime/squirrel.custom.yaml;
        ".gnupg/gpg-agent.conf".text = ''
        default-cache-ttl 14400
        allow-emacs-pinentry
        enable-ssh-support
        allow-preset-passphrase
      '';
      };
  };
  services.gpg-agent = {
    enable = pkgs.stdenv.isLinux;
    defaultCacheTtl = 14400;
    enableSshSupport = true;
    extraConfig = ''
      allow-emacs-pinentry
      allow-preset-passphrase
    '';
  };
}
