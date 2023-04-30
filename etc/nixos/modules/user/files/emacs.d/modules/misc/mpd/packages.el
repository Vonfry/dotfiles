;;; mpdel packages -*- lexical-binding: t -*-
;;

(use-package mpdel
  :general
  (nmap-at
    "m SPC" 'libmpdel-playback-play-pause
    "m p"   'libmpdel-playback-play-pause
    "m }"   'libmpdel-playback-next
    "m {"   'libmpdel-playback-previous
    "m D"   'mpdel-core-dired
    "m A"   'mpdel-core-open-artists
    "m L"   'mpdel-core-open-stored-playlists
    "m s s" 'mpdel-core-search-by-title
    "m s l" 'mpdel-core-search-by-album
    "m s r" 'mpdel-core-search-by-artist
    "m ^"   'navigel-open-parent
    "m +"   'mpdel-core-volume-increase
    "m -"   'mpdel-core-volume-decrease
    "m C"   'libmpdel-connect-profile
    "m l"   'mpdel-playlist-open
    "m v"   'mpdel-song-open
    "m f"   'mpdel-song-normal-increment
    "m F"   'mpdel-song-small-increment
    "m o"   'mpdel-browser-open
    "m M-f" 'mpdel-song-large-increment
    "m b"   'mpdel-song-normal-decrement
    "m B"   'mpdel-song-small-decrement
    "m M-b" 'mpdel-song-large-decrement))
