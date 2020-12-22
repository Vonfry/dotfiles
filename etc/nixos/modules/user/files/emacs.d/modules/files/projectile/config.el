;;; projectile config -*- lexical-binding: t -*-
;;

(const! +projectile-cache-dir
  (expand-file-name "projectile/" vonfry-cache-dir)
  "projectile cache dir, see `projectile-cache-dir'")

(const! +projectile-cache-known-project-file
  (expand-file-name "known" +projectile-cache-dir)
  "projectile cache dir, see `projectile-cache-known-project-file'")

(const! +projectile-cache-file
  (expand-file-name "cache" +projectile-cache-dir)
  "projectile cache dir, see `projectile-cache-file'")
