;;; yasnippet packages -*- lexical-binding: t -*-
;;

(package! yasnippet-snippets)

(package! yasnippet
  :after company
  :custom
  (yas-snippet-dirs
   (list (expand-file-name "snippets/" vonfry-local-dir)
         (expand-file-name "../snippets" load-file-name)
         'yasnippet-snippets-dir))
  :general
  ("C-;" 'yas-insert-snippet)
  :config
  (yas-global-mode 1))
