;;; yasnippet packages -*- lexical-binding: t -*-
;;

(use-package yasnippet
  :custom
  (yas-snippet-dirs
   (list (expand-file-name "snippets/" vonfry-local-dir)
         (expand-file-name "completion/yasnippet/snippets" vonfry-modules-dir)
         'yasnippet-snippets-dir))
  :general
  ("C-;" 'yas-insert-snippet)
  :config
  (use-package yasnippet-snippets)
  (yas-global-mode 1))

(use-package license-snippets
  :after yasnippet
  :config
  (license-snippets-init))
