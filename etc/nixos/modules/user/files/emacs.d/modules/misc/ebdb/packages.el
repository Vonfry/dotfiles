;;; ebdb packages -*- lexical-binding: t -*-
;;

(package! ebdb
  :custom
  (ebdb-sources (directory-files (expand-file-name "db" +ebdb-base-dir) t "^[A-z0-9_\\-]+$"))
  (ebdb-image-path (expand-file-name "imgs" +ebdb-base-dir))
  :hook
  (evil-mode . (lambda ()
    (evil-set-initial-state 'ebdb-mode  'emacs)))
  :general
  (+mmap-at-def
    "c"   'ebdb-counsel
    "C"   '(nil :which-key "edbd")
    "C c" 'ebdb-open
    "C &" 'ebdb-complete-mail
    "C C" 'ebdb))

(package! ebdb-mu4e :after mu4e :ensure nil)
