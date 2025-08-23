;;; spaceline/packages.el --- -*- lexical-binding: t -*-
;;

(use-package doom-modeline
  :hook ((server-after-make-frame .
           (lambda () (setq doom-modeline-icon (display-graphic-p)))))
  :custom
  (doom-modeline-lsp t)
  (doom-modeline-mu4e t)
  (doom-modeline-buffer-file-name-style 'file-name)
  :config
  (doom-modeline-mode 1))
