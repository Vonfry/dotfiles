{ pkgs, ... }:

let isDarwin = pkgs.stdenv.isDarwin;
in {
  home.file = {
    ".config/emacs.d" = {
      source = ./files/emacs.d;
      recursive = true;
    };
    ".config/nvim" = {
      source = ./files/nvim;
      recursive = true;
    };
    ".ghc/ghci.conf".text = ''
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
    ".gemrc".text = ''
      ---
      :backtrace: false
      :bulk_threshold: 1000
      :sources:
      - https://rubygems.org
      :update_sources: true
      :verbose: true
      gem: --user-install --bindir ~/.gem/bin
    '';
    ".pryrc".text = ''
      Pry.config.editor = "nvim"
    '';
    ".latexmkrc".text =
      if isDarwin then ''
        $out_dir = "latex.out";
        $pdf_mode = 5;
        $pdf_previewer = 'open -a Skim';
        $pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode';
        @generated_exts = (@generated_exts, 'synctex.gz');
      '' else ''
        $out_dir = "latex.out";
        $pdf_mode = 5;
        $dvi_previewer = 'xdvi -watchfile 1.5';
        $ps_previewer  = 'feh';
        $pdf_previewer = 'zathura';
      '';
  };
  # services = {
  #   lorri.enable = !pkgs.stdenv.isLinux;
  # };
  programs = {
    vim = {
      enable = true;
      settings = {
        background = "dark";
        backupdir = "~/.cache/vim/backup/";
        expandtab = true;
        mousemodel = "popup";
        number = true;
        relativenumber = true;
        shiftwidth = 4;
        ignorecase = true;
        smartcase = true;
        tabstop = 4;
        undofile = true;
        undordir = "~/.cache/vim/undo"
        history = 1024;
      };
      extraConfig = builtins.readFile ./files/vimrc;
    };
    emacs =  {
      enable = true;
      extraPackages = epkgs: with epkgs; [
        all-the-icons
        solarized-theme
        dracula-theme
        general
        exec-path-from-shell
        whitespace-cleanup-mode
        hl-line
        use-package
        diminish
        dash
        s
        auto-compile
        evil
        evil-numbers
        evil-surround
        evil-matchit
        amx
        flx
        ivy
        counsel
        ivy-avy
        swiper
        ivy-rich
        counsel-tramp
        flycheck
        latex
        auctex-latexmk
        company-math
        company-auctex
        auctex-latexmk
        dashboard
        proof-general
        company-coq
        python-mode
        pydoc
        nix-mode
        gnuplot
        org
        org-bullets
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
        epkgs."markdown-mode+"
        haskell-mode
        lsp-haskell
        hasky-extensions
        haskell-snippets
        easy-jekyll
        gnus
        json-mode
        erc
        yaml-mode
        magit
        git-commit
        transient
        with-editor
        gitconfig-mode
        gitignore-mode
        gitattributes-mode
        magit-gitflow
        evil-magit
        gitlab-ci-mode
        forge
        ruby-mode
        inf-ruby
        diff-hl
        disaster
        function-args
        cmake-mode
        cmake-font-lock
        realgud-lldb
        mu4e-alert
        mu4e-maildirs-extension
        elfeed
        emacsql
        sql-indent
        ebib
        company
        company-quickhelp
        company-prescient
        w3m
        yasnippe
        yasnippet-snippets
        info-colors
        dumb-jump
        ranger
        avy
        ace-window
        google-translate
        treemacs
        treemacs-evil
        treemacs-projectile
        treemacs-magit
        treemacs-icons-dired
        ebdb
        which-key
        imenu
        docker
        logview
        pdf-tools
        projectile
        counsel-projectile
        org-projectile
        ibuffer-vc
        ibuffer-projectile
        lsp-mode
        company-lsp
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
      ];
    };
    git = {
      userName = "Vonfry";
      userEmail = "mail@vonfry.name";
      signing.signByDefault = true;
      enable = true;
      lfs.enable = true;
      ignores = [ (builtins.readFile ./files/gitignore) ];
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    texlive = {
      enable = !isDarwin;
      extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
    };
  };
}
