;;; shell packages -*- lexical-binding: t -*-
;;

(package! eshell
  :custom
  (eshell-cmpl-cycle-completions nil)
  (eshell-buffer-maximum-lines 20000)
  (eshell-history-size 350)
  (eshell-hist-ignoredups t)
  (eshell-buffer-shorthand t)
  (eshell-highlight-prompt nil)
  (eshell-plain-echo-behavior t)
  (eshell-directory-name +eshell-directory-name)
  :straight nil)


(package! company-shell
  :after company eshell
  :config
  (add-to-list 'company-backends '(company-shell company-shell-env company-fish-shell)))
