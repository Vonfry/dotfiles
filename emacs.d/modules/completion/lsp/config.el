;;; lsp config -*- lexical-binding: t -*-
;;

(use-package! lsp-mode
  :hook (lsp-before-open-hook .
    (lambda ()
      (when lsp--cur-workspace
        (setq projectile-project-root (lsp--workspace-root lsp--cur-workspace)))))
  :config
  (use-package! lsp-imenu
    :hook (lsp-after-open . lsp-enable-imenu)))

(use-package! lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-jump-to-definition 'lsp-ui-peek-find-definitions
    vonfry-keybind-evil-jump-to-others     'lsp-ui-peek-find-reference
    vonfry-keybind-evil-jump-prompt        'lsp-ui-peek-find-workspace-symbol)
  :general
  (:map lsp-ui-mode-map
  ([remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  ([remap xref-find-references]  #'lsp-ui-peek-find-references)))

(use-package! company-lsp
  :after lsp-mode company
  :custom
  (company-lsp-async t)
  (company-lsp-cache-candidates 'auto)
  (company-lsp-enable-snippet t)
  (company-lsp-enable-recompletion t)
  :config
  (push 'company-lsp company-backends))
