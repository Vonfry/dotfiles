;;; media/packages.el --- -*- lexical-binding: t -*-
;;

(use-package emms
  :custom
  (emms-directory (expand-file-name "emms" vonfry-cache-dir))
  (emms-setup-default-player-list '(emms-player-mpv))
  (emms-cache-file (expand-file-name "cache" emms-directory))
  (emms-browser-covers 'emms-browser-cache-thumbnail-async)
  (emms-info-asynchronously t)
  (emms-browser-thumbnail-directory
   (expand-file-name "emms/thumbnails" vonfry-cache-dir))
  (emms-history-file (expand-file-name "emms/history" vonfry-local-dir))
  (emms-score-file (expand-file-name "emms/score" vonfry-local-dir))
  (emms-streams-file (expand-file-name "emms/streams" vonfry-local-dir))
  (emms-info-functions '(emms-info-native emms-info-cueinfo))
  (emms-lyrics-dir (expand-file-name "lyrics" (xdg-user-dir "MUSIC")))
  (emms-player-mpv-ipc-socket
   (expand-file-name "emms-mpv-ipc.socket" temporary-file-directory))
  :general
  (nmap-at
    "m s" 'emms-start
    "m u" 'emms-play-url
    "m f" 'emms-play-file
    "m /" 'emms-play-find
    "m SPC" 'emms-pause
    "m S" 'emms-stop
    "m j" 'emms-next
    "m k" 'emms-previous
    "m '" 'emms-show
    "m g" 'emms-playlist-mode-go
    "m m" 'emms-metaplaylist-mode-go
    "m b" 'emms-browser)
  :config
  (emms-all)
  (emms-default-players)
  (emms-history-load))

(use-package mpvi
  :general
  (nmap-at
    "v v" 'mpvi-open
    "v c" 'mpvi-clip
    "v e" 'mpvi-emms-add
    "v s" 'mpvi-seek))
