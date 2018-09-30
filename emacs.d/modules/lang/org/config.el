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
  '(
    ("s" "shorts-todo" entry (file+headline "~/share/all/org-mode/misc.org" "shorts")
     "* NEXT %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
    ("e" "Event" entry (file+headline "~/share/all/org-mode/misc.org" "Events")
     "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
    ("i" "IST Templates")
    ("is" "IST shorts" entry (file+headline "~/share/all/org-mode/IST.org" "shorts")
     "* NEXT %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
    ("ie" "IST event" entry (file+headline "~/share/all/org-mode/IST.org" "Events")
     "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
    ("ii" "IST isst" entry (file+headline "~/share/all/org-mode/IST.org" "Events")
     "* %? IST isst: \n:PROPERTIES:\n:CREATED: %U\n:END:\n\n- [[contact:Ingo Pill][Ingo Pill]]\n- [[contact:Thomas Quartisch][Thomas Quartisch]]\n\n" :empty-lines 1)
    ("b" "Besorgung" entry (file+headline "~/share/all/org-mode/hardware.org" "Besorgungen")
     "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
    ("C" "Clipboard" entry (file+headline "~/share/all/org-mode/misc.org" "shorts")
     "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%x\n\n" :empty-lines 1)
    ("c" "capture to inbox, refile later" entry (file "~/share/all/org-mode/inbox.org")
     "\n* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
    ("m" "movie" entry (file+headline "~/share/all/org-mode/movies.org" "inbox")
     "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
    ("x" "xlog")
    ("xh" "xlog hometrainer" table-line (id "xlog-hometrainer") "| %T |  |  |  |")
    ("xk" "Keyboard Akkus leer" table-line (id "3407c9b7-1b41-443b-9254-32c4af3a54e8") "| %T |")
    )
  "org capture templates")

(defconst +org-capture-file
   (expand-file-name "inbox.org" vonfry-org-dir)
   "org capture")

(defconst +org-brains-path
  (expand-file-name "brains" vonfry-org-dir)
  "org-brain path")

(defconst +org-agenda-files (list +org-capture-file (expand-file-name "agenda/" vonfry-org-dir))
  "global agenda dir")
