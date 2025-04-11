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

(defun +eshell--init-aliases ()
  (dolist (alias +eshell--aliases)
      (apply 'eshell/alias alias)))

(defun +eshell--prompt ()
  (let* ((current-dir (abbreviate-file-name (eshell/pwd)))
         (exit-status (unless (eshell-exit-success-p)
                        (format " [%d]" eshell-last-command-status)))
         (username (eshell-user-name))
         (usersep (if (= (file-user-uid) 0) " # " " $ ")))
    (concat username usersep current-dir " " exit-status "\n" "𝛌 ")))

(defconst +eshell--prompt-regexp "𝛌 "
  "A shell prompt matcher for `+eshell--prompt'.")

