;;; julia packages -*- lexical-binding: t -*-
;;

(use-package julia-mode
  :general
  (nmap-leader :keymaps 'julia-mode-map
    "\"" 'inferior-julia))

(use-package eglot-jl
  :hook (julia-mode . eglot-ensure))
