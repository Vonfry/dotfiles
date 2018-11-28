;;; ivy packages -*- lexical-binding: t -*-
;;

(package! ivy
  :defer t
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-selectable-prompt t)
  (ivy-use-virtual-buffers t))

(package! swiper
  :defer t
  :custom
  (swiper-action-recenter t))

(package! counsel
  :custom
  (counsel-find-file-at-point t)
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

(package! amx :after ivy)

(package! ivy-rich
  :after counsel
  :config
  (ivy-rich-mode 1))
