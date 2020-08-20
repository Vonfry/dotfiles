;;; company packages -*- lexical-binding: t -*-
;;

(package! company
  :custom
  (company-idle-delay 0.2)
  (company-tooltip-limit 16)
  (company-minimum-prefix-length 4)
  (company-tooltip-flip-when-above t)
  (company-dabbrev-ignore-case nil)
  (company-tooltip-offset-display 'lines)
  :general
  (:keymaps 'company-active-map
    "C-n" 'company-select-next
    "C-p" 'company-select-previous)
  :config
  (global-company-mode 1))

(package! company-quickhelp
  :after company
  :config
  (company-quickhelp-mode 1))

(package! company-prescient
  :after company
  :custom
  (prescient-save-file (expand-file-name "prescient" vonfry-cache-dir))
  :hook
  (company-mode . company-prescient-mode)
  :config
  (prescient-persist-mode 1))
