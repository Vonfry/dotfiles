;;; buffer packages -*- lexical-binding: t -*-
;;

(use-package bufler
  :config
  :general
  ("C-x C-b" 'bufler)
  (nmap-leader "B" 'bufler))
