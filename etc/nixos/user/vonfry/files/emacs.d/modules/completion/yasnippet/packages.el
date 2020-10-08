;;; yasnippet packages -*- lexical-binding: t -*-
;;

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
  (package! yasnippet-snippets)
  (yas-global-mode 1))
