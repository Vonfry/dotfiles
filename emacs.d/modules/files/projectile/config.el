;;; projectile packages -*- lexical-binding: t -*-
;;
;; If you want to use a project's emacs configure, please see more about __.dir-locals.el__ and
;; (projectile-edit-dir-locals)

(use-package!  projectile
  :init
  (defcustom +projectile-cache-dir
    (expand-file-name "projectile/" vonfry-local-dir)
    "projectile cache dir"
    :group 'vonfry-modules)
  (custom-set-variables
    '(projectile-enable-caching t)
    '(projectile-file-exists-local-cache-expire (* 7 24 60))
    '(projectile-known-projects-file +projectile-cache-dir)
    '(projectile-completion-system 'helm)
    '(projectile-cache-file +projectile-cache-dir)
    '(projectile-tags-command "ctags -R --fields=+latinKS --extra=+qf .")
    '(projectile-switch-project-action 'neotree-projectile-action))
  :config
  (projectile-global-mode t))

(use-package! helm-projectile
  :after projectile
  :config
  (helm-projectile-on)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-ctrlp  'helm-projectile-find-file
    vonfry-keybind-evil-search 'helm-projectile-ag))

(use-package! org-projectile
  :after projectile
  :init
  (defcustom +org-projectile-todo-project-file
    "todo.org"
    "org projectile file in project dir. This variable will be seted in `org-projectile-per-project-filepath`."
    :group 'vonfry-modules)
  (custom-set-variables '(org-projectile-per-project-filepath +org-projectile-todo-project-file))
  :general
  ("C-c n p" 'org-projectile-project-todo-completing-read)
  ("C-c c" 'org-capture)
  (nmap :prefix (concat vonfry-keybind-evil-leader vonfry-keybind-evil-todo)
          "$" 'org-projectile-project-todo-completing-read
          "~" 'org-projectile-goto-location-for-project)
  :hook
  (projectile-mode . (lambda () (add-to-list 'org-agenda-files (org-projectile-todo-files))))
  :config
  (org-projectile-per-project)
  (use-package! org-projectile-helm :after helm))

(use-package! ibuffer-projectile
  :after ibuffer
  :hook
  (ibuffer .
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic)))))
