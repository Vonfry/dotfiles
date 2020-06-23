;;; lsp config -*- lexical-binding: t -*-
;;

;; +mmap-lsp-def
(mmap-leader-prefix! lsp nil
  :keymaps 'lsp-mode-map)

;; +mmap-lsp-ext-def
(mmap-leader-prefix! lsp-ext ">"
  :keymaps 'lsp-mode-map)
(map-which-key! +mmap-lsp-ext-def "lsp-ext")

;; +mmap-prog-def
(mmap-leader-prefix! prog nil
  :keymaps 'prog-mode-map)
