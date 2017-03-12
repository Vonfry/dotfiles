(require-package 'imenu-list)
(require-package 'imenu+)
(require 'imenu-list)
(require 'imenu+)
(setq imenu-list-focus-after-activation t)
(setq imenu-list-focus-after-activation t)
(add-hook 'evil-local-mode-hook
  (lambda ()
   (evil-leader/set-key
    "i" 'helm-semantic-or-imenu
    "t" 'imenu-list-smart-toggle)))

(provide 'init-imenu)
