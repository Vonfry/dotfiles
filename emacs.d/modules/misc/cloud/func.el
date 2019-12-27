;;; cloud func -*- lexical-binding: t -*-
;;

(defun +cloud--do (method no-confirm)
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

(defun +cloud-push (&optional no-confirm)
  (interactive "P")
  (+cloud--do 'push no-confirm))

(defun +cloud-get (&optional no-confirm)
  (interactive "P")
  (+cloud--do 'get no-confirm))

(defun +cloud-copy-to (&optional no-confirm)
  (interactive "P")
  (+cloud--do 'copy-to no-confirm))

(defun +cloud-copy-from (&optional no-confirm)
  (interactive "P")
  (+cloud--do 'copy-from no-confirm))
