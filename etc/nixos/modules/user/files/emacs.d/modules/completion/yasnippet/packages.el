;;; yasnippet packages -*- lexical-binding: t -*-
;;

(use-package yasnippet
  :init
  (unless (file-exists-p +yasnippet-local-dir)
    (make-directory +yasnippet-local-dir))
  :custom
  (yas-snippet-dirs
   (list '+yasnippet-local-dir
         (expand-file-name "completion/yasnippet/snippets" vonfry-modules-dir)
         'yasnippet-snippets-dir))
  :general
  ("C-;" 'yas-insert-snippet)
  :config
  (use-package yasnippet-snippets)
  (yas-global-mode 1))

(use-package license-snippets
  :after yasnippet
  :config
  (license-snippets-init))
