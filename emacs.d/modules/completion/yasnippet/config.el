;;; yasnippet packages -*- lexical-binding: t -*-

(vonfry|use-package! yasnippet
  :after company
  :init
  (custom-set-variables
    '(yas-snippet-dirs
      (list (expand-file-name "snippets/" vonfry-local-dir)
            (expand-file-name "snippets/" vonfry-custom-dir)
            'yas-installed-snippets-dir)))
  :config
  (dolist (tmp-dir yas-snippet-dirs)
    (unless (or (not (stringp tmp-dir)) (file-exists-p tmp-dir))
      (make-directory tmp-dir)))
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (global-set-key (kbd "M-,") 'company-yasnippet)
  (push '(company-semantic :with company-yasnippet) company-backends))
