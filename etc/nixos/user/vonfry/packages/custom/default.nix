with import <nixpkgs> {};

{
  python = callPackage ./dev-lang/python { python = python3; };
  ruby = callPackage ./dev-lang/ruby { };
  xmonad = callPackage ./x11-wm/xmonad { };
}
