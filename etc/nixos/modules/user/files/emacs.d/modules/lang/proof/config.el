;;; proof config -*- lexical-binding: t -*-
;;

;; +mmap-mode-proof-def
(mmap-mode-prefix! proof nil
  :keymaps 'coq-mode-map)

;; +mmap-proof-def
(mmap-leader-prefix! proof nil
  :keymaps 'coq-mode-map)
