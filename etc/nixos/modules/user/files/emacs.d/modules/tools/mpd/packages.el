;;; mpdel/packages.el --- -*- lexical-binding: t -*-
;;

(use-package mpdired
  :general
  (nmap-at
    "m m"   'mpdired
    "m SPC" 'mpdired-pause
    "m v"   'mpdired-set-volume
    "m s"   'mpdired-stop
    "m r"   'mpdired-db-update))
