;;; direnv packages -*- lexical-binding: t -*-
;;

(use-package envrc
  :general
  (nmap-leader :infix "'" :keymaps 'envrc-mode-map
    "e" 'envrc-command-map)

  :config
  ;; Take from doom-emacs, this can make envrc load earlier than lsp
  (add-hook 'change-major-mode-after-body-hook
    (lambda ()
      (unless (or envrc-mode
                  (minibufferp)
                  (file-remote-p default-directory))
        (condition-case _
            (envrc-mode 1)
          (quit)))))
  ;; Ensure these local variables survive major mode changes, so envrc-mode is
  ;; only "activated" once per buffer.
  (put 'envrc-mode 'permanent-local t)
  (put 'envrc--status 'permanent-local t)
  (put 'process-environment 'permanent-local t)
  (put 'exec-path 'permanent-local t)
  (put 'eshell-path-env 'permanent-local t))
