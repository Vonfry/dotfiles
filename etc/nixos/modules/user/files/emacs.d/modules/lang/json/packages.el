;;; json packages -*- lexical-binding: t -*-
;;

(package! json-mode
  :general
  (nmap-mode :keymaps 'json-mode-map
   "=" 'json-pretty-print
   "f" 'json-pretty-print-buffer))
