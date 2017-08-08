;;; shell packages -*- lexical-binding: t -*-

(vonfry|use-package! company-shell
  :after company
  :config
  (add-to-list (make-local-variable 'company-backends) '(company-shell company-shell-env company-fish-shell)))
