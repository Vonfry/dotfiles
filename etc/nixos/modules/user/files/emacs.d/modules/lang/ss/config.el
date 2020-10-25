;;; ss config -*- lexical-binding: t -*-
;;


;; +mmap-mode-ss-def
(mmap-mode-prefix! ss nil
  :keymaps '(ess-mode-map))

;; +mmap-ss-def
(mmap-leader-prefix! ss nil
  :keymaps '(ess-mode-map))
;; +mmap-mode-r-def
(mmap-mode-prefix! r nil
  :keymaps '(ess-r-mode-map))

;; +mmap-r-def
(mmap-leader-prefix! r nil
  :keymaps '(ess-r-mode-map))
