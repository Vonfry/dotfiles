;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

(vonfry|use-package! ielm
  :config
  (add-hook 'emacs-lisp-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'ielm))))
