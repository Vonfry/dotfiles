;;; lsp config -*- lexical-binding: t -*-
;;

;; +mmap-lsp-def
(vonfry-def-mmap-leader-prefix lsp nil
  :keymaps 'lsp-mode-map)

;; +mmap-lsp-prefix-def
(vonfry-def-mmap-leader-prefix lsp-prefix "*"
  :keymaps 'lsp-mode-map)
