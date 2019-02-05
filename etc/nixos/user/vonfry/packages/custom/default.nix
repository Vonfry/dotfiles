with import <nixpkgs> {};

{
  vonfryPython = callPackage ./dev-lang/python { python = python3; };
  vonfryRuby = callPackage ./dev-lang/ruby { };
  vonfryXmonad = callPackage ./x11-wm/xmonad { };
}
