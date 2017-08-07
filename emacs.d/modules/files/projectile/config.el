;;; projectile packages -*- lexical-binding: t -*-

(vonfry|use-package!  projectile
  :config
  (custom-set-variables
    '(projectile-tags-command "ctags -R --fields=+latinKS --extra=+qf .")
    '(projectile-switch-project-action 'neotree-projectile-action))
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
  :bind (("C-c n p" . org-projectile-project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (setq org-projectile-projects-file
        (expand-file-name "org/todo-project.org" vonfry-local-dir))
  (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
  (push (org-projectile-project-todo-entry) org-capture-templates))

(vonfry|use-package! org-projectile
  :after projectile
  :config
  (add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic)))))

(vonfry|use-package! ibuffer-projectile
  :after projectile ibuffer
  :config
  (ibuffer-projectile-set-filter-groups)
  (unless (eq ibuffer-sorting-mode 'alphabetic)
    (ibuffer-do-sort-by-alphabetic)))
