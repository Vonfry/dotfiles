;;; yasnippet packages -*- lexical-binding: t -*-
;;

(package! yasnippet
  :after company
  :custom
  (yas-snippet-dirs +yas-snippet-dirs)
  :config
  (yas-global-mode 1)
  (package! yasnippet-snippets))

(package! ivy-yasnippet
  :after yasnippet ivy
  :custom
  (ivy-yasnippet-expand-key 'smart)
  :general
  (:keymaps 
    "C-;" 'ivy-yasnippet))
