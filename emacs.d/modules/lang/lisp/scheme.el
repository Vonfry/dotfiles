;;; lisp config -*- lexical-binding: t -*-
;;

(package! geiser
    :general
    (nmap :keymaps 'scheme-mode-map
          :prefix +nmap-lang-prefix
          "" '(nil :which-key "scheme")
          +nmap-repl  'geiser))
