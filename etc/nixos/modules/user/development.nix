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

    xdg.configFile = {
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

    services = {
      lorri.enable = true;
    };

    programs = {
      neovim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
          { plugin = vim-logreview; }
          { plugin = vim-surround; }
          { plugin = auto-pairs; }
          { plugin = direnv-vim; }
          { plugin = nerdtree; }
          { plugin = nerdtree-git-plugin; }
          { plugin = vim-rooter; }
          { plugin = vim-polyglot; }
          { plugin = vim-ragtag; }
          { plugin = MatchTagAlways; }
          { plugin = nerdcommenter; }
          { plugin = vim-orgmode; }
          { plugin = vim-easymotion; }
          { plugin = fzf-vim; }
          { plugin = editorconfig-vim; }
          { plugin = vim-better-whitespace; }
          { plugin = vim-signature; }
          { plugin = incsearch-vim; }
          { plugin = vim-over; }
          { plugin = tabular; }
          { plugin = vim-which-key; }
          { plugin = nvim-compe; }
          { plugin = ultisnips; }
          { plugin = vim-snippets; }
          { plugin = nvim-lspconfig; }
          { plugin = vim-fugitive; }
          { plugin = vim-signify; }
          { plugin = NeoSolarized; }
          { plugin = vim-airline; }
          { plugin = vim-airline-clock; }
          { plugin = indentLine; }
          { plugin = vim-mundo; }
          { plugin = dracula-vim;
            optional = true;
            # see github:nixos/nixpkgs#96062
            config = "packadd! dracula-vim";
          }
        ];

        extraConfig = ''
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
          company-math
          company-auctex
          dashboard
          proof-general
          company-coq
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
          company-shell
          markdown-mode
          haskell-mode
          lsp-haskell
          hasky-extensions
          haskell-snippets
          easy-jekyll
          json-mode
          yaml-mode
          magit
          git-commit
          transient
          with-editor
          gitconfig-mode
          gitignore-mode
          gitattributes-mode
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
          company
          company-quickhelp
          company-prescient
          yasnippet
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
          docker
          logview
          pdf-tools
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
            color = false;
          };
        };
        lfs.enable = true;
        ignores = [ (builtins.readFile ./files/gitignore) ];
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
      };

    };

    home = {
      sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim -c 'set ft=man' -";
        PAGER = "nvim -R";
      };

      packages = with pkgs; [
        # neovim emacs
        emacs-all-the-icons-fonts

        # git git-lfs
        gitAndTools.gitflow tig gitAndTools.git-extras

        nixfmt niv

        tokei zeal

        pandoc

        graphviz

        rnix-lsp
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
