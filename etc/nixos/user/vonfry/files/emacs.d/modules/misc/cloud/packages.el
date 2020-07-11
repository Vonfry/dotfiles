;;; cloud packages -*- lexical-binding: t -*-
;;


;; rclone mount is good, but slowly to edit file, each time we need to wait for
;; fetching date, so I use this method to sync date manual.
(+mmap-at-def
  "C"   '(nil :which-key "cloud sync")
  "C g" '+cloud-get
  "C p" '+cloud-push
  "C c" '+cloud-copy-to
  "C C" '+cloud-copy-from)
