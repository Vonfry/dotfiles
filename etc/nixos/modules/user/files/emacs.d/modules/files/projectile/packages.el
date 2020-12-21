;;; projectile packages -*- lexical-binding: t -*-
;;

;; If you want to use a project's emacs configure, please see more about __.dir-locals.el__ and
;; (projectile-edit-dir-locals)

(package! projectile
  :init
  (unless (file-exists-p +projectile-cache-dir)
    (make-directory +projectile-cache-dir t))
  :custom
  (projectile-enable-caching t)
  (projectile-file-exists-local-cache-expire (* 7 24 60))
  (projectile-known-projects-file +projectile-cache-known-project-file)
  (projectile-completion-system 'ivy)
  (projectile-cache-file +projectile-cache-file)
  (projectile-tags-command "ctags -R --fields=+latinKS --extra=+qf .")
  :general
  (+mmap-mode-cc-def "h" 'projectile-find-other-file)
  (+mmap-proj-def
    "r" 'projectile-run-project
    "i" 'projectile-invalidate-cache
    "t" 'projectile-toggle-between-implementation-and-test
    "h" 'projectile-find-other-file
    "H" 'projectile-find-other-file-other-window
    "!" 'projectile-run-shell-command-in-root
    "q" 'projectile-switch-open-project
    "A" 'projectile-add-known-project
    "x" 'projectile-commander)
  (:keymaps 'projectile-mode-map
    "C-c p" 'projectile-command-map)
  :config
  (projectile-global-mode t))

(package! counsel-projectile
  :after (projectile counsel)
  :hook (projectile-mode . counsel-projectile-mode)
  :general
  (+mmap-leader-def
    "p"   'counsel-projectile
    "a"   'counsel-projectile-rg)
  (+mmap-proj-def
    "a" 'counsel-projectile-rg
    "p" 'counsel-projectile-switch-project
    "f" 'counsel-projectile-find-file-dwim
    "d" 'counsel-projectile-find-dir
    "b" 'counsel-projectile-switch-to-buffer
    "c" 'counsel-projectile-org-capture
    "g" 'counsel-projectile-org-agenda))

(package! org-projectile
  :after (projectile org org-agenda)
  :general
  ("C-c n p" 'org-projectile-project-todo-completing-read)
  (+mmap-todo-def
    "," 'org-projectile-project-todo-completing-read
    "c" 'org-projectile-capture-for-current-project
    "." 'org-projectile-goto-location-for-project)
  :hook
  (projectile-mode . (lambda () (add-to-list 'org-agenda-files (org-projectile-todo-files))))
  :config
  (org-projectile-per-project))
