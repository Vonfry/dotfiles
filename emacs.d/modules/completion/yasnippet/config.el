;;; yasnippet packages -*- lexical-binding: t -*-

(vonfry|packages! yasnippet
  :after company
  :config
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (global-set-key (kbd "C-,") 'company-yasnippet)
  (push '(company-semantic :with company-yasnippet) company-backends))
