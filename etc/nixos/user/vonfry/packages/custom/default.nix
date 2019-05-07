with import <nixpkgs> {};

{
  python = callPackage ./dev-lang/python { python = python3; };
  ruby = callPackage ./dev-lang/ruby { };
  hie = callPackage ./dev-haskell/hie { };
  xmonad = callPackage ./x11-wm/xmonad { };
}
