;;; mpv/packages.el --- -*- lexical-binding: t -*-
;;

(use-package empv
  :after embark
  :config
  (empv-embark-initialize-extra-actions)
  :general
  (nmap-at "v" empv-map))
