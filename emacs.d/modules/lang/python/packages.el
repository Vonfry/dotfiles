;;; python packages -*- lexical-binding: t -*-
;;


(package! python-mode
  :custom
  (python-shell-interpreter "ipython")
  :general
  (nmap :keymaps 'python-mode-map
        :prefix +lang-nmap-prefix
        "s" 'python-menu))

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
