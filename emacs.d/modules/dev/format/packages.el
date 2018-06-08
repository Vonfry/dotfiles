;;; format packages -*- lexical-binding: t -*-
;;

(package! format-all
  :general
  (nmap :prefix +nmap-leader
        +nmap-format 'format-all-buffer))
