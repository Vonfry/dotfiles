;;; projectile packages -*- lexical-binding: t -*-
;;

;; If you want to use a project's emacs configure, please see more about __.dir-locals.el__ and
;; (projectile-edit-dir-locals)

(package!  projectile
  :init
  (unless (file-exists-p +projectile-cache-dir)
    (make-directory +projectile-cache-dir))
  :custom
  (projectile-enable-caching t)
  (projectile-file-exists-local-cache-expire (* 7 24 60))
  (projectile-known-projects-file +projectile-cache-known-project-file)
  (projectile-completion-system 'ivy)
  (projectile-cache-file +projectile-cache-file)
  (projectile-tags-command "ctags -R --fields=+latinKS --extra=+qf .")
  :general
  (+mmap-mode-cc-def "h" 'projectile-find-other-file)
  (+mmap-leader-def
    "P i" 'projectile-invalidate-cache)
  :config
  (projectile-global-mode t))

(package! counsel-projectile
  :after projectile counsel
  :hook (projectile-mode . counsel-projectile-mode)
  :general
  (+mmap-leader-def
    "p"   'counsel-projectile
    "a"   'counsel-projectile-rg
    "P"   '(nil :which-key "projectile")
    "P a" 'counsel-projectile-rg
    "P A" 'projectile-add-known-project
    "P p" 'counsel-projectile
    "P s" 'counsel-projectile-switch-project
    "P f" 'counsel-projectile-find-file
    "P F" 'counsel-projectile-find-file-dwim
    "P d" 'counsel-projectile-find-dir
    "P b" 'counsel-projectile-switch-to-buffer
    "P c" 'counsel-projectile-org-capture
    "P g" 'counsel-projectile-org-agenda))

(package! org-projectile
  :after projectile org org-agenda
  :custom
  (org-projectile-per-project-filepath +org-projectile-todo-project-file)
  :general
  ("C-c n p" 'org-projectile-project-todo-completing-read)
  ("C-c c" 'org-capture)
  (+mmap-todo-def
    "," 'org-projectile-project-todo-completing-read
    "." 'org-projectile-goto-location-for-project)
  :hook
  (projectile-mode . (lambda () (add-to-list 'org-agenda-files (org-projectile-todo-files))))
  :config
  (org-projectile-per-project))
