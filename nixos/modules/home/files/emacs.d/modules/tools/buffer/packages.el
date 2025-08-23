;;; buffer/packages.el --- -*- lexical-binding: t -*-
;;

(use-package bufler
  :config
  (bufler-mode 1)
  :general
  ("C-x C-b" 'bufler)
  ("C-x C-B" 'bufler-switch-buffer)
  (nmap-leader
    "B"   'bufler
    "k k" 'bufler-switch-buffer
    "k f" 'bufler-workspace-focus-buffer
    "k F" 'bufler-workspace-frame-set))
