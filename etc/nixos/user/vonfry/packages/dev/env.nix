{ pkgs, customDir, ... }:


with pkgs;
let python = callPackage (customDir + /dev-lang/python) { python = python3; };
    ruby = callPackage (customDir + /dev-lang/ruby) { };
in [
  python
  ruby
]
