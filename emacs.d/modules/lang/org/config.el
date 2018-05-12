;;; org config -*- lexical-binding: t -*-
;;

(defcustom +org-clock-persist-file
   (expand-file-name "org-clock-save.el" vonfry-local-dir)
   "org clock save"
   :group 'vonfry-modules)

(defcustom +org-todo-keywords-sequence
  '((sequence "TODO(t)" "|" "DONE(d)" "REJECT(j)")
    (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
  "org todo keywords"
  :group 'vonfry-modules)

(defcustom +org-capture-templates
  '(("t" "Todo" entry (file+headline +org-capture-file "Tasks")
      "* TODO %?\n  %i\n  %a"))
  "org capture templates"
  :group 'vonfry-modules)

(defcustom +org-capture-file
   (expand-file-name "capture.org" vonfry-org-dir)
   "org capture"
   :group 'vonfry-modules)

(defcustom +org-brains-path
  (expand-file-name "brains" vonfry-org-dir)
  "org-brain path"
  :group 'vonfry-modules)

(defcustom +org-agenda-dirs (expand-file-name "agenda/" vonfry-org-dir)
  "global agenda dir"
  :group 'vonfry-modules
  :type 'string)
