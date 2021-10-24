{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry.development;
  cfg' = config.vonfry;

  emacsExtraBin = with pkgs; buildEnv {
    name = "emacsExtraBin";
    paths = [ python3 sqlite perl bundler jekyll ];
    pathsToLink = [ "/bin" "/share" "/lib" ];
  };

  editorMimeApps = listToAttrs
    (map (type: {name = type; value = "emacsclient.desktop"; })
      [ # copy from emacs.desktop
        "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr"
        "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc"
        "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript"
        "text/x-c" "text/x-c++"
      ]);


  sessions = config.home.sessionVariables;
  inherit (sessions) DOTFILES_DIR CLOUD_DIR ORG_DIR CLONE_LIB;
  inherit (config.xdg) configHome;

  hasOrg = sessions ? "ORG_DIR";
  hasCloud = sessions ? "CLOUD_DIR";

  emacsLocal = "${CLOUD_DIR}/dotfiles/config/emacs.d/local";
  linkOrg = optionalString (hasOrg && hasCloud) ''
    [ -h ${ORG_DIR} ] || $DRY_RUN_CMD ln $VERBOSE_ARG -s ${CLOUD_DIR}/dotfiles/orgmode ${ORG_DIR}
  '';
  linkEmacs = optionalString hasCloud ''
    if [ -d "${emacsLocal}" ]; then
      $DRY_RUN_CMD ln $VERBOSE_ARG -sf ${emacsLocal}/* ${toString configHome}/emacs.d/local
    fi

    [ -h ${toString configHome}/emacs.d/local/dashboard-image.png ] || ln -s ${pkgs.vonfryPackages.desktopBackground} ${toString configHome}/emacs.d/local/dashboard-image.png
  '';
in {
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
    };

    git = {
      signKey = mkOption {
        default = null;
        type = with types; nullOr str;
      };
    };
  };

  config = mkIf cfg'.enable {

    xdg = {
      mimeApps.defaultApplications = editorMimeApps;

      configFile = {
        "emacs.d" = {
          source = ./files/emacs.d;
          recursive = true;
        };
        "nvim" = {
          source = ./files/nvim;
          recursive = true;
        };

        "emacs.d/local/pre-custom.el".text =
          (concatStringsSep "\n" [
            ''
            (setq-default
              vonfry-exclude-modules '(${concatMapStringsSep " " (e: "\"${e}\"")
                cfg.emacs.excludeModules}))
            (add-to-list 'exec-path "${emacsExtraBin}/bin")
          ''
            cfg.emacs.preCustom
          ]);

        "emacs.d/local/post-custom.el".text = cfg.emacs.postCustom;
      };
    };

    services.emacs = {
      enable = true;
      client.enable = true;
      socketActivation.enable = true;
    };

    programs = {
      neovim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
          vim-logreview
          vim-surround
          auto-pairs
          direnv-vim
          nerdtree
          nerdtree-git-plugin
          vim-rooter
          vim-polyglot
          vim-ragtag
          MatchTagAlways
          nerdcommenter
          vim-orgmode
          vim-easymotion
          fzf-vim
          editorconfig-vim
          vim-better-whitespace
          vim-signature
          incsearch-vim
          vim-over
          tabular
          vim-which-key
          ultisnips
          vim-snippets
          # nvim-lspconfig
          vim-fugitive
          vim-signify
          NeoSolarized
          vim-airline
          vim-airline-clock
          indentLine
          vim-mundo
          { plugin = dracula-vim;
            optional = true;
          }
          vim-gnupg
          supertab
        ];

        extraConfig = ''
          " see github:nixos/nixpkgs#96062
          " This have to be done here instead of config option at below because
          " my configuration will load this.
          packadd! dracula-vim
          call vonfry#init()
        '';
      };

      emacs =  {
        package = pkgs.emacsUnstable;
        enable = true;
        extraPackages = epkgs: with epkgs; [
          all-the-icons
          solarized-theme
          dracula-theme
          general
          whitespace-cleanup-mode
          use-package
          diminish
          dash
          s
          evil
          evil-numbers
          evil-surround
          evil-matchit
          amx
          flx
          wgrep
          ivy
          counsel
          ivy-avy
          swiper
          ivy-rich
          counsel-tramp
          flycheck
          auctex
          auctex-latexmk
          dashboard
          proof-general
          python-mode
          pydoc
          nix-mode
          org
          org-superstar
          evil-org
          org-web-tools
          org-journal
          org-ql
          org-roam
          org-roam-server
          rust-mode
          cargo
          markdown-mode
          haskell-mode
          lsp-haskell
          haskell-snippets
          easy-jekyll
          json-mode
          yaml-mode
          magit
          git-modes
          magit-gitflow
          gitlab-ci-mode
          forge
          diff-hl
          disaster
          cmake-mode
          realgud-lldb
          mu4e-alert
          mu4e-maildirs-extension
          elfeed elfeed-org
          emacsql
          sql-indent
          ebib
          yasnippet-snippets
          info-colors
          dumb-jump
          ranger
          avy
          ace-window
          treemacs
          treemacs-evil
          treemacs-projectile
          treemacs-magit
          treemacs-icons-dired
          which-key
          logview
          projectile
          counsel-projectile
          org-projectile
          ibuffer-vc
          ibuffer-projectile
          lsp-mode
          lsp-treemacs
          lsp-ivy
          editorconfig
          realgud
          engine-mode
          evil-nerd-commenter
          rainbow-delimiters
          highlight-indent-guides
          origami
          doom-modeline
          hl-todo
          hlinum
          rainbow-mode
          undo-tree
          hledger-mode
          ess
          envrc
          ob-http
          mpdel
          org-plus-contrib
          evil-collection
          license-snippets
          telega
          terminal-here
          zoxide
          smart-tab
        ];
      };

      git = {
        userName = "Vonfry";
        userEmail = "mail@vonfry.name";
        signing = mkIf (cfg.git.signKey != null) {
          signByDefault = true;
          key = cfg.git.signKey;
        };
        enable = true;
        extraConfig = {
          pull.rebase = mkDefault true;
          rebase.autoSquash = mkDefault true;
          github.user = "Vonfry";
          gitlab.user = "Vonfry";
          core = {
            pager = "nvim -R";
          };
          color.pager = false;
        };
        lfs.enable = true;
        ignores = [ (builtins.readFile ./files/gitignore) ];
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv = {
          enable = true;
          enableFlakes = false;
        };
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
    };

    home = {
      activation.developmentActivation = lib.hm.dag.entryAfter ["writeBoundary"]
        (concatStringsSep "\n" [ linkOrg linkEmacs ]);

      sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim -c 'set ft=man' -";
        PAGER = "nvim -R";
      };

      packages = with pkgs; [
        emacs-all-the-icons-fonts

        gitAndTools.gitflow gitAndTools.git-extras

        nixfmt niv

        tokei zeal

        pandoc

        graphviz

        rnix-lsp nixpkgs-review nix-prefetch-scripts
      ];

      # Use home.file instead of programs.<editor> due to I want to have a
      # structure # config file for them.
      file = {
        ".tigrc".text = ''
          set log-options = --show-signature
          set diff-options = --show-signature
        '';

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

        ".latexmkrc".text = ''
          $out_dir = "latex.out";
          $pdf_mode = 5;
          $dvi_previewer = 'xdvi -watchfile 1.5';
          $ps_previewer  = 'feh';
          $pdf_previewer = 'zathura';
        '';

        ".Rprofile".text = ''
          options(browser = 'qutebrowser')
          # options(help_type = 'html')
        '';
      };
    };
  };
}
