;;; evil packages -*- lexical-binding: t -*-
;;

(package! evil
  :config
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore)
  :custom
  (evil-shift-width 4)
  (evil-search-module 'evil-search)
  :general
  (mmap :prefix "g"
        "B" 'previous-buffer
        "b" 'next-buffer)
  (+mmap-leader-def
    "z"   '(nil :which-key "mode special")
    "@"   '(nil :which-key "mail/chat/..")
    ";"   '(nil :which-key "code")
    "="   'align-regexp
    "$"   'eshell
    "h"   'evil-ex-nohighlight
    "\""  'comint-run
    "'"   '(nil :which-key "repl action")
    "RET" 'append-to-buffer))

(package! evil-org
  :after evil org
  :hook (org-mode-hook . evil-org-mode)
  :config
  (evil-org-set-key-theme))

(package! evil-org-agenda
  :after evil-org
  :straight nil
  :config
  (evil-org-agenda-set-keys))

(package! evil-numbers
  :after evil
  :general
  ("C-c +" 'evil-numbers/inc-at-pt)
  ("C-c -" 'evil-numbers/dec-at-pt))

(package! evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(package! evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))
