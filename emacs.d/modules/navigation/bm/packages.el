;;; bm packages -*- lexical-binding: t -*-
;;

(package! bm
  :general
  (+nmap-bm-def
    "" '(nil :which-key "bookmork")
    "t" 'bm-toggle
    "m" 'counsel-bookmark))
