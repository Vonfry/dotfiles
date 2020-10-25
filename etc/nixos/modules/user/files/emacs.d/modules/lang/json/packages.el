;;; json packages -*- lexical-binding: t -*-
;;

(package! json-mode
  :general
  (+mmap-mode-json-def
   "=" 'json-pretty-print
   "f" 'json-pretty-print-buffer))
