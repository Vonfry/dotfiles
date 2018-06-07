;;; python packages -*- lexical-binding: t -*-
;;


(package! python-mode
  :custom
  (python-shell-interpreter "ipython3")
  :general
  (nmap :keymaps 'python-mode-map
    :prefix +lang-nmap-prefix
    "."  'py-find-definition
    ","  'py-update-imports
    "ss" 'py-switch-shell
    "er" 'py-execute-region
    "eR" 'py-execute-region-pdb
    "es" 'py-execute-statement
    "eS" 'py-execute-statement-pdb))

(package! pyvenv
  :general
  (nmap :keymaps 'python-mode-map
    :prefix +lang-nmap-prefix
    "v" 'pyvenv-activate
    "d" 'pyvenv-deactivate
    "w" 'pyvenv-workon))

(package! pydoc
  :general
  (nmap :keymaps 'python-mode-map
        :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-code-help 'pydoc)
  (nmap :keymaps 'python-mode-map
        :prefix +lang-nmap-prefix
        "pp" 'pydoc
        "pb" 'pydoc-browse))

(package! lsp-python
  :hook (python-mode . lsp-python-enable))
