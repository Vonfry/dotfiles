;;; ranger packages -*- lexical-binding: t -*-

(package! ranger
  :custom
  (ranger-width-parents 0.2)
  (ranger-width-preview 0.5)
  :general
  (nmap-leader
    "D" 'ranger))
