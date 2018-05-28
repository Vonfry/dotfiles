;;; yasnippet packages -*- lexical-binding: t -*-
;;

(package! yasnippet
  :after company
  :custom
  (yas-snippet-dirs
    (list (expand-file-name "snippets/" vonfry-local-dir)
          (expand-file-name "snippets/" vonfry-custom-dir)))
  :hook (company-mode . yas-minor-mode)
  :general
  ("M-'" 'company-yasnippet)
  :config
  (dolist (tmp-dir yas-snippet-dirs)
    (unless (or (not (stringp tmp-dir)) (file-exists-p tmp-dir))
      (make-directory tmp-dir)))
  (let ((snippets-default-dir (expand-file-name "snippets/" vonfry-config-dir)))
    (if (file-exists-p snippets-default-dir)
      (delete-directory snippets-default-dir t)
      nil)))

(package! yasnippet-snippets
  :after yasnippet)
