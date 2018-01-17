;;; python config -*- lexical-binding: t -*-

(setq python-shell-interpreter "python3")

(use-package! anaconda-mode
  :disabled
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

(use-package! company-anaconda
  :disabled
  :after anaconda-mode company
  :config
  (add-hook 'python-mode-hook
    (lambda ()
      (add-to-list (make-local-variable 'company-backends) 'company-anaconda))))

(use-package! elpy
  :after company yasnippet
  :init
  (custom-set-variables
    '(elpy-rpc-python-command "python3"))
  :config
  (elpy-enable)
    (add-hook 'elpy-mode-hook
      (lambda ()
        (setq python-shell-interpreter "ipython3"
              python-shell-interpreter-args "-i")
        (nmap :keymaps 'local
              :prefix vonfry-keybind-evil-leader
              vonfry-keybind-evil-jump-to-definition 'elpy-goto-definition
              vonfry-keybind-evil-code-help 'elpy-doc
              vonfry-keybind-evil-jump-module 'elpy-goto-location
              vonfry-keybind-evil-repl 'elpy-shell-switch-to-shell
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
  :config
  (add-hook 'python-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "v" 'pyvenv-activate
            "d" 'pyvenv-deactivate
            "w" 'pyvenv-workon))))

(use-package! pydoc
 :config
 (add-hook 'python-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "p" 'pydoc))))

(use-package! pip-requirements
  :config
  (add-hook 'pip-requirements-mode-hook 'pip-requirements-auto-complete-setup))
