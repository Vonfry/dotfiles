;;; mpdel packages -*- lexical-binding: t -*-
;;

(package! mpdel
  :after evil
  :config
  (dolist (mode '(mpdel-playlist-mode mpdel-tablist-mode mpdel-song-mode
                  mpdel-playlist-stored-playlist-mode mpdel-browser-mode
                  mpdel-playlist-current-playlist-mode))
    (evil-set-initial-state mode 'emacs))
  :general
  (+mmap-at-def
    "m m"       'mpdel-mode
    "m SPC"     'libmpdel-playback-play-pause
    "m M-n"     'libmpdel-playback-next
    "m M-p"     'libmpdel-playback-previous
    "m a"       'mpdel-core-add-to-current-playlist
    "m A"       'mpdel-core-add-to-stored-playlist
    "m r"       'mpdel-core-replace-current-playlist
    "m R"       'mpdel-core-replace-stored-playlist
    "m P"       'mpdel-core-insert-current-playlist
    "m C-x C-j" 'mpdel-core-dired
    "m N"       'mpdel-core-open-artists
    "m L"       'mpdel-core-open-stored-playlists
    "m s s"     'mpdel-core-search-by-title
    "m s l"     'mpdel-core-search-by-album
    "m s r"     'mpdel-core-search-by-artist
    "m ^"       'navigel-open-parent
    "m n"       'next-line
    "m p"       'previous-line
    "m +"       'mpdel-core-volume-increase
    "m -"       'mpdel-core-volume-decrease
    "m C"       'libmpdel-connect-profile
    "m l"       'mpdel-playlist-open
    "m v"       'mpdel-song-open
    "m f"       'mpdel-song-normal-increment
    "m F"       'mpdel-song-small-increment
    "m :"       'mpdel-browser-open
    "m M-f"     'mpdel-song-large-increment
    "m b"       'mpdel-song-normal-decrement
    "m B"       'mpdel-song-small-decrement
    "m M-b"     'mpdel-song-large-decrement))
