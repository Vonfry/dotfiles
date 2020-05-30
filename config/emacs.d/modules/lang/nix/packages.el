;;; nix config -*- lexical-binding: t -*-
;;

(package! nix-mode
  :general
  (+mmap-nix-def
    "\"" 'nix-repl
    "r"  'nix-build)
  (+mmap-mode-nix-def
    "u"  'nix-unpack))
