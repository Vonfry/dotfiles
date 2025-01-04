;;; pastebin/packages.el --- -*- lexical-binding: t -*-
;;

(use-package 0x0
  :general
  (nmap-at
    "u f" '0x0-upload-file
    "u u" '0x0-shorten-uri
    "u t" '0x0-upload-text
    "u d" '0x0-dwim
    "u p" '0x0-popup))
