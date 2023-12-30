;;; julia/packages.el --- -*- lexical-binding: t -*-
;;

(use-package julia-mode)

(use-package julia-repl
  :after julia-mode
  :hook julia-mode
  :general
  (nmap-leader :keymaps 'julia-mode-map
    "\"" 'julia-repl)
  (nmap-mode :keymaps 'julia-repl-mode-map
    "a" 'julia-repl-activate-parent
    "b" 'julia-repl-send-buffer
    "c" 'julia-repl-send-region-or-line
    "d" 'julia-repl-doc
    "e" 'julia-repl-edit
    "l" 'julia-repl-list-methods
    "m" 'julia-repl-macroexpand
    "p" 'julia-repl-cd
    "s" 'julia-repl-prompt-set-inferior-buffer-name-suffix
    "t" 'julia-repl-includet-buffer
    "v" 'julia-repl-prompt-set-executable-key
    "z" 'julia-repl
    "C-<return>" 'julia-repl-send-line))

(use-package eglot-jl
  :hook (julia-mode . eglot-ensure))
