;;; shell/config.el --- -*- lexical-binding: t -*-
;;

(defconst +eshell--aliases
  '(("rt" "trash-put $@*")
    ("rl" "trash-list $@*")
    ("re" "trash-empty $@*")
    ("rd" "trash-rm $@*")
    ("rr" "trash-restore $@*")
    ("b" "browse-url-xdg-open $@*")
    ("B" "browse-url $@*")
    ("diffu" "diff --unified $@*")
    ("e" "find-file $@*")
    ("po" "popd $@*")
    ("pu" "pushd $@*")
    ("d" "dired $@*")
    ("o" "dired-do-open $@*")
    ("http-serve" "nix run 'nixpkgs#dufs' -- $@*")
    ("asciinema" "exec nix run 'nixpkgs#asciinema' -- $@*"))
  "Builtin aliases.")

(defconst +eshell--prompt-hint "𝛌 " "The prompt hint for user input.")

(defun +eshell--prompt ()
  "For `eshell-prompt-function'."
  (let* ((current-dir (abbreviate-file-name (eshell/pwd)))
         (exit-status (unless (eshell-exit-success-p)
                        (format " [%d]" eshell-last-command-status)))
         (username (eshell-user-name))
         (usersep (if (= (file-user-uid) 0) " # " " $ "))

         (username-text (propertize username 'face 'font-lock-builtin-face))
         (usersep-text (propertize usersep 'face 'warning))
         (current-dir-text (propertize current-dir 'face
                                       'font-lock-variable-name-face))
         (exit-status-text (when exit-status
                             (propertize exit-status 'face 'error)))
         (hint-text (propertize +eshell--prompt-hint 'face
                                'font-lock-function-name-face)))
    (concat
     username-text
     usersep-text
     current-dir-text
     " "
     exit-status-text
     "\n"
     hint-text)))

(defconst +eshell--prompt-regexp +eshell--prompt-hint
  "A shell prompt matcher for `+eshell--prompt'.")

