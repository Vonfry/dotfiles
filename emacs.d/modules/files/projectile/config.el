;;; projectile packages -*- lexical-binding: t -*-
;;
;; If you want to use a project's emacs configure, please see more about __.dir-locals.el__ and
;; (projectile-edit-dir-locals)

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
  :disable t
  :after projectile
  :init
  (defcustom +org-projectile-todo-project-file
    "todo.org"
    "org projectile file in project dir. This variable will be appended `projectile-project-root`."
    :group 'vonfry-modules)
  (defcustom +org-projectile-todo-global-file
    (expand-file-name "projects.org" vonfry-org-dir)
    "org projectile file in global org dir. This will be used when projectile isn't in a project."
    :group 'vonfry-modules)
  (defvar +org-projectile-todo-project-file-path nil "todo project path")
  :bind (("C-c n p" . org-projectile-project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (add-hook 'projectile-mode-hook
    (lambda ()
        (setq +org-projectile-todo-project-file-path
          (if (projectile-project-p)
            (expand-file-name +org-projectile-todo-project-file (projectile-project-root))
            +org-projectile-todo-global-file))
        (unless (file-exists-p +org-projectile-todo-project-file-path)
          (write-region "" nil +org-projectile-todo-project-file-path))
        (custom-set-variables '(org-projectile-projects-file +org-projectile-todo-project-file-path))
        (setq org-agenda-files (append org-agenda-files +org-projectile-todo-project-file-path))
        (push (org-projectile-project-todo-entry) org-capture-templates)
        (vonfry|use-package! org-projectile-helm :after helm))))

(vonfry|use-package! ibuffer-projectile
  :after ibuffer
  :config
  (add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic)))))
