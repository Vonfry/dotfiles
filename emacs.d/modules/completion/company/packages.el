;;; company packages -*- lexical-binding: t -*-
;;

(package! company
  :custom
  (company-idle-delay 1) ; We can use (ivy|helm)-company to select, so use a long delay.
  (company-tooltip-limit 16)
  (company-minimum-prefix-length 4)
  (company-tooltip-flip-when-above t)
  :config
  (global-company-mode))

(package! company-quickhelp
  :after company
  :hook (company-mode . company-quickhelp-mode))
