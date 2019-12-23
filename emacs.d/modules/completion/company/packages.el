;;; company packages -*- lexical-binding: t -*-
;;

(package! company
  :custom
  (company-idle-delay 0.2)
  (company-tooltip-limit 16)
  (company-minimum-prefix-length 4)
  (company-tooltip-flip-when-above t)
  (company-tooltip-offset-display 'lines)
  :general
  (:keymaps 'company-active-map
    "C-n" 'company-select-next
    "C-p" 'company-select-previous)
  :config
  (global-company-mode))

(package! company-quickhelp
  :after company
  :config
  (company-quickhelp-mode t))

(package! company-prescient
  :after company
  :custom
  (prescient-save-file +prescient-save-file)
  :hook
  (company-mode . company-prescient-mode)
  :config
  (prescient-persist-mode t))
