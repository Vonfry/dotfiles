(require-package 'helm)
(require-package 'helm-projectile)
(require-package 'helm-ag)
(require-package 'helm-gtags)
(require-package 'helm-swoop)

(add-hook 'ggtags-mode-hook 'helm-gtags-mode)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-mode-fuzzy-match                 t
      helm-completion-in-region-fuzzy-match t
      helm-recentf-fuzzy-match              t
      helm-buffers-fuzzy-matching           t
      helm-recentf-fuzzy-match              t
      helm-buffers-fuzzy-matching           t
      helm-locate-fuzzy-match               t
      helm-M-x-fuzzy-match                  t
      helm-semantic-fuzzy-match             t
      helm-imenu-fuzzy-match                t
      helm-apropos-fuzzy-match              t
      helm-lisp-fuzzy-completion            t)
(helm-mode 1)

(require-package 'helm-dash)
(require 'helm-dash)
(with-eval-after-load 'dash
  (setq helm-dash-browser-func 'browse-url-default-macosx-browser))
(with-eval-after-load 'projectile
  (helm-projectile-on))


(add-hook 'evil-local-mode-hook
  (lambda ()
   (evil-leader/set-key
    "s"  'helm-swoop
    "x"  'helm-M-x
    "a"  'helm-projectile-ag
    "p"  'helm-projectile-find-file
    "dd" 'helm-dash
    "dp" 'helm-dash-at-point
    "da" 'helm-dash-activate-docset
    "f"  'helm-find-files
    "gt" 'helm-gtags-find-tag
    "gd" 'helm-gtags-dwim
    "gf" 'helm-gtags-find-files
    "gc" 'helm-gtags-create-tags
    "gu" 'helm-gtags-update-tags
    "g." 'helm-gtags-select)))


(provide 'init-helm)
