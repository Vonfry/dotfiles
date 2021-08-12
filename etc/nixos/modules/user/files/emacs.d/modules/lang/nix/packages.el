;;; nix config -*- lexical-binding: t -*-
;;

(use-package nix-mode
  :interpreter ("nix-shell" . nix-shebang-mode)
  :hook (nix-mode . lsp-defer)
  :general
  (nmap-leader :keymaps 'nix-mode-map
    "="  'nix-format-buffer
    "\"" 'nix-repl
    "r"  'nix-build)
  (nmap-mode :keymaps 'nix-mode-map
    "u"  'nix-unpack
    "/"  'nix-search
    "="  'nix-indent-line))
