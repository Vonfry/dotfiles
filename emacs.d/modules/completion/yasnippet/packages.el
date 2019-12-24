;;; yasnippet packages -*- lexical-binding: t -*-
;;

(package! yasnippet
  :after company
  :custom
  (yas-snippet-dirs +yas-snippet-dirs)
  :hook (company-mode . yas-minor-mode)
  :config
  (package! yasnippet-snippets))

(package! ivy-yasnippet
  :after yasnippet ivy
  :custom
  (ivy-yasnippet-expand-key 'smart)
  :general
  (:keymaps '(prog-mode-map Tex-mode-map org-mode-map)
    "C-;" 'ivy-yasnippet))
