;;; mpv/packages.el --- -*- lexical-binding: t -*-
;;

(use-package mpv
  :general
  (nmap-at
    "v ." 'mpv-play
    "v v" 'mpv-start
    "v p" 'mpv-pause
    "v k" 'mpv-kill
    "v h" 'mpv-seek-backward
    "v l" 'mpv-seek-forward
    "v {" 'mpv-speed-decrease
    "v }" 'mpv-speed-increase
    "v j" 'mpv-volume-decrease
    "v k" 'mpv-volume-increase
    "v i" 'mpv-insert-playback-position
    "v s" 'mpv-seek-to-position-at-point
    "v L" 'mpv-playlist-next
    "v H" 'mpv-playlist-prev))
