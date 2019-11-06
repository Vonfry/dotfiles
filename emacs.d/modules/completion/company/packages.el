;;; company packages -*- lexical-binding: t -*-
;;

(package! company
  :custom
  (company-idle-delay 0.5)
  (company-tooltip-limit 16)
  (company-minimum-prefix-length 4)
  (company-tooltip-flip-when-above t)
  (company-tooltip-offset-display 'lines)
  :general
  (:keymaps company-active-map
    "C-n" 'company-select-next-or-abort
    "C-p" 'company-select-previous-or-abort)
  :config
  (global-company-mode))

(package! company-quickhelp
  :after company
  :hook (company-mode . company-quickhelp-mode))
