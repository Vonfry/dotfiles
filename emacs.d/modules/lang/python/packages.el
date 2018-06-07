;;; python packages -*- lexical-binding: t -*-
;;

(setq python-shell-interpreter "python3")

(package! elpy
  :after company yasnippet
  :custom
  (elpy-rpc-python-command "python3")
  :config
  (elpy-enable)
  :hook
  (elpy-mode .
    (lambda ()
      (setq python-shell-interpreter "jupyter"
            python-shell-interpreter-args "console --simple-prompt"
            python-shell-prompt-detect-failure-warning nil)
      (add-to-list 'python-shell-completion-native-disabled-interpreters
                   "jupyter")))
  :general
  (nmap :keymaps 'elpy-mode-map
        :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-code-help 'elpy-doc
        vonfry-keybind-evil-jump-module 'elpy-goto-location
        vonfry-keybind-evil-check 'elpy-check)
  (nmap :keymaps 'elpy-mode-map
        :prefix +lang-nmap-prefix
        "." 'elpy-goto-definition
        "?" 'elpy-doc
        "#" 'elpy-goto-location
        "'" 'elpy-shell-switch-to-shell
        "q" 'elpy-check
        ";" 'elpy-occur-definitions
        "h" 'elpy-doc
        "f" 'elpy-format-code))

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
        :prefix +lang-nmap-prefix
        "p" 'pydoc))

(package! lsp-python
  :hook (python-mode . lsp-python-enable))
