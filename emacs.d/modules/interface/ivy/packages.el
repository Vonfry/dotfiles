;;; ivy packages -*- lexical-binding: t -*-
;;

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
  (+map-pop-complete 'counsel-company)
  (nmap :prefix +nmap-leader
        +nmap-M-x   'counsel-M-x
        +nmap-file  'counsel-find-file
        +nmap-fzf   'counsel-fzf
        +nmap-marks 'counsel-mark-ring
        +nmap-pop-complete 'counsel-complete))

(package! ivy-rich
  :after ivy
  :config
  (ivy-rich-mode t))

(package! counsel-tramp
  :after counsel)

(package! ivy-prescient
  :after ivy prescient
  :custom
  (prescient-save-file (expand-file-name "prescient" vonfry-cache-dir))
  (ivy-prescient-retain-classic-highlighting t)
  :config
  (ivy-prescient-mode t))
