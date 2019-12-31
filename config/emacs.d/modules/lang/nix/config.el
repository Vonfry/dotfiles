;;; nix config -*- lexical-binding: t -*-
;;

;; +mmap-mode-nix-def
(vonfry-def-mmap-mode-prefix nix nil
  :keymaps 'nix-mode-map)

;; +mmap-nix-def
(vonfry-def-mmap-leader-prefix nix nil
  :keymaps 'nix-mode-map)
