;; shell packages -*- lexical-binding: t -*-
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
  (eshell-directory-name (expand-file-name "eshell/" vonfry-cache-dir))
  :ensure nil)

(package! company-shell
  :after (company eshell)
  :hook
  ((eshell-mode shell-mode) . (lambda ()
    (+company-set-backends-grouped '(company-shell company-shell-env)))))

(nmap-leader
  "$" '+shell-open-term-at-pwd)
