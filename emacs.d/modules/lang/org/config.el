;;; org config -*- lexical-binding: t -*-
;;

(defconst +org-clock-persist-file
   (expand-file-name "org-clock-save.el" vonfry-cache-dir)
   "org clock save")

(defconst +org-todo-keywords-sequence
  '((sequence "TODO(t)" "|" "DONE(d)" "REJECT(j)")
    (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
  "org todo keywords")

(defconst +org-capture-templates
  '(("t" "Todo" entry (file+headline +org-capture-file "Tasks")
      "* TODO %?\n  %i\n  %a"))
  "org capture templates")

(defconst +org-capture-file
   (expand-file-name "capture.org" vonfry-org-dir)
   "org capture")

(defconst +org-brains-path
  (expand-file-name "brains" vonfry-org-dir)
  "org-brain path")

(defconst +org-agenda-dirs (expand-file-name "agenda/" vonfry-org-dir)
  "global agenda dir")
