;;; lsp packages -*- lexical-binding: t -*-

(package! lsp-mode
  :hook
  (lsp-before-open-hook .
    (lambda ()
      (when (and lsp--cur-workspace (not projectile-project-root))
        (setq projectile-project-root (lsp--workspace-root lsp--cur-workspace))))))

(package! lsp-imenu
  :ensure nil
  :hook (lsp-after-open . lsp-enable-imenu))

(package! lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-jump-prompt        'lsp-ui-peek-find-workspace-symbol)
  :general
  (:map lsp-ui-mode-map
  ([remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  ([remap xref-find-references]  #'lsp-ui-peek-find-references)))

(package! company-lsp
  :after lsp-mode company
  :custom
  (company-lsp-async t)
  (company-lsp-cache-candidates t)
  (company-lsp-enable-snippet t)
  (company-lsp-enable-recompletion t)
  :config
  (push 'company-lsp company-backends))
