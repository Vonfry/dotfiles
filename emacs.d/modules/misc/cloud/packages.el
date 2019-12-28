;;; cloud packages -*- lexical-binding: t -*-
;;


;; rclone mount is good, but slowly to edit file, each time we need to wait for
;; fetching date, so I use this method to sync date manual.
(+mmap-at-def
  "c"   '(nil :which-key "cloud sync")
  "c g" '+cloud-get
  "c p" '+cloud-push
  "c c" '+cloud-copy-to
  "c C" '+cloud-copy-from)
