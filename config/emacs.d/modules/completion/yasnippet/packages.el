;;; yasnippet packages -*- lexical-binding: t -*-
;;

(package! yasnippet
  :after company
  :custom
  (yas-snippet-dirs +yas-snippet-dirs)
  :general
  ("C-;" 'yas-insert-snippet)
  :config
  (yas-global-mode 1)
  (package! yasnippet-snippets))
