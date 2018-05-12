;;; bm packages -*- lexical-binding: t -*-
;;

(package! bm
  :general
  (nmap :prefix +bm-nmap-prefix
    "t" 'bm-toggle
    "m" 'counsel-bookmark))
