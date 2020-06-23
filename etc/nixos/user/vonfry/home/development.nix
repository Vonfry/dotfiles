{ ... }:

{
  # Use home.file instead of programs.<editor> due to I want to have a structure
  # config file for them.
  home.file = {
    ".latexmkrc" = {
      executable = false;
      text = ''
        $out_dir = "latex.out";
        $pdf_mode = 5;
      '';
    };
    ".config/emacs.d" = {
      source = ./files/emacs.d;
      recursive = true;
    };
    ".config/nvim" = {
      source = ./files/nvim;
      recursive = true;
    };
    ".vimrc".source = ./files/vimrc;
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
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
    };
  };
}
