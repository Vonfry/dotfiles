{ pkgs, customPkgs, ... }:

let
    hie = customPkgs.hie;
    rubyPkgs = customPkgs.rubyPkgs;
    pythonPkgs = customPkgs.python;
in
with pkgs; [
  zeal

  glibcInfo
  clang-tools

  ghc
  cabal-install
  haskellPackages.dhall
  haskellPackages.hoogle
  haskellPackages.stylish-haskell
  cabal2nix
  hie

  rustup
  rls

  pythonPkgs

  ruby bundler bundix ## rbenv; not! use nix instead.
  rubyPkgs

  doxygen

  coq

  nodejs

  tectonic
  poppler
  pandoc

  solargraph
  ctags

  mycli
  pgcli
]
