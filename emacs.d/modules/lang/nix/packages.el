;;; nix config -*- lexical-binding: t -*-
;;

(package! nix-mode
  :general
  (+nmap-nix-def
    "'"  'nix-repl)
  (+nmap-lang-nix-def
    "u"  'nix-unpack
    "c"  'nix-build))
