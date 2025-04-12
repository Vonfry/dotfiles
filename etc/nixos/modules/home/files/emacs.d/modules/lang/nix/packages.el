;;; nix/config.el --- -*- lexical-binding: t -*-
;;

(use-package nix-mode
  :interpreter ("nix-shell" . nix-shebang-mode)
  :hook ((nix-mode nix-ts-mode) . eglot-ensure)
  :general
  (nmap-leader "' $" 'nix-eshell)
  (nmap-leader :keymaps '(nix-mode-map nix-ts-mode-map)
    "="   'nix-format-buffer
    "\""  'nix-repl
    "' c" 'nix-build)
  (nmap-mode :keymaps '(nix-mode-map nix-ts-mode-map)
    "u"  'nix-unpack
    "/"  'nix-search
    "="  'nix-indent-line))
