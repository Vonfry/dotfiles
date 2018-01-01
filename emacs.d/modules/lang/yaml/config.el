;;; yaml config -*- lexical-binding: t -*-

(use-package! yaml-mode
  :commands (markdown-mode gfm-mode)
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

(use-package! markdown-mode+
  :after markdown-mode)
