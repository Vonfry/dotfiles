;;; git config -*- lexical-binding: t -*-
;;

(setq magit-gitflow-popup-key "C-x C-g")

;; +mmap-magit-def
(mmap-leader-prefix! magit nil
  :prefix 'prog-mode-map)
