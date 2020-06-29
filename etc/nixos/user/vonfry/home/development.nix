{ lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  # Use home.file instead of programs.<editor> due to I want to have a structure
  # config file for them.
  home.file = {
    ".tigrc".text = ''
      set log-options = --show-signature
      set diff-options = --show-signature
    '';
    ".gnupg/gpg.conf".text = ''
      keyserver hkps://keys.openpgp.org
    '';
    ".config/emacs.d" = {
      source = ./files/emacs.d;
      recursive = true;
    };
    ".config/nvim" = {
      source = ./files/nvim;
      recursive = true;
    };
    ".vimrc".source = ./files/vimrc;
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
      lib.optionalString isDarwin ''
        $out_dir = "latex.out";
        $pdf_mode = 5;
        $pdf_previewer = 'open -a Skim';
        $pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode';
        @generated_exts = (@generated_exts, 'synctex.gz');
      '' + lib.optionalString isLinux ''
        $out_dir = "latex.out";
        $pdf_mode = 5;
        $dvi_previewer = 'xdvi -watchfile 1.5';
        $ps_previewer  = 'feh';
        $pdf_previewer = 'zathura';
      '';
  };
  services = lib.optionalAttrs isLinux {
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
      enable = isLinux;
      extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
    };
  };
}
