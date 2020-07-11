{ lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  fonts.fontconfig.enable = isLinux;

  home = {
    activation.rimeActivation = lib.hm.dag.entryAfter [ "shellActivation" ] ''
      _rime_user_dir=${if isDarwin then "~/Library/Rime" else "~/.config/fctix/rime"}
      if ! [ -d $CLONE_LIB/rime-cangjie ]; then
        $DRY_RUN_CMD git $VERBOSE_ARG clone https://github.com/rime/rime-cangjie.git $CLONE_LIB/rime-cangjie
        ln -s -f $CLONE_LIB/rime-cangjie/*.yaml $_rime_user_dir
      fi
      if ! [ -d $CLONE_LIB/rime-wubi ]; then
        $DRY_RUN_CMD git $VERBOSE_ARG clone https://github.com/KyleBing/rime-wubi86-jidian.git $CLONE_LIB/rime-wubi
        ln -s -f $CLONE_LIB/rime-wubi/wubi86.*.yaml $_rime_user_dir
        ln -s -f $CLONE_LIB/rime-wubi/pinyin_simp.*.yaml $_rime_user_dir
        ln -s -f $CLONE_LIB/rime-wubi/numbers.*.yaml $_rime_user_dir
        ln -s -f $CLONE_LIB/rime-wubi/symbol.*.yaml $_rime_user_dir
      fi
      unset _rime_user_dir
    '';

    file = lib.optionalAttrs isLinux {
      ".config/fctix/rime/default.custom.yaml" = {
        source = ./files/rime/default.custom.yaml;
        onChange = ''
          rm ~/.config/fcitx/rime/default.yaml
          fcitx-remote -r
        '';
      };
    } // lib.optionalAttrs isDarwin {
      "Library/Rime/default.custom.yaml".source = ./files/rime/default.custom.yaml;
      "Library/Rime/squirrel.custom.yaml".source = ./files/rime/squirrel.custom.yaml;
      ".gnupg/gpg-agent.conf".text = ''
        default-cache-ttl 14400
        allow-emacs-pinentry
        enable-ssh-support
        allow-preset-passphrase
      '';
    };

    packages = with pkgs; [
      _1password
    ] ++ lib.optionals stdenv.isLinux [
      tdesktop
      filezilla
      fontforge-gtk

      hack-font
      source-han-sans-simplified-chinese
      source-han-serif-simplified-chinese
      symbola
      liberation_ttf
    ];
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
