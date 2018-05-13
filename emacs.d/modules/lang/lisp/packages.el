;;; lisp packages -*- lexical-binding: t -*-
;;

(package! eldoc
  :ensure nil
  :hook
  ((emacs-lisp-mode lisp-interaction-mode ielm-mode) . turn-on-eldoc-mode))

(package! lispy
  :custom
  (lispy-completion-method 'ivy)
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
  (scheme-mode     . lispy-mode))
  :general
  (nmap :keymaps 'lispy-mode-map
        :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-jump-module 'lispy-goto-local))

(load (expand-file-name "./common_lisp.el" (file-name-directory load-file-name)))
(load (expand-file-name "./emacs_lisp.el"  (file-name-directory load-file-name)))
(load (expand-file-name "./scheme.el"      (file-name-directory load-file-name)))
