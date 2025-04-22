{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.vonfry.development;
  cfg' = config.vonfry;
  envcfg = config.vonfry.environment;

  ishome = cfg'.workspace.home;

  emacsExtraBin =
    pkgs.buildEnv {
      name = "emacs-extra-bin";
      paths = with pkgs; [
        # FIXME nov needed. Remove this when ouch can work for it.
        unzip
      ] ++ optional ishome hugo;
      pathsToLink = [
        "/bin"
        "/share"
        "/lib"
      ];
    };

  hasOrg = envcfg.orgmode.enable;

  genEmacsModuleWarning =
    module:
    optional (any (x: x == module) cfg.emacs.excludeModules) "emacs ${module} module is disabled.";

  # copy from emacsclient.desktop
  emacsclient_default_mimetypes_txt = "text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;x-scheme-handler/org-protocol";
  emacsclient_default_mimetypes = splitString ";" emacsclient_default_mimetypes_txt;
  emacsclient_mimetypes = emacsclient_default_mimetypes ++ [
    "application/pdf"
  ];

  gpgHasKey = config.programs.gpg.settings ? "default-key";
  gpgKey = config.programs.gpg.settings.default-key;
in
{
  options.vonfry.development = {
    emacs = {
      preCustom = mkOption {
        default = "";
        type = types.lines;
      };
      postCustom = mkOption {
        default = "";
        type = types.lines;
      };
      excludeModules = mkOption {
        default = [ ];
        type = with types; listOf str;
      };
      treesistWith = mkOption {
        default =
          p: with p; [
            tree-sitter-haskell
            tree-sitter-c
            tree-sitter-cpp
            tree-sitter-rust
            tree-sitter-commonlisp
            tree-sitter-elisp
            tree-sitter-nix
            tree-sitter-latex
            tree-sitter-bibtex
            tree-sitter-json
            tree-sitter-yaml
            tree-sitter-toml
            tree-sitter-html
          ];
        type = with types; functionTo (listOf package);
      };
    };
  };

  config = mkIf cfg'.enable {
    vonfry.development.emacs.excludeModules = mkMerge [
      (optional (!config.services.mpd.enable) "tools/mpd")
      (optionals (!ishome) [
        "tools/blog"
        "tools/feed"
      ])
      (optional (!ishome || !envcfg.financial.enable) "tools/ledger")
    ];

    warnings = mkMerge [
      (optional (!hasOrg) "org dir isn't set and some of emacs config cannot work directly.")
      (genEmacsModuleWarning "tools/ledger")
      (genEmacsModuleWarning "tools/blog")
      (genEmacsModuleWarning "tools/mpd")
      (genEmacsModuleWarning "tools/feed")
    ];

    home.sessionVariables = {
      EMACS_DASHBOARD_IMAGE = pkgs.vonfryPackages.desktopBackground;
    };

    xdg = {
      configFile = {
        "emacs" = {
          source = ./files/emacs.d;
          recursive = true;
        };

        "emacs/local/pre-custom.el".text = concatStringsSep "\n" [
          ''
            (setopt
              vonfry-exclude-modules '(${concatMapStringsSep " " (e: ''"${e}"'') cfg.emacs.excludeModules}))
            (add-to-list 'exec-path "${emacsExtraBin}/bin")
          ''
          cfg.emacs.preCustom
        ];

        "emacs/local/post-custom.el".text = cfg.emacs.postCustom;
      };

      dataFile = {
      };

      mimeApps.defaultApplications = mkIf config.services.emacs.enable (
        genAttrs emacsclient_mimetypes (const "emacsclient.desktop")
      );
    };

    services.emacs = {
      enable = true;
      client.enable = false; # it has been included in emacs-git
      socketActivation.enable = true;
      startWithUserSession = if cfg'.x.enable then "graphical" else true;
      defaultEditor = true;
    };

    programs = {
      emacs = {
        package = if cfg'.x.enable then pkgs.emacs-git else pkgs.emacs-git-nox;
        enable = true;
        extraPackages =
          epkgs: with epkgs; [
            solarized-theme
            dracula-theme
            general
            whitespace-cleanup-mode
            evil
            evil-numbers
            evil-surround
            evil-matchit
            auctex
            dashboard
            nix-mode
            nix-ts-mode
            org-web-tools
            org-journal
            org-ql
            rust-mode
            cargo
            markdown-mode
            haskell-ts-mode
            easy-hugo
            json-mode
            yaml-mode
            magit
            git-modes
            forge
            diff-hl
            disaster
            mu4e
            mu4e-alert
            elfeed
            elfeed-org
            emacsql
            ebib
            dumb-jump
            avy
            ace-window
            logview
            evil-nerd-commenter
            rainbow-delimiters
            doom-modeline
            hl-todo
            rainbow-mode
            hledger-mode
            envrc
            ob-http
            org-contacts
            evil-collection
            melpaPackages.telega
            smart-tab
            vundo
            consult
            orderless
            embark
            embark-consult
            marginalia
            vertico
            agda2-mode
            ligature
            sly
            flymake-collection
            consult-eglot
            openpgp
            ement
            wgrep
            (treesit-grammars.with-grammars cfg.emacs.treesistWith)
            org-project-capture
            password-store
            nov
            org-tree-slide
            bufler
            daemons
            journalctl-mode
            trashed
            yasnippet
            yasnippet-snippets
            epkgs."0x0"
            consult-hoogle
            gptel
            consult-notes
            org-modern
            uniline
            dape
            elysium
            pdf-tools
            org-pdftools
            treesit-fold
            eshell-syntax-highlighting
            esh-autosuggest
          ];
        overrides = self: super: {
          openpgp = super.openpgp.overrideAttrs (old: {
            # FIXME github:nixos/nixpkg##328573 and emacs-dev:bug#67916
            turnCompilationWarningToError = false;
            ignoreCompilationError = true;
          });
        };
      };

      git = {
        userName = "Vonfry";
        userEmail = "dev@vonfry.name";
        package = pkgs.gitAndTools.gitFull;
        signing = mkIf gpgHasKey {
          signByDefault = true;
          key = gpgKey;
        };
        enable = true;
        extraConfig = {
          rebase.autoSquash = mkDefault true;
          github.user = "Vonfry";
          gitlab.user = "Vonfry";
          color.pager = true;
          sendemail = mkIf config.programs.msmtp.enable {
            sendmailCmd = concatStringsSep " " [
              (getExe config.programs.msmtp.package)
              "--read-envelope-from"
              "-t"
            ];
          };
        };
        ignores = [ (builtins.readFile ./files/gitignore) ];
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        stdlib = ''
          declare -A direnv_layout_dirs
          direnv_layout_dir() {
              echo "''${direnv_layout_dirs[$PWD]:=$(
                  echo -n "$XDG_CACHE_HOME"/direnv/layouts/
                  echo -n "$PWD" | shasum | cut -d ' ' -f 1
              )}"
          }
        '';
      };

      nix-index.enable = true;
    };

    home = {
      packages = with pkgs; [
        gitAndTools.git-extras

        editorconfig-core-c

        tokei

        pandoc

        distrobox

        nixd
        nixpkgs-review
        nurl
        nixfmt-rfc-style
      ];

      # Use home.file instead of programs.<editor> due to I want to have a
      # structure # config file for them.
      file = {
        ".ghc/ghci.conf".text = ''
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
          :set -fomit-yields
        '';
      };
    };
  };
}
