;;; projectile packages -*- lexical-binding: t -*-
;;

;; If you want to use a project's emacs configure, please see more about __.dir-locals.el__ and
;; (projectile-edit-dir-locals)

(package!  projectile
  :custom
  (projectile-enable-caching t)
  (projectile-file-exists-local-cache-expire (* 7 24 60))
  (projectile-known-projects-file +projectile-cache-known-project-file)
  (projectile-completion-system 'ivy)
  (projectile-cache-file +projectile-cache-file)
  (projectile-tags-command "ctags -R --fields=+latinKS --extra=+qf .")
  :general
  (nmap :prefix +nmap-lang-prefix
        :keymaps '(c-mode-map c++-mode-map objc-mode-map)
        "h" 'projectile-find-other-file)
  :config
  (projectile-global-mode t))

(package! counsel-projectile
  :after projectile counsel
  :hook (projectile-mode . counsel-projectile-mode)
  :general
  (nmap :prefix +nmap-leader
    +nmap-ctrlp  'counsel-projectile-find-file
    +nmap-search 'counsel-projectile-rg))

(package! org-projectile
  :after projectile org org-agenda
  :custom
  (org-projectile-per-project-filepath +org-projectile-todo-project-file)
  :general
  ("C-c n p" 'org-projectile-project-todo-completing-read)
  ("C-c c" 'org-capture)
  (nmap :prefix (concat +nmap-leader +nmap-todo)
        "" '(nil :which-key "todo highlight")
        "," 'org-projectile-project-todo-completing-read
        "." 'org-projectile-goto-location-for-project)
  :hook
  (projectile-mode . (lambda () (add-to-list 'org-agenda-files (org-projectile-todo-files))))
  :config
  (org-projectile-per-project))

(package! ibuffer-projectile
  :after ibuffer projectile
  :hook
  (ibuffer .
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic)))))
