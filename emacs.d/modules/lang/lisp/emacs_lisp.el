;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

(package! ielm :straight nil
  :general
  (nmap :keymaps '(emacs-lisp-mode-map lisp-interaction-mode-map)
        :prefix +nmap-lang-prefix
        +nmap-repl  'ielm))

