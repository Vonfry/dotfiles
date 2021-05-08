;;; evil packages -*- lexical-binding: t -*-
;;

(use-package evil
  :config
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore)
  (advice-add 'vonfry/local-indent
              :after (lambda (int) (setq-local evil-shift-width int)))
  :custom
  (evil-want-keybinding nil)
  (evil-want-integration t)
  (evil-shift-width 4)
  (evil-search-module 'isearch)
  :general
  (nmap ; for dvorak programming layout
    "q" 'evil-backward-char
    "Q" 'evil-window-up
    "h" 'evil-delete-char
    "H" 'evil-delete-backward-char
    "l" 'evil-record-macro
    "L" nil
    "x" 'evil-forward-char
    "X" 'evil-window-bottom)
  (nmap :prefix "g"
        "B" 'previous-buffer
        "b" 'next-buffer)
  (nmap-leader
    "M"   '(:ignore t :which-key "bookmarks")
    "M m" 'bookmark-set
    "M M" 'bookmark-set-no-overwrite
    "M l" 'bookmark-bmenu-list
    "M s" 'bookmark-save
    "M d" 'bookmark-delete
    "M r" 'bookmark-rename
    "M w" 'bookmark-write
    "~"   'eshell
    "!"   'calc
    "\""  'comint-run
    "l"   'list-processes
    "L"   'proced
    "O"   'calendar
    "_"   '+evil/switch-scratch
    "e"   '(:ignore t :which-key "emacs")
    "e s" 'server-start
    "e #" 'server-edit
    "e D" 'diff)
  (vmap-leader
    "="   'align-regexp))

(use-package evil-numbers
  :after evil
  :general
  ("C-c +" 'evil-numbers/inc-at-pt)
  ("C-c -" 'evil-numbers/dec-at-pt))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

(use-package evil-collection
  :after evil
  :custom
  (evil-collection-key-blacklist '("SPC" "S-SPC"))
  :config
  (evil-collection-init))
