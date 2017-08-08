;;; lisp config -*- lexical-binding: t -*-

(vonfry|use-package! geiser
  :config
  (add-hook 'scheme-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'geiser))))

