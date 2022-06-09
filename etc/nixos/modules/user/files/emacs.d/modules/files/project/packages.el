;;; project packages -*- lexical-binding: t -*-
;;

(use-package project
  :custom
  (project-list-file (expand-file-name "projects" vonfry-local-dir))
  :config
  (setq project-switch-commands
        (append project-switch-commands
                '((magit-status "Magit status" ?s)
                  (magit-dispatch "Magit dispatch" ?d))))
  :general
  (nmap-leader "P" project-prefix-map)
  (nmap-leader :infix "P"
    "/" 'project-search
    "a" 'project-remember-projects-under
    "A" 'project-forget-project))
