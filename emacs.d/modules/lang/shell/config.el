;;; shell packages -*- lexical-binding: t -*-


(setq eshell-cmpl-cycle-completions nil
      ;; auto truncate after 20k lines
      eshell-buffer-maximum-lines 20000
      ;; history size
      eshell-history-size 350
      ;; no duplicates in history
      eshell-hist-ignoredups t
      ;; buffer shorthand -> echo foo > #'buffer
      eshell-buffer-shorthand t
      ;; my prompt is easy enough to see
      eshell-highlight-prompt nil
      ;; treat 'echo' like shell echo
      eshell-plain-echo-behavior t
      ;; cache directory
      eshell-directory-name (expand-file-name  "eshell/") vonfry-local-dir)

(vonfry|use-package! company-shell
  :after company
  :config
  (add-to-list (make-local-variable 'company-backends) '(company-shell company-shell-env company-fish-shell)))
