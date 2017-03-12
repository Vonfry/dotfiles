(require-package 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)
(setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)

(require-package 'flycheck-ycmd)
(require 'flycheck-ycmd)
(defun vonfry/setup-flycheck-ycmd ()
    ; Make sure the flycheck cache sees the parse results
    (add-hook 'ycmd-file-parse-result-hook 'flycheck-ycmd--cache-parse-results)
    ; Add the ycmd checker to the list of available checkers
    (add-to-list 'flycheck-checkers 'ycmd))
(add-hook 'after-init-hook 'vonfry/setup-flycheck-ycmd)

(add-hook 'evil-local-mode-hook
  (lambda ()
    (evil-leader/set-key
      "q" 'flycheck-list-errors)))

(provide 'init-flycheck)
