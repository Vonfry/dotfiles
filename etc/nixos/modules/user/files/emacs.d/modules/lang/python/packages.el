;;; python packages -*- lexical-binding: t -*-
;;

(use-package python-mode
  :custom
  (python-shell-interpreter "ipython3")
  (python-shell-exec-path   "ipython3")
  :general
  (nmap-leader :keymaps 'python-mode-map
    "\""  'ipython3
    "; ." 'py-find-definition
    "RET" 'py-execute-line
    "R"   'realgud:pdb
    "' s" 'py-execute-statement
    "' S" 'py-execute-statement-pdb)
  (vmap-leader :keymaps 'python-mode-map
    "' R" 'py-execute-region-pdb
    "' r" 'py-execute-region)
  (nmap-mode :keymaps 'python-mode-map
    "#" 'py-update-imports
    "s" 'py-switch-shell))

(use-package pydoc
  :general
  (nmap-leader :keymaps 'python-mode-map
    "?"   'pydoc)
  (nmap-mode :keymaps 'python-mode-map
    "b" 'pydoc-browse))
