{ xmonad-with-packages }:

xmonad-with-packages.override {
  packages = haskellPackages: with haskellPackages; [ xmonad-contrib ];
}

