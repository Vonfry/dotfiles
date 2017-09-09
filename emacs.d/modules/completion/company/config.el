;;; company config -*- lexical-binding: t -*-
;;

(use-package! company
  :config
  (custom-set-variables
    '(company-idle-delay 0.2)
    '(company-tooltip-limit 16)
    '(company-tooltip-flip-when-above t))
  (add-hook 'after-init-hook 'global-company-mode))

(use-package! helm-company
  :after company helm
  :config
  (define-key company-mode-map (kbd "M-;") 'helm-company)
  (define-key company-active-map (kbd "M-;") 'helm-company))

(use-package! company-quickhelp
  :after company
  :config
  (add-hook 'global-company-mode-hook 'company-quickhelp-mode))
