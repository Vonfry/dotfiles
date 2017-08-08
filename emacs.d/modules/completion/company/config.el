;;; company config -*- lexical-binding: t -*-

(vonfry|use-package! company
  :config
  (custom-set-variables
    '(company-tooltip-limit 16)
    '(company-tooltip-flip-when-above t)
    )
  (add-hook 'after-init-hook 'global-company-mode))

(vonfry|use-package! helm-company
  :after company helm
  :config
  (define-key company-mode-map (kbd "C-;") 'helm-company)
  (define-key company-active-map (kbd "C-;") 'helm-company))

(vonfry|use-package! company-quickhelp
  :after company
  :config
  (add-hook 'global-company-mode-hook 'company-quickhelp-mode))
