;;; lsp config -*- lexical-binding: t -*-
;;

;; +nmap-lsp-def
(vonfry-def-nmap-leader-prefix lsp nil
  :keymaps 'lsp-mode-map)

;; +nmap-lsp-prefix-def
(vonfry-def-nmap-leader-prefix lsp-prefix "*"
  :keymaps 'lsp-mode-map)
