;;; project packages -*- lexical-binding: t -*-
;;

(use-package project
  :custom
  (project-list-file (expand-file-name "projects" vonfry-local-dir))
  :general
  (nmap-leader
    "P !" 'project-shell-command
    "P $" 'project-eshell
    "P f" 'project-find-file
    "P F" 'project-find-dir
    "P d" 'project-dired
    "P b" 'project-switch-to-buffer
    "P p" 'project-switch-project
    "P r" 'project-compile
    "P k" 'project-kill-buffers
    "P /" 'project-search
    "P *" 'project-query-replace-regexp
    "P a" 'project-remember-projects-under
    "P r" 'project-forget-project))
