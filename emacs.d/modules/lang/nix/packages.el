;;; nix config -*- lexical-binding: t -*-
;;

(package! nix-mode
  :general
  (+nmap-lang-nix-def
    "'"  'nix-repl
    "u"  'nix-unpack
    "c"  'nix-build))
