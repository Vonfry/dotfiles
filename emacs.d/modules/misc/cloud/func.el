;;; cloud func -*- lexical-binding: t -*-
;;

(fun! +cloud--do (method no-confirm)
  (let* ((do-prefix (concat "+cloud-" (symbol-name method)))
         (arg     (eval (intern (concat do-prefix "-argument"))))
         (command (eval (intern (concat do-prefix "-command"))))
         (extra   +cloud-command-extra-argument)
         (dryrun  +cloud-command-dryrun-argument)
         (callc   (s-join " " (list command arg extra)))
         (callcd  (s-join " " (list command dryrun arg extra))))
    (if no-confirm
      (shell-command callc)
      (let* ((output (shell-command-to-string callcd))
             (question (concat "Result: " output " | Continue? "))
             (answer '(("yes" ?y)
                       ("no"  ?n)))
             (read-answer-short t))
        (when (string= "yes" (read-answer question answer))
          (shell-command callc))))))

(fun! +cloud-push (&optional no-confirm)
  (interactive "P")
  (+cloud--do 'push no-confirm))

(fun! +cloud-get (&optional no-confirm)
  (interactive "P")
  (+cloud--do 'get no-confirm))

(fun! +cloud-copy-to (&optional no-confirm)
  (interactive "P")
  (+cloud--do 'copy-to no-confirm))

(fun! +cloud-copy-from (&optional no-confirm)
  (interactive "P")
  (+cloud--do 'copy-from no-confirm))
