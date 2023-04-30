;;; project packages -*- lexical-binding: t -*-
;;

(use-package project
  :custom
  (project-list-file (expand-file-name "projects" vonfry-local-dir))
  :config
  (setq project-switch-commands
        (append project-switch-commands
                '((magit-status "Magit status" ?s)
                  (magit-dispatch "Magit dispatch" ?D))))
  :general
  (nmap-leader "P" project-prefix-map)
  (nmap-leader
    "P /" 'project-search
    "P a" 'project-remember-projects-under
    "P A" 'project-forget-project))
