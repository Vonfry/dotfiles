;;; nix config -*- lexical-binding: t -*-
;;

(package! nix-mode
  :general
  (+nmap-nix-def
    "\"" 'nix-repl
    "r"  'nix-build)
  (+nmap-lang-nix-def
    "u"  'nix-unpack))
