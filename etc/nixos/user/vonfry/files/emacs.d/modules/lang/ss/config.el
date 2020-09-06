;;; ss config -*- lexical-binding: t -*-
;;

;; +mmap-mode-r-def
(mmap-mode-prefix! r nil
  :keymaps '(ess-r-mode-map))

;; +mmap-r-def
(mmap-leader-prefix! r nil
  :keymaps '(ess-r-mode-map))
