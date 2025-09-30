;;; shell/config.el --- -*- lexical-binding: t -*-
;;

(defconst +eshell--aliases
  '(("b" "browse-url-xdg-open $@*")
    ("B" "browse-url $@*")
    ("diffu" "diff --unified $@*")
    ("e" "find-file $@*")
    ("po" "popd $@*")
    ("pu" "pushd $@*")
    ("d" "dired $@*")
    ("o" "dired-do-open $@*")
    ("dlp" "curl --location --parallel --remote-name-all $@*")
    ("http-serve" "nix run 'nixpkgs#caddy' -- $@*"))
  "Builtin aliases.")

(defun +eshell--init-aliases ()
  "Init aliases with `+eshell-aliases'.

Because we should modify `eshell-command-aliases-list' by `eshell/alias' instead
of setting directly as its documentation."
  (dolist (alias +eshell--aliases)
      (apply 'eshell/alias alias)))


(defconst +eshell--prompt-hint "λ" "The prompt hint for user input.")

(defun +eshell--prompt ()
  "For `eshell-prompt-function'."
  (let* ((current-dir (abbreviate-file-name (eshell/pwd)))
         (exit-status (unless (eshell-exit-success-p)
                        (format " [%d]" eshell-last-command-status)))
         (username (eshell-user-name))
         (usersep (if (= (file-user-uid) 0) " # " " $ "))

         (username-text (propertize username 'face 'font-lock-builtin-face))
         (usersep-text (propertize usersep 'face 'warning))
         (current-datetime (format-time-string "%FT%T%z"))
         (current-datetime-text (propertize current-datetime 'face
                                            'font-lock-number-face))
         (current-dir-text (propertize current-dir 'face
                                       'font-lock-keyword-face))
         (exit-status-text (when exit-status
                             (propertize exit-status 'face 'error)))
         (hint-text (propertize +eshell--prompt-hint 'face
                                'font-lock-function-name-face))
         (cmd-text (propertize " " 'face 'default)))
    (concat
     "\n"
     username-text
     usersep-text
     current-datetime-text
     " "
     current-dir-text
     " "
     exit-status-text
     "\n"
     hint-text
     cmd-text)))

(defconst +eshell--prompt-regexp (concat +eshell--prompt-hint " ")
  "A shell prompt matcher for `+eshell--prompt'.")

