;;; dired packages -*- lexical-binding: t -*-
;;

(package! dired-filter
  :custom
  (dired-filter-revert 'never)
  (dired-filter-group-saved-groups
    '(("default"
      ("PDF"
       (extension . "pdf"))
      ("LaTeX"
       (extension "tex" "bib"))
      ("Source"
       (extension "c" "cpp" "h" "hpp" "hs" "rb" "py" "r" "cs" "el" "lisp" "v"
                  "rust" "html" "js" "css" "ts"))
      ("Doc"
       (extension "org" "md" "rst" "txt"))
      ("Archives"
       (extension "zip" "rar" "gz" "bz2" "tar")))))
  :hook
  (dired-mode . (lambda () (dired-filter-mode t) (dired-filter-group-mode t))))
(package! dired-narrow)
(package! dired-subtree)
(package! dired-ranger)
(package! dired-collapse
  :hook (dired-mode . dired-collapse-mode))
(package! dired-sidebar
  :general
  (nmap :prefix +nmap-leader
        +nmap-treenode 'dired-sidebar-toggle-sidebar))
