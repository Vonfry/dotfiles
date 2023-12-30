;;; snippet/packages.el --- -*- lexical-binding: t -*-
;;

(use-package tempel
  :after smart-tab
  :init
  (let ((snippet-local-dir (file-name-directory +snippet-local-path)))
    (unless (file-exists-p snippet-local-dir)
      (make-directory snippet-local-dir)))
  :custom
  (tempel-path
   (list +snippet-local-path
         (expand-file-name "completion/snippet/templates/*.eld"
                           vonfry-modules-dir)))
  (tempel-auto-reload nil) ; disable it due to fixed file in home-manager
  :general
  ("C-;" 'tempel-insert))

(use-package tempel-collection :after tempel)
