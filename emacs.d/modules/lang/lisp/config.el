;;; lisp config -*- lexical-binding: t -*-

(use-package! eldoc)

(use-package! lispy
  :custom
  (lispy-completion-method 'helm)
  (lispy-visit-method      'projectile)
  :hook
  ((minibuffer-setup .
    (lambda ()
      (when (eq this-command 'eval-expression)
      (lispy-mode 1))))
  (lisp-mode .
    (lambda ()
      (custom-set-variables '(compile-command "sbcl"))))
  (lisp-mode       . lispy-mode)
  (emacs-lisp-mode . lispy-mode)
  (scheme-mode     . lispy-mode)
  ((lisp-mode emacs-lisp-mode scheme-mode) .
   (lambda ()
     (nmap :keymaps 'local
           :prefix vonfry-keybind-evil-leader
           vonfry-keybind-evil-jump-to-definition 'lispy-goto-symbol
           vonfry-keybind-evil-jump-module        'lispy-goto-local)))))

(use-package! evil-lispy
  :hook
  ((scheme-mode lisp-mode emacs-lisp-mode) . evil-lispy-mode))

(load (expand-file-name "./common_lisp.el" (file-name-directory load-file-name)))
(load (expand-file-name "./emacs_lisp.el"  (file-name-directory load-file-name)))
(load (expand-file-name "./scheme.el"      (file-name-directory load-file-name)))
