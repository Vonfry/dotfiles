;;; lsp config -*- lexical-binding: t -*-
;;

;; +mmap-lsp-def
(vonfry-def-mmap-leader-prefix lsp nil
  :keymaps 'lsp-mode-map)

;; +mmap-lsp-prefix-def
(vonfry-def-mmap-leader-prefix lsp-prefix "*"
  :keymaps 'lsp-mode-map)

(defcustom +lsp-session-file
  (expand-file-name "lsp-session" vonfry-cache-dir)
  :group 'vonfry-modules
  :type 'file)
