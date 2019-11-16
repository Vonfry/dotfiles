;;; company packages -*- lexical-binding: t -*-
;;

(package! company
  :custom
  (company-idle-delay 0.5)
  (company-tooltip-limit 16)
  (company-minimum-prefix-length 4)
  (company-tooltip-flip-when-above t)
  (company-tooltip-offset-display 'lines)
  :config
  (global-company-mode))

(package! company-quickhelp
  :after company
  :config
  (company-quickhelp-mode t))

(package! company-prescient
  :after company prescient
  :config
  (company-prescient-mode t))
