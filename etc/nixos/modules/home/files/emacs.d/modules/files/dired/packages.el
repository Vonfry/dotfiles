;;; dired/packages.el --- -*- lexical-binding: t -*-

(use-package dired
  :ensure nil
  :custom
  (dired-dwim-target t)
  (dired-guess-shell-alist-user
   (list
    (list
     (rx ".pdf" eos)
     "zathura")
    (list
     (rx "." (| "png" (: "jp" (? "e") "g") "gif") eos)
     "feh -.")
    (list
     (rx "." (| "mp3" "mp4" "wav" "flac" "mkv" "mov") eos)
     "mpv")
    (list
     (rx "." (| "zip" "7z" (: "tar." word) "rar") eos)
     "ouch list")))
  (dired-listing-switches "-ahl")
  (image-dired-thumbnail-storage 'standard)
  :general
  (nmap-leader
    "d"   'dired-jump
    "D D" 'dired
    "D o" 'dired-jump-other-window
    "D O" 'dired-other-window))
