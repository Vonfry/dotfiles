;;; snippet/packages.el --- -*- lexical-binding: t -*-
;;

(use-package yasnippet
  :after smart-tab
  :init
  (let ((snippet-local-dir (file-name-directory +snippet-local-path)))
    (unless (file-exists-p snippet-local-dir)
      (make-directory snippet-local-dir)))
  :custom
  (yas-snippet-dirs
   (list '+snippet-local-dir
         (expand-file-name "completion/yasnippet/snippets" vonfry-modules-dir)
         'yasnippet-snippets-dir))
  :general
  ("C-;" 'yas-insert-snippet)
  :config
  (use-package yasnippet-snippets)
  (yas-global-mode 1))
