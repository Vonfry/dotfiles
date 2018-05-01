;;; lisp config -*- lexical-binding: t -*-

(use-package! geiser
  :hook
  (scheme-mode .
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'geiser))))

