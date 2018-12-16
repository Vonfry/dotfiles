;;; javascript packages -*- lexical-binding: t -*-
;;

(package! js2-mode
  :interpreter "node"
  :hook
  ((js2-mode . js2-imenu-extras-mode)
   (js-mode . js2-minor-mode))
  :general
  (nmap :keymaps '(js-mode-map js2-mode-map)
        :prefix +nmap-leader
        +nmap-go-module 'js-find-symbol))
