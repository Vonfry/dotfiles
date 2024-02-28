;;; buffer/packages.el --- -*- lexical-binding: t -*-
;;

(use-package bufler
  :config
  :general
  ("C-x C-b" 'bufler)
  ("C-x C-B" 'bufler-switch-buffer)
  (nmap-leader
    "B B" 'bufler-switch-buffer
    "B b" 'bufler
    "B f" 'bufler-workspace-focus-buffer
    "B F" 'bufler-workspace-frame-set))
