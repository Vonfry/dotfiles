;;; nix config -*- lexical-binding: t -*-
;;

;; +mmap-mode-nix-def
(mmap-mode-prefix! nix nil
  :keymaps 'nix-mode-map)

;; +mmap-nix-def
(mmap-leader-prefix! nix nil
  :keymaps 'nix-mode-map)
