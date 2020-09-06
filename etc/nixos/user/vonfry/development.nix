{ pkgs, ... }:

{
  xdg.configFile = {
    "emacs.d" = {
      source = ./files/emacs.d;
      recursive = true;
    };
    "nvim" = {
      source = ./files/nvim;
      recursive = true;
    };
  };

  services = {
    lorri.enable = true;
  };

  programs = {
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
      enable = true;
      extraPackages = tpkgs: {
        inherit (tpkgs) scheme-medium collection-latexextra
          collection-bibtexextra collection-publishers;
      };
    };
  };

  home = {
    sessionVariables = {
        EDITOR = "nvim";
    };

    packages = with pkgs; [
      # required by other tools
      sqlite python3

      neovim vim emacs

      # git git-lfs
      gitAndTools.gitflow tig gitAndTools.git-extras

      # nixfmt nix-doc
      niv

      cloc

      pandoc
      zeal

      # texlive.combined.scheme-full
    ];

    # Use home.file instead of programs.<editor> due to I want to have a structure
    # config file for them.
    file = {
      ".tigrc".text = ''
        set log-options = --show-signature
        set diff-options = --show-signature
      '';
      ".gnupg/gpg.conf".text = ''
        keyserver hkps://keys.openpgp.org
      '';
      ".vimrc".source = ./files/vimrc;
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
    };
  };
}
