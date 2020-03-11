;;; lsp config -*- lexical-binding: t -*-
;;

;; +mmap-lsp-def
(mmap-leader-prefix! lsp nil
  :keymaps 'lsp-mode-map)

;; +mmap-code-def
(mmap-leader-prefix! code ";"
  :keymaps 'prog-mode-map)
(map-which-key! +mmap-code-def "code")

;; +mmap-prog-def
(mmap-leader-prefix! prog nil
  :keymaps 'prog-mode-map)
