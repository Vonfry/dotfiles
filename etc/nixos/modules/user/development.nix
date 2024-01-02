{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry.development;
  cfg' = config.vonfry;

  emacsExtraBin = with pkgs; buildEnv {
    name = "emacs-extra-bin";
    paths = [ hugo ];
    pathsToLink = [ "/bin" "/share" "/lib" ];
  };

  inherit (config.xdg) dataHome;
  linkEmacs = ''
    [ -e ${toString dataHome}/emacs/dashboard-image.png ] || ln -s ${pkgs.vonfryPackages.desktopBackground} ${toString dataHome}/emacs/dashboard-image.png
  '';

  sessions = config.home.sessionVariables;
  hasOrg = sessions ? ORG_DIR;

  # copy from emacsclient.desktop
  emacsclient_mimetypes = [ "text/english" "text/plain" "text/x-makefile"
                           "text/x-c++hdr" "text/x-c++src" "text/x-chdr"
                           "text/x-csrc" "text/x-java" "text/x-moc"
                           "text/x-pascal" "text/x-tcl" "text/x-tex"
                           "application/x-shellscript" "text/x-c" "text/x-c++"
                         ];

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
      treesistWith = mkOption {
        default = p: with p; [
            tree-sitter-haskell tree-sitter-c tree-sitter-cpp tree-sitter-rust
            tree-sitter-commonlisp tree-sitter-elisp
            tree-sitter-nix tree-sitter-julia tree-sitter-latex
            tree-sitter-bibtex
            tree-sitter-json tree-sitter-yaml tree-sitter-toml tree-sitter-html
          ];
        type = with types; functionTo (listOf package);
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
    warnings = optional (!hasOrg) "org dir isn't set and some of emacs config cannot work directly.";

    xdg = {
      configFile = {
        "emacs" = {
          source = ./files/emacs.d;
          recursive = true;
        };
        "nvim" = {
          source = ./files/nvim;
          recursive = true;
        };

        "emacs/local/pre-custom.el".text =
          concatStringsSep "\n" [
            ''
            (setq-default
              vonfry-exclude-modules '(${concatMapStringsSep " " (e: "\"${e}\"")
                cfg.emacs.excludeModules}))
            (add-to-list 'exec-path "${emacsExtraBin}/bin")
            ''
            cfg.emacs.preCustom
          ];

        "emacs/local/post-custom.el".text = cfg.emacs.postCustom;
      };

      dataFile = {
        "applications/org-protocol.desktop".text = ''
          [Desktop Entry]
          Name=org-protocol
          Exec=emacsclient %u
          Icon=emacs-icon
          Type=Application
          Terminal=false
          MimeType=x-scheme-handler/org-protocol;
        '';
      };

      mimeApps.defaultApplications = mkIf config.services.emacs.enable
        (genAttrs emacsclient_mimetypes (const "emacsclient.desktop"));
    };

    services.emacs = {
      enable = true;
      client.enable = false; # it has been included in emacs-git
      socketActivation.enable = true;
      startWithUserSession = "graphical";
      defaultEditor = true;
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
          ultisnips
          vim-snippets
          nvim-lspconfig
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
        package = pkgs.emacs-git;
        enable = true;
        extraPackages = epkgs: with epkgs; [
          solarized-theme
          dracula-theme
          general
          whitespace-cleanup-mode
          diminish
          evil
          evil-numbers
          evil-surround
          evil-matchit
          auctex
          dashboard
          nix-mode
          org-superstar
          evil-org
          org-web-tools
          org-journal
          org-ql
          org-roam
          rust-mode
          cargo
          markdown-mode
          haskell-mode
          easy-hugo
          json-mode
          yaml-mode
          magit
          git-modes
          forge
          diff-hl
          disaster
          cmake-mode
          realgud-lldb
          mu4e
          mu4e-alert
          elfeed elfeed-org
          emacsql
          ebib
          info-colors
          dumb-jump
          dirvish
          avy
          ace-window
          logview
          editorconfig
          realgud
          engine-mode
          evil-nerd-commenter
          rainbow-delimiters
          doom-modeline
          hl-todo
          rainbow-mode
          hledger-mode
          envrc
          ob-http
          mpdel mpdel-embark
          org-contacts
          toc-org
          evil-collection
          melpaPackages.telega
          terminal-here
          zoxide
          smart-tab
          org-roam-ui
          graphviz-dot-mode
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
          julia-mode
          julia-repl
          eglot-jl
          tempel
          tempel-collection
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
          chatgpt-shell dall-e-shell
          ob-chatgpt-shell ob-dall-e-shell
          bufler
        ];
      };

      git = {
        userName = "Vonfry";
        userEmail = "mail@vonfry.name";
        package = pkgs.gitAndTools.gitFull;
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
          sendemail = mkIf config.programs.msmtp.enable {
            smtpServer = "msmtp";
            smtpServerOption = [ "--read-envelope-from" "-t" ];
          };
        };
        ignores = [ (builtins.readFile ./files/gitignore) ];
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv = {
          enable = true;
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
      zsh.initExtra = ''
        # this is a source file instead of autoloaded function file, so let us
        # source it!
        source ${pkgs.gitAndTools.git-extras}/share/zsh/site-functions/_git_extras
      '';
    };

    home = {
      activation.developmentActivation = lib.hm.dag.entryAfter
        [ "writeBoundary" "linkGeneration" ]
        (concatStringsSep "\n" [ linkEmacs ]);

      sessionVariables = {
        MANPAGER = "nvim +Man!";
        PAGER = "nvim -R";
      };

      packages = with pkgs; [
        gitAndTools.git-extras

        editorconfig-core-c

        tokei

        pandoc

        graphviz

        distrobox

        nixfmt nil nixpkgs-review nurl
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

        ".latexmkrc".text = ''
          $out_dir = "latex.out";
          $pdf_mode = 4;
          $dvi_previewer = 'xdvi -watchfile 1.5';
          $ps_previewer  = 'feh';
          $pdf_previewer = 'zathura';
        '';
      };
    };

  };
}
