;;; d2/pagkages.el --- -*- lexical-binding: t -*-
;;

(use-package d2-mode
  :general
  (nmap-leader :keymaps 'd2-mode-map
    "r" 'd2-compile
    "' b" 'd2-compile-buffer
    "' B" 'd2-compile-buffer-and-browse
    "' f" 'd2-compile-file
    "' F" 'd2-compile-file-and-browse
    )
  (vmap-leader :keymaps 'd2-mode-map
    "r" 'd2-compile-region
    "' RET" 'd2-compile-region-and-browse)
  (nmap-mode :keymaps 'd2-mode-map
    "o" 'd2-open-browse
    "v" 'd2-view-current-svg
    "d" 'd2-open-doc))
