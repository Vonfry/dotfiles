;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

(use-package! ielm
  :hook
  (emacs-lisp-mode .
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'ielm))))
