;;; projectile config -*- lexical-binding: t -*-
;;

(defconst +projectile-cache-dir
  (expand-file-name "projectile/" vonfry-local-dir)
  "projectile cache dir")

(defcustom +org-projectile-todo-project-file
  "todo.org"
  "org projectile file in project dir. This variable will be seted in `org-projectile-per-project-filepath`.")
