{ pkgs, ... }:

let
  confLinux = {
    fonts.fontconfig.enable = true;
    programs = {
      man.enable = true;
      tmux = {
        enable = true;
        clock24 = true;
        keyMode = "vi";
        shortcut = "\\";
        extraConfig = ''
          set -g update-environment -r
          set -g status-right "#{tmux_mode_indicator}"
          unbind C-b
        '';
      };
      zathura.enable = true;
    };
    home.file = {
      ".config/fctix/rime/default.custom.yaml" = {
        source = ./files/rime/default.custom.yaml;
        onChange = ''
          rm ~/.config/fcitx/rime/default.yaml
          fcitx-remote -r
        '';
      };
      ".config/fctix/rime/installation.custom.yaml".source = ./files/rime/installation.custom.yaml;
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
  };
  confDarwin = {
    home.file = {
      "Library/Rime/default.custom.yaml".source = ./files/rime/default.custom.yaml;
      "Library/Rime/installation.custom.yaml".source = ./files/rime/installation.custom.yaml;
      "Library/Rime/squirrel.custom.yaml".source = ./files/rime/squirrel.custom.yaml;
      ".gnupg/gpg-agent.conf" = {
        executable = false;
        text = ''
          default-cache-ttl 14400
          allow-emacs-pinentry
          enable-ssh-support
          allow-preset-passphrase
        '';
      };
    };
  };
  conf = {
    home.file = {
      ".ghc/ghci.conf" = {
        executable = false;
        text = ''
          :set -fbreak-on-exception
          :set +m

          -- see more about extension: https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/glasgow_exts.html
          :set -XLambdaCase
          :set -XMultiWayIf
          :set -XBinaryLiterals
          :set -XBangPatterns

          :set -XTemplateHaskell
          :set -XNamedFieldPuns
          :set -XFlexibleContexts
          :set -XFlexibleInstances
          :set -XMultiParamTypeClasses

          :set -XUnicodeSyntax

          :set -XDeriveGeneric
          :set -XDeriveFunctor
          :set -XDeriveFoldable

          :set -XImplicitParams

          -- preference
          :set prompt "λ "
          :set prompt-cont "> "

          -- allow C-c
          :set -fomit-yields%
        '';
      };
      ".gemrc" = {
        text = ''
          ---
          :backtrace: false
          :bulk_threshold: 1000
          :sources:
          - https://rubygems.org
          :update_sources: true
          :verbose: true
          gem: --user-install --bindir ~/.gem/bin
        '';
        executable = false;
      };
      ".pryrc" = {
        executable = false;
        text = ''
          Pry.config.editor = "nvim"
        '';
      };
    };
  };
in conf // (if pkgs.stdenv.isDarwin then confDarwin else confLinux)
