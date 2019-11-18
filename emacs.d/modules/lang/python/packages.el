;;; python packages -*- lexical-binding: t -*-
;;

(package! python-mode
  :custom
  (python-shell-interpreter "ipython3")
  (python-shell-exec-path   "ipython3")
  :general
  (+nmap-python-def
    "\""  'python
    "; ." 'py-find-definition
    "RET" 'py-execute-line
    "' r" 'py-execute-region
    "' R" 'py-execute-region-pdb
    "' s" 'py-execute-statement
    "' S" 'py-execute-statement-pdb)
  (+nmap-lang-python-def
    "#"   'py-update-imports
    "s"   'py-switch-shell)

(package! pydoc
  :general
  (+nmap-python-def
    "?"   'pydoc)
  (+nmap-lang-python-def
    "b" 'pydoc-browse))
