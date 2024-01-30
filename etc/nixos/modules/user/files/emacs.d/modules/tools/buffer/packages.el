;;; buffer/packages.el --- -*- lexical-binding: t -*-
;;

(use-package bufler
  :config
  :general
  ("C-x C-b" 'bufler)
  ("C-x C-B" 'bufler-switch-buffer)
  (nmap-leader
    "B B" 'bufler-switch-buffer
    "B b" 'bufler))
