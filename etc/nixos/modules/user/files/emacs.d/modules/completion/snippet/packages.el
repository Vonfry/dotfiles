;;; snippet packages -*- lexical-binding: t -*-
;;

(use-package tempel
  :after smart-tab
  :init
  (unless (file-exists-p +snippet-local-dir)
    (make-directory +snippet-local-dir))
  :custom
  (tempel-path
   (list +snippet-local-dir
         (expand-file-name "completion/snippet/templates" vonfry-modules-dir)))
  :general
  ("C-;" 'tempel-insert))

(use-package tempel-collection :after tempel)
