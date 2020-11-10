;;; ivy packages -*- lexical-binding: t -*-
;;

(package! amx
  :custom
  (amx-save-file (expand-file-name "amx-items" vonfry-cache-dir)))

(package! flx
  :defer t
  :custom
  (ivy-flx-limit 10000))

(package! ivy
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers nil))

(package! counsel
  :custom
  (counsel-find-file-at-point t)
  :config
  (counsel-mode 1)
  (setq ivy-initial-inputs-alist nil)
  :general
  ("M-x" 'counsel-M-x)
  ("C-x r b" 'counsel-bookmark)
  ("C-x C-f" 'counsel-find-file)
  ("C-&" 'counsel-company)
  (+mmap-prog-def
    "r" 'counsel-compile)
  (+mmap-leader-def
    "x" 'counsel-M-x
    "f" 'counsel-find-file
    "F" '(nil :which-key "counsel misc")
    "F f" 'counsel-fzf
    "F r" 'counsel-recentf
    "b" 'counsel-switch-buffer
    "<" 'counsel-mark-ring
    "?" 'counsel-info-lookup-symbol
    "y" 'counsel-yank-pop
    "m" 'counsel-bookmark
    ";" 'counsel-imenu)
  (+mmap-ivy-def
    "a" 'counsel-rg
    "/" 'counsel-search
    ";" 'counsel-outline
    "p" 'counsel-cd)
  (+mmap-mode-outline-def
    "/" 'counsel-outline)
  (+mmap-mode-org-def
    "f" 'counsel-org-file))

(package! ivy-avy :after (ivy avy))

(package! swiper
  :custom
  (swiper-action-recenter t)
  :general
  (+mmap-ivy-def
    ; use `avy-goto-char-timer' or `evil-search' instead. swiper is slow when
    ;the buffer is large
    "i \\" 'swiper))

(package! ivy-rich
  :after ivy
  :config
  (ivy-rich-mode 1))

(package! counsel-tramp
  :after counsel)
