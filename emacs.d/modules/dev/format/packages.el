;;; format packages -*- lexical-binding: t -*-
;;

(package! format-all
  :general
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-leader
        +nmap-format 'format-all-buffer))
