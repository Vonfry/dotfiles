;;; repl config -*- lexical-binding: t -*-

(use-package! repl-toggle
  :custom
  (rtog/goto-buffer-fun 'switch-to-buffer)
  (rtog/mode-repl-alist '((emacs-lisp-mode . ielm)
                          (ruby-mode . inf-ruby)
                          (intero-mode . intero-repl)
                          (scheme-mode . geiser)
                          (lisp-mode . slime)
                          (lisp-interaction-mode . ielm)
                          (elpy-mode . elpy-shell-switch-to-shell)))
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-repl 'rtog/repl-toggle))
