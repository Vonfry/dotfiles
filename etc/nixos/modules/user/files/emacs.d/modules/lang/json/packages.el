;;; json packages -*- lexical-binding: t -*-
;;

(use-package json-mode
  :general
  (nmap-mode :keymaps '(json-mode-map json-ts-mode-map)
   "=" 'json-pretty-print
   "f" 'json-pretty-print-buffer))
