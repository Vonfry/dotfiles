;;; projectile packages -*- lexical-binding: t -*-

(vonfry|use-package!  projectile
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

(vonfry|use-package! helm-projectile
  :after projectile
  :config
  (helm-projectile-on)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-ctrlp  'helm-projectile-find-file
    vonfry-keybind-evil-search 'helm-projectile-ag))

(vonfry|use-package! org-projectile
  :after projectile
  :init
  (defcustom +org-projectile-todo-file
    (expand-file-name "org/todo-project.org" vonfry-local-dir)
    "org projectile file"
    :group 'vonfry-modules)
  :bind (("C-c n p" . org-projectile-project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (custom-set-variables '(org-projectile-projects-file +org-projectile-todo-file))
  (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
  (push (org-projectile-project-todo-entry) org-capture-templates)
  (vonfry|use-package! org-projectile-helm
    :afteer helm))

(vonfry|use-package! ibuffer-projectile
  :after ibuffer
  :config
  (add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic)))))
