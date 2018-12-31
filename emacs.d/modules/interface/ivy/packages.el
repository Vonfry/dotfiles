;;; ivy packages -*- lexical-binding: t -*-
;;

(package! amx
  :custom
  (amx-save-file (expand-file-name "amx-items" vonfry-cache-dir)))

(package! ivy
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers t)
  :general
  (nmap :prefix +nmap-leader
        +nmap-buffer-switch 'ivy-switch-buffer))

(package! swiper
  :custom
  (swiper-action-recenter t)
  :general
  (nmap :prefix +nmap-leader
        +nmap-swiper 'swiper
        +nmap-buffer-switch 'ivy-switch-buffer))

(package! counsel
  :custom
  (counsel-find-file-at-point t)
  :general
  ("M-x" 'counsel-M-x)
  ("C-x r b" 'counsel-bookmark)
  ("C-x C-f" 'counsel-find-file)
  ("M-[" 'counsel-company)
  (nmap :prefix +nmap-leader
        +nmap-M-x   'counsel-M-x
        +nmap-file  'counsel-find-file
        +nmap-marks 'counsel-mark-ring
        +nmap-pop-complete 'counsel-complete))

(package! ivy-rich
  :after counsel
  :config
  (ivy-rich-mode 1))
