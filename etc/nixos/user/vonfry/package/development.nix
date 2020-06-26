{ pkgs, customPkgs, ... }:

let
    hie = customPkgs.hie;
    rubyPkgs = customPkgs.ruby;
    pythonPkgs = customPkgs.python;
in with pkgs;
[ # git
  # direnv
  lorri

  cloc
  patchelf
  binutils-unwrapped
  # llvmPackages.clang llvm lldb
  cmake gnumake

  bear

  clang-tools

  ghc
  cabal-install
  haskellPackages.dhall
  haskellPackages.hoogle
  haskellPackages.stylish-haskell
  cabal2nix
  hie

  rustup
  carnix

  pythonPkgs

  rubyPkgs
  solargraph

  doxygen

  coq

  poppler
  pandoc

  ctags

  sqlite
  mysql
  postgresql
  redis

  httpstat
] ++ lib.optionals (!stdenv.isDarwin)
[ # texlive.combined.scheme-full
  zeal
  glibcInfo
]
