;;; markdown/packages.el --- -*- lexical-binding: t -*-
;;

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :custom
  (markdown-command "multimarkdown")
  (markdown-hide-markup t)
  :general
  (nmap-mode :keymaps 'markdown-mode-map
    "m" 'markdown-toggle-markup-hiding
    "u" 'markdown-toggle-url-hiding
    "r" 'markdown))
