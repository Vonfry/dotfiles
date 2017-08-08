;;; yasnippet packages -*- lexical-binding: t -*-

(vonfry|packages! yasnippet
  :after company
  :config
  (custom-set-variables
    '(yas-snippet-dirs
      (list (expand-file-name "snippets/" vonfry-local-dir)
            (expand-file-name "snippets/" vonfry-custom-dir)
            (expand-file-name "yasmate/snippets/" yas--loaddir)
            yas-installed-snippets-dir)))
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (global-set-key (kbd "C-,") 'company-yasnippet)
  (push '(company-semantic :with company-yasnippet) company-backends))
