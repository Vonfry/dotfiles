;;; snippet/packages.el --- -*- lexical-binding: t -*-
;;

(use-package yasnippet
  :init
  (let ((snippet-local-dir +snippet-local-path))
    (unless (file-exists-p snippet-local-dir)
      (make-directory snippet-local-dir)))
  :custom
  (yas-snippet-dirs
   (list '+snippet-local-path
         (expand-file-name "completion/snippet/templates" vonfry-modules-dir)
         'yasnippet-snippets-dir))
  :general
  ("C-;" 'yas-insert-snippet)
  :config
  (use-package yasnippet-snippets)
  (yas-global-mode 1))
