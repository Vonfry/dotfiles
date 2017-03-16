(require-package 'graphviz-dot-mode)

(defun vonfry/setup-dot-mode ()
  (require 'graphviz-dot-mode)
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key-for-mode 'org-mode
        "=" 'graphviz-dot-indent-graph
        "'" 'graphviz-dot-preview))))

(add-hook 'graphviz-dot-mode-hook 'vonfry/setup-dot-mode)

(provide 'init-dot)
