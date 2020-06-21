{ pkgs, lib, customPkgs, ... }:

with pkgs;
[ _1password
] ++ lib.optional (!stdenv.isDarwin)
[ tdesktop
  filezilla
  fontforge-gtk
]
