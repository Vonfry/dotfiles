;;; mpv/packages.el --- -*- lexical-binding: t -*-
;;

(use-package empv
  :after embark
  :custom
  (empv-mpv-args '("--no-terminal"
                   "--idle"
                   "--input-ipc-server=/tmp/empv-socket"))
  (empv-video-dir (list (xdg-user-dir "VIDEOS")))
  (empv-audio-dir (list (xdg-user-dir "MUSIC")))
  :config
  (empv-embark-initialize-extra-actions)
  :general
  (nmap-at "v" empv-map))
