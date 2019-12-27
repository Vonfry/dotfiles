;;; cloud packages -*- lexical-binding: t -*-
;;

(+mmap-at-def
  "c"   '(nil :which-key "cloud sync")
  "c g" '+cloud-get
  "c p" '+cloud-push
  "c c" '+cloud-copy-to
  "c C" '+cloud-copy-from)
