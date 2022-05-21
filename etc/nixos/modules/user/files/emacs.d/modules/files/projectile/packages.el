;;; projectile packages -*- lexical-binding: t -*-
;;

;; If you want to use a project's emacs configure, please see more about
;; __.dir-locals.el__ and (projectile-edit-dir-locals)

(use-package projectile
  :custom
  (projectile-enable-caching t)
  (projectile-file-exists-local-cache-expire (* 7 24 60))
  (projectile-known-projects-file
   (expand-file-name "projectile" vonfry-local-dir))
  (projectile-cache-file (expand-file-name "projectile" vonfry-cache-dir))
  (projectile-tags-command "ctags -R --fields=+latinKS --extra=+qf .")
  :general
  (nmap-mode :keymaps '(c-mode-map c++-mode-map)
    "h" 'projectile-find-other-file)
  (nmap-leader
    "P"   '(:ignore t :which-key "project"))
  (nmap-leader :keymaps 'projectile-mode-map
    "P r" 'projectile-run-project
    "P i" 'projectile-invalidate-cache
    "P t" 'projectile-toggle-between-implementation-and-test
    "P h" 'projectile-find-other-file
    "P H" 'projectile-find-other-file-other-window
    "P !" 'projectile-run-shell-command-in-root
    "P q" 'projectile-switch-open-project
    "P a" 'projectile-add-known-project
    "P x" 'projectile-commander
    "P k" 'projectile-kill-buffers
    "P f" 'projectile-recentf
    "P *" 'projectile-replace-regexp)
  (:keymaps 'projectile-mode-map
    "C-c p" 'projectile-command-map)
  :config
  (projectile-global-mode t))

(use-package counsel-projectile
  :after (projectile counsel)
  :hook (projectile-mode . counsel-projectile-mode)
  :general
  (nmap-leader :keymaps 'projectile-mode-map
    "p"   'counsel-projectile
    "a"   'counsel-projectile-rg
    "P p" 'counsel-projectile-switch-project
    "P f" 'counsel-projectile-find-file-dwim
    "P d" 'counsel-projectile-find-dir
    "P b" 'counsel-projectile-switch-to-buffer
    "P c" 'counsel-projectile-org-capture
    "P g" 'counsel-projectile-org-agenda))

(use-package org-projectile
  :after (projectile org org-agenda)
  :custom
  (org-projectile-per-project-filepath "todo.org")
  :general
  ("C-c n p" 'org-projectile-project-todo-completing-read)
  (nmap-leader
    "k ," 'org-projectile-project-todo-completing-read
    "k c" 'org-projectile-capture-for-current-project
    "k ." 'org-projectile-goto-location-for-project)
  :hook
  (projectile-mode . (lambda () (add-to-list 'org-agenda-files (org-projectile-todo-files))))
  :config
  (org-projectile-per-project))
