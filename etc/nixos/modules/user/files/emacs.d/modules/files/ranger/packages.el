;;; ranger packages -*- lexical-binding: t -*-

(use-package ranger
  :custom
  (ranger-width-parents 0.3)
  (ranger-width-preview 0.4)
  :config
  (ranger-override-dired-mode t)
  :general
  (nmap-leader
    "d" 'ranger))
