(require-package 'slime)
(require-package 'slime-company)
(require-package 'common-lisp-snippets)
(require-package 'lispy)

(defun vonfry/setup-lisp-mode ()
  (lispy-mode 1)
  (setq inferior-lisp-program "sbcl")
  (setq slime-contribs '(slime-fancy))
  (defun vonfry/setup-slime ()
    (slime-setup '(slime-fancy slime-company)))
  (add-hook 'lisp-mode-hook 'vonfry/setup-slime)
  (setq tab-width 2)
  (setq evil-shift-width 2)
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key-for-mode 'lisp-mode
        "." 'lispy-goto-symbol
        "'" 'slime)))
  (ggtags-mode 1))

(add-hook 'lisp-mode-hook 'vonfry/setup-lisp-mode)

(provide 'init-lisp)
