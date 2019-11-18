;;; python packages -*- lexical-binding: t -*-
;;

(package! python-mode
  :custom
  (python-shell-interpreter "ipython3")
  :general
  (+nmap-lang-python-def
    "."   'py-find-definition
    "#"   'py-update-imports
    "s s" 'py-switch-shell
    "e r" 'py-execute-region
    "e R" 'py-execute-region-pdb
    "e s" 'py-execute-statement
    "e S" 'py-execute-statement-pdb))

(package! pydoc
  :general
  (+nmap-python-def
    "?"   'pydoc)
  (+nmap-lang-python-def
    "p p" 'pydoc
    "p b" 'pydoc-browse))
