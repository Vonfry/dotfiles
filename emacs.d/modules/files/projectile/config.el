;;; projectile packages -*- lexical-binding: t -*-

(vonfry|use-package!  projectile
  :config
  (custom-set-variables
    '(projectile-tags-command "ctags -R --fields=+latinKS --extra=+qf .")
    '(projectile-switch-project-action 'neotree-projectile-action))
  (projectile-global-mode t))

(vonfry|use-package! helm-projectile
    :config
    (helm-projectile-on)
    :general
    (nmap :prefix vonfry-keybind-evil-leader
      vonfry-keybind-evil-ctrlp  'helm-projectile-find-file
      vonfry-keybind-evil-search 'helm-projectile-ag))
