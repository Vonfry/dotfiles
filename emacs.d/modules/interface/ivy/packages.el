;;; ivy packages -*- lexical-binding: t -*-
;;

(package! ivy)
(package! swiper)
(package! counsel
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers t)
  :general
  ("M-x" 'counsel-M-x)
  ("C-x r b" 'counsel-bookmark)
  ("C-x C-f" 'counsel-find-file)
  (nmap :prefix +nmap-leader
        +nmap-M-x   'counsel-M-x
        +nmap-file  'counsel-find-file
        +nmap-swiper 'swiper
        +nmap-marks 'counsel-mark-ring
        +nmap-buffer-switch 'ivy-switch-buffer))

(package! ivy-rich
  :after counsel
  :config
  (ivy-rich-mode 1))
