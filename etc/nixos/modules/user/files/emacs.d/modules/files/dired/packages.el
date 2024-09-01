;;; dired/packages.el --- -*- lexical-binding: t -*-

(use-package dired
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
     (rx "." (| "zip" "7z" (: "tar." word)) eos)
     "bsdtar -t")))
  :general
  (nmap-leader
    "d"   'dired-jump
    "D D" 'dired
    "D o" 'dired-jump-other-window
    "D O" 'dired-other-window))
