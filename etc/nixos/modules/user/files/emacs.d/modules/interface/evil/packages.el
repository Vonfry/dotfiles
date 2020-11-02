;;; evil packages -*- lexical-binding: t -*-
;;

(package! evil
  :config
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore)
  (evil-set-initial-state 'process-menu-mode 'emacs)
  (evil-set-initial-state 'calendar-mode 'emacs)
  (advice-add 'vonfry/local-indent
              :after (lambda (int) (setq-local evil-shift-width int)))
  :custom
  (evil-shift-width 4)
  (evil-search-module 'isearch)
  :general
  (mmap :prefix "g"
        "B" 'previous-buffer
        "b" 'next-buffer)
  (+mmap-leader-def
    "M"   '(nil :which-key "bookmarks")
    "M m" 'bookmark-set
    "M M" 'bookmark-set-no-overwrite
    "M l" 'bookmark-bmenu-list
    "M s" 'bookmark-save
    "M d" 'bookmark-delete
    "M r" 'bookmark-rename
    "M w" 'bookmark-write
    "="   'align-regexp
    "~"   'eshell
    "!"   'calc
    "\""  'comint-run
    "l"   'list-processes
    "L"   'proced
    "O"   'calendar
    "_"   '+evil/switch-scratch
    "'"   '(nil :which-key "repl action")
    "e"   '(nil :which-key "emacs")
    "e s" 'server-start
    "e #" 'server-edit
    "e D" 'diff
    "e d" 'ediff))

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
