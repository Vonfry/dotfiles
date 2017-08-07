;;; lisp config -*- lexical-binding: t -*-

(vonfry|use-package! eldoc)

(vonfry|use-package! lispy
  :config
  (add-hook 'minibuffer-setup-hook
    (lambda ()
      (when (eq this-command 'eval-expression)
      (lispy-mode 1))))
  (add-hook 'lisp-mode-hook       'lispy-mode)
  (add-hook 'emacs-lisp-mode-hook 'lispy-mode)
  (add-hook 'scheme-mode-hook     'lispy-mode))

(vonfry|use-package! evil-lispy
  :config
  (add-hook 'lisp-mode-hook       'evil-lispy-mode)
  (add-hook 'emacs-lisp-mode-hook 'evil-lispy-mode)
  (add-hook 'scheme-mode-hook     'evil-lispy-mode))

(load (expand-file-name "./common_lisp.el" (file-name-directory load-file-name)))
(load (expand-file-name "./emacs_lisp.el"  (file-name-directory load-file-name)))
(load (expand-file-name "./scheme.el"      (file-name-directory load-file-name)))
