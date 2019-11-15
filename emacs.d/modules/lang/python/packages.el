;;; python packages -*- lexical-binding: t -*-
;;

(package! python-mode
  :custom
  (python-shell-interpreter "ipython3")
  :general
  (nmap :keymaps 'python-mode-map
        :prefix +nmap-lang-prefix
        +nmap-go        'py-find-definition
        +nmap-go-module 'py-update-imports
        "ss" 'py-switch-shell
        "er" 'py-execute-region
        "eR" 'py-execute-region-pdb
        "es" 'py-execute-statement
        "eS" 'py-execute-statement-pdb))

(package! pyvenv
  :general
  (nmap :keymaps 'python-mode-map
        :prefix +nmap-lang-prefix
        "v" 'pyvenv-activate
        "d" 'pyvenv-deactivate
        "w" 'pyvenv-workon))

(package! pydoc
  :general
  (nmap :keymaps 'python-mode-map
        :prefix +nmap-leader
        +nmap-code-help 'pydoc)
  (nmap :keymaps 'python-mode-map
        :prefix +nmap-lang-prefix
        "pp" 'pydoc
        "pb" 'pydoc-browse))
