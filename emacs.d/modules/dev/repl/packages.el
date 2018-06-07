;;; repl packages -*- lexical-binding: t -*-
;;

(package! repl-toggle
  :custom
  (rtog/goto-buffer-fun 'pop-to-buffer)
  (rtog/mode-repl-alist '((emacs-lisp-mode . ielm)
                          (ruby-mode . inf-ruby)
                          (haskell-mode . haskell-interactive-bring)
                          (scheme-mode . geiser)
                          (lisp-mode . slime)
                          (lisp-interaction-mode . ielm)
                          (js2-mode . node)
                          (ess-mode .
                            (lambda ()
                             (cond
                               ((string= "S" ess-language) (call-interactively 'R))
                               ((string= "STA" ess-language) (call-interactively 'stata))
                               ((string= "SAS" ess-language) (call-interactively 'SAS)))))))
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-repl 'rtog/toggle-repl))
