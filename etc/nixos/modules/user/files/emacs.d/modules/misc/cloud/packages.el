;;; cloud packages -*- lexical-binding: t -*-
;;


;; rclone mount is good, but slowly to edit file, each time we need to wait for
;; fetching date, so I use this method to sync date manual.
(+mmap-at-def
  "s"   '(nil :which-key "cloud sync")
  "s g" '+cloud-get
  "s p" '+cloud-push
  "s c" '+cloud-copy-to
  "s C" '+cloud-copy-from)
