;;; ebdb packages -*- lexical-binding: t -*-
;;

(package! ebdb
  :custom
  (ebdb-sources (directory-files (expand-file-name "db" +ebdb-base-dir) t "^[A-z0-9_\\-]+$"))
  (ebdb-image-path (expand-file-name "imgs" +ebdb-base-dir))
  :general
  (+mmap-at-def
    "e"   'ebdb-counsel
    "E"   '(nil :which-key "edbd")
    "E e" 'ebdb-open
    "E E" 'ebdb))

(package! ebdb-mu4e :ensure nil)
