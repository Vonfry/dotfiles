;;; projectile config -*- lexical-binding: t -*-
;;

(defcustom +projectile-cache-dir
  (expand-file-name "projectile/" vonfry-cache-dir)
  "projectile cache dir, see `projectile-cache-dir'"
  :type 'directory
  :group 'vonfry-modules)

(defcustom +projectile-cache-known-project-file
  (expand-file-name "known" +projectile-cache-dir)
  "projectile cache dir, see `projectile-cache-known-project-file'"
  :type 'directory
  :group 'vonfry-modules)

(defcustom +projectile-cache-file
  (expand-file-name "cache" +projectile-cache-dir)
  "projectile cache dir, see `projectile-cache-file'"
  :type 'directory
  :group 'vonfry-modules)

(defcustom +org-projectile-todo-project-file
  "todo.org"
  "org projectile file in project dir. This variable will be seted in `org-projectile-per-project-filepath'."
  :type 'file
  :group 'vonfry-modules)
