;;; python config -*- lexical-binding: t -*-

(setq python-shell-interpreter "python3")

(use-package! elpy
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
                   "jupyter")
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-code-help 'elpy-doc
            vonfry-keybind-evil-jump-module 'elpy-goto-location
            vonfry-keybind-evil-check 'elpy-check)
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "." 'elpy-goto-definition
            "?" 'elpy-doc
            "#" 'elpy-goto-location
            "'" 'elpy-shell-switch-to-shell
            "q" 'elpy-check
            ";" 'elpy-occur-definitions
            "h" 'elpy-doc
            "f" 'elpy-format-code))))

(use-package! pyvenv
  :hook
  (python-mode .
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "v" 'pyvenv-activate
            "d" 'pyvenv-deactivate
            "w" 'pyvenv-workon))))

(use-package! pydoc
  :hook
  (python-mode .
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "p" 'pydoc))))

(use-package! pip-requirements
  :hook
  (pip-requirements-mode . pip-requirements-auto-complete-setup))
