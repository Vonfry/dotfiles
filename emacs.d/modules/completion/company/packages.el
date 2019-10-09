;;; company packages -*- lexical-binding: t -*-
;;

(package! company
  :custom
  (company-idle-delay 0.4)
  (company-tooltip-limit 16)
  (company-minimum-prefix-length 4)
  (company-tooltip-flip-when-above t)
  :config
  (global-company-mode))

(package! company-quickhelp
  :after company
  :hook (company-mode . company-quickhelp-mode))
