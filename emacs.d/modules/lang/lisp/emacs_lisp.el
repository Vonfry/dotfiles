;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

(package! ielm :ensure nil
  :general
  (nmap :keymaps '(emacs-lisp-mode-map lisp-interaction-mode-map)
        :prefix +nmap-lang-prefix
        "" '(nil :which-key "emacs lisp")
        +nmap-repl  'ielm))

