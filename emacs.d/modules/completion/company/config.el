;;; company config -*- lexical-binding: t -*-
;;

(use-package! company
  :custom
  (company-idle-delay 0.2)
  (company-tooltip-limit 16)
  (company-tooltip-flip-when-above t)
  :hook (after-init . global-company-mode))

(use-package! helm-company
  :after company helm
  :general
  (company-mode-map "M-;" 'helm-company)
  (company-active-map "M-;" 'helm-company))

(use-package! company-quickhelp
  :after company
  :hook (global-company-mode . company-quickhelp-mode))
