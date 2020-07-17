;;; cc config -*- lexical-binding: t -*-
;;

;; +mmap-mode-cc-def
(mmap-mode-prefix! cc nil
  :keymaps '(c-mode-map c++-mode-map))

;; +mmap-cc-def
(mmap-leader-prefix! cc nil
  :keymaps '(c-mode-map c++-mode-map))
