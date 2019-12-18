;;; yasnippet packages -*- lexical-binding: t -*-
;;

(package! yasnippet
  :after company
  :custom
  (yas-snippet-dirs
    (list (expand-file-name "snippets/" vonfry-local-dir)
          (expand-file-name "snippets/" vonfry-custom-dir)
          +yas-snippet-dir
          'yasnippet-snippets-dir))
  :hook (company-mode . yas-minor-mode)
  :config
  (dolist (tmp-dir yas-snippet-dirs)
    (unless (or (not (stringp tmp-dir)) (file-exists-p tmp-dir))
      (make-directory tmp-dir))))

(package! yasnippet-snippets
  :after yasnippet)

(package! ivy-yasnippet
  :after yasnippet ivy
  :custom
  (ivy-yasnippet-expand-key 'smart)
  :general
  (:keymaps '(prog-mode-map Tex-mode-map org-mode-map)
    "C-;" 'ivy-yasnippet))
