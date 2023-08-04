;;; project packages -*- lexical-binding: t -*-
;;

(use-package project
  :custom
  (project-list-file (expand-file-name "projects" vonfry-local-dir))
  (project-switch-commands '((consult-find "Find file" ?f)
                             (consult-ripgrep "Find regexp" ?a)
                             (project-find-dir "Find directory" ?d)
                             (project-vc-dir "VC-Dir" ?v)
                             (project-eshell "Eshell" ?$)
                             (magit-dispatch "Magit dispatch" ?V)))
  :general
  (nmap-leader "P" project-prefix-map)
  (nmap-leader
    "P /" 'project-search
    "P a" 'project-remember-projects-under
    "P A" 'project-forget-project))
