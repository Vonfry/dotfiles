pkgs:

with pkgs; [
  haskellPackages.hindent
  haskellPackages.dhall
  haskellPackages.hoogle

  universal-ctags
  doxygen
  shfmt
  shellcheck 

  texlive.combined.scheme-basic
  poppler
  pandoc

  python36Packages.python-language-server
  python36Packages.pip
  python36Packages.setuptools
  python36Packages.wheel
  python36Packages.virtualenv
  python36Packages.ipython
  python36Packages.python-language-server[all]
  httpstat
  mycli
  pgcli
  python36Packages.neovim
  asciinema
  python36Packages.scipy
  python36Packages.numpy
  python36Packages.pandas
  python36Packages.matplotlib
  python36Packages.sympy
]
