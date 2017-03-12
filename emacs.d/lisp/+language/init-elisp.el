(require-package 'lispy)
(defun vonfry/setup-elisp-mode ()
  (lispy-mode 1)
  (defun vonfry/setup-semantic-elisp ()
    (require 'semantic)
    (add-hook 'emacs-lisp-mode-hook 'semantic-mode)
    (with-eval-after-load 'semantic
                          (semantic-default-elisp-setup)))

    (setq evil-shift-width 2)
    (setq tab-width 2)
  (add-hook 'emacs-lisp-mode-hook 'vonfry/setup-semantic-elisp))

(add-hook 'emacs-lisp-mode-hook 'vonfry/setup-elisp-mode)

(provide 'init-elisp)
