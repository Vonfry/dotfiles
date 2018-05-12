;;; projectile config -*- lexical-binding: t -*-
;;

(defcustom +projectile-cache-dir
  (expand-file-name "projectile/" vonfry-local-dir)
  "projectile cache dir"
  :group 'vonfry-modules)

(defcustom +org-projectile-todo-project-file
  "todo.org"
  "org projectile file in project dir. This variable will be seted in `org-projectile-per-project-filepath`."
  :group 'vonfry-modules)
