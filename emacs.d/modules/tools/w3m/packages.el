;;; w3m packages -*- lexical-binding: t -*-
;;

(package! w3m
  :general
  (+mmap-at-def
    ""    '(nil :which-key "web/..")
    "w"   '(nil :which-key "browse")
    "."   'browse-url-at-point
    "w w" 'w3m
    "w W" 'browse-url-generic
    "w ." 'w3m-browse-url))
