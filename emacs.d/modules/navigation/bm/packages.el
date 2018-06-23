;;; bm packages -*- lexical-binding: t -*-
;;

(package! bm
  :general
  (nmap :prefix +bm-nmap-prefix
        "" '(nil :which-key "bookmork")
        "t" 'bm-toggle
        "m" 'counsel-bookmark))
