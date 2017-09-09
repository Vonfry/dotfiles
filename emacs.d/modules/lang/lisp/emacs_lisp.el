;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

(use-package! ielm
  :config
  (add-hook 'emacs-lisp-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'ielm))))
