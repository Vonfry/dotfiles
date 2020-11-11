;;; ivy config -*- lexical-binding: t -*-
;;

;; +mmap-ivy-def
(mmap-leader-prefix! ivy "i")
(map-which-key! +mmap-ivy-def "ivy")

;; +mmap-mode-outline-def
(mmap-mode-prefix! outline nil
  :keymaps '(outline-mode-map))
