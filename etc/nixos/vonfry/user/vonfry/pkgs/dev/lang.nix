pkgs:

with pkgs; [
  haskellPackages.brittany
  haskellPackages.dhall
  haskellPackages.hoogle

  universal-ctags
  doxygen
  shfmt
  shellcheck 
  yq

  texlive.combined.scheme-basic
  poppler
  pandoc

  bundix
  bundler
  solargraph
  # TOOD vonfry.rubyenv

  python36Packages.python-language-server
  httpstat
  mycli
  pgcli
  asciinema
  # TODO pyenv or withPackages
  python36Packages.ipython
  python36Packages.neovim
  python36Packages.pip
  python36Packages.setuptools
  python36Packages.wheel

  # TODO vonfry.nodeenv
]
