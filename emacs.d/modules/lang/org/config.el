;;; org config -*- lexical-binding: t -*-
;;

(vonfry-def-mmap-mode-prefix org nil
  :keymaps 'org-mode-map)

(defcustom +org-diary-dir (expand-file-name "diary" vonfry-org-dir)
  "org diary dir."
  :type 'directory
  :group 'vonfry-modules)

(defcustom +org-diary-templates-get-location-function
  (lambda (&rest args)
    (interactive)
    (let* ((date (format-time-string "%Y%m%d"))
           (sep "-")
           (slug (read-string "slug: "))
           (ext ".org")
           (filename (concat date sep slug ext))
           (path (expand-file-name filename +org-diary-dir)))
      (set-buffer (org-capture-target-buffer path))
      (widen)
      (org-capture-put-target-region-and-position)
      (goto-char (point-max))))
  "location for org diary by org-capture under `+org-diary-dir'."
  :type 'function
  :group 'vonfry-modules)

(defun +org--diary-templates-get-location (&rest args)
  (funcall +org-diary-templates-get-location-function args)
  "call `+org-diary-templates-get-location-function'")

(defcustom +org-note-dir (expand-file-name "notes" vonfry-org-dir)
  "org note dir."
  :type 'directory
  :group 'vonfry-modules)

(defcustom +org-note-templates-get-location-function
  (lambda (&rest args)
    (interactive)
    (let* ((path (read-file-name "note file: " +org-note-dir)))
      (set-buffer (org-capture-target-buffer path))
      (widen)
      (org-capture-put-target-region-and-position)
      (goto-char (point-max))))
  "location for org diary by org-capture under `+org-diary-dir'."
  :type 'function
  :group 'vonfry-modules)

(defun +org--note-templates-get-location (&rest args)
  (funcall +org-diary-templates-get-location-function args)
  "call `+org-note-templates-get-location-function'")

(defcustom +org-clock-persist-file
   (expand-file-name "org-clock-save.el" vonfry-cache-dir)
   "org clock save, see `org-clock-persist-file'"
   :type 'file
   :group 'vonfry-modules)

(defcustom +org-todo-keywords-sequence
  '((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)")
    (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
  "org todo keywords, see `org-todo-keywords-sequence'"
  :group 'vonfry-modules)

(defcustom +org-capture-file
   (expand-file-name "inbox.org" vonfry-org-dir)
   "org capture, see `org-capture-file'"
   :type 'file
   :group 'vonfry-modules)

(defcustom +org-agenda-tags-file
   (expand-file-name "agenda/tags" vonfry-org-dir)
   "Custom tag file to read config of tags.\nIts structor is like dir-locals.\n\n'((tag subtag))'\nHere 'subtag' can be another list with '(tag subtag)'."
   :type 'file
   :group 'vonfry-modules)

(load +org-agenda-tags-file t t)

(unless (boundp 'vonfry--org-tags-m)
  (defcustom vonfry--org-tags-gtd-sym "#" "org tags symbol" :type 'string :group 'vonfry-modules)
  (defcustom vonfry--org-tags-cat-sym ":" "org tags symbol" :type 'string :group 'vonfry-modules)
  (defcustom vonfry--org-tags-ctx-sym "@" "org tags symbol" :type 'string :group 'vonfry-modules)
  (defcustom vonfry--org-tags-m
    `((("gtd" ,vonfry--org-tags-gtd-sym)
       ((("category" ,vonfry--org-tags-cat-sym)
         ((("dev" "d"))))
        (("context"  ,vonfry--org-tags-ctx-sym)
         ((("haskell" "hs")))))))
     "vonfry org agenda tags, which is used in org-agenda-custom-commands. The data struct see '+org-tag-alist'"
    :group 'vonfry-modules))

(defun vonfry--unzip-org-agenda-tags-m (m &optional l prefix prefix-level prefix-tag)
  "expend 'vonfry--org-tags-m' from a hierarchy to a non-hierarchy list.\nThe second optional arguments are used to recurrence.\n"
  (-let (((m l is-top prefix-level)
            (if (not (or l prefix prefix-level))
              (-let* ((gtd (nth 0 m))
                      ((gtd-tag gtd-subtag) gtd)
                      ((gtd-name gtd-sym) gtd-tag)
                      ((cat-tag cat-subtag) (nth 0 gtd-subtag))
                      ((cat-name cat-sym) cat-tag)
                      ((ctx-tag ctx-subtag) (nth 1 gtd-subtag))
                      ((ctx-name ctx-sym) ctx-tag))
                `((,cat-subtag ,ctx-subtag)
                  ((,(concat gtd-sym gtd-name) ,gtd-sym)
                   (,(concat cat-sym cat-name) ,cat-sym)
                   (,(concat ctx-sym ctx-name) ,ctx-sym))
                  t
                  0))
              `(,m ,l nil ,prefix-level))))
    (if is-top
      (-let* (((cat-subtag ctx-subtag) m)
              (cat-m (vonfry--unzip-org-agenda-tags-m cat-subtag nil vonfry--org-tags-cat-sym 1 nil))
              (ctx-m (vonfry--unzip-org-agenda-tags-m ctx-subtag nil vonfry--org-tags-ctx-sym 1 nil)))
        (append l cat-m ctx-m))
      (-reduce-r-from
        (lambda (i c)
          (let ((l (let* ((tag (nth 0 i))
                          (tag-name
                            (if (string= prefix vonfry--org-tags-ctx-sym)
                              (concat prefix (nth 0 tag))
                              (nth 0 tag)))
                          (tag-abbr (nth 1 tag))
                          (abbr-prefix (s-repeat prefix-level prefix))
                          (tag-names (if prefix-tag
                                         (concat prefix-tag prefix tag-name)
                                         tag-name))
                          (l (cons (list tag-names (concat abbr-prefix tag-abbr)) l)))
                      (if (> (length i) 1)
                        (vonfry--unzip-org-agenda-tags-m (nth 1 i) l prefix (1+ prefix-level) tag-names)
                        l))))
            (append l c)))
        nil
        m))))

(defun vonfry--org-tag-alist-generate (m &optional prefix level)
  "generate 'org-tag-alist' from 'vonfry--org-tags-m'"
  (-let ((prefix (if (not level) vonfry--org-tags-gtd-sym prefix))
         (level (if level level 0)))
    (-reduce-r-from
      (lambda (i c)
        (-let* ((tag (car i))
                ((tag-name tag-abbr) tag)
                (tag-name (concat prefix tag-name)))
          (if (= 1 (length i))
            (cons `(,tag-name) c)
            (let* ((prefix
                    (cond ((and (= 1 level)
                                (string= tag-abbr vonfry--org-tags-ctx-sym))
                            tag-abbr)
                          ((> 1 level) prefix)
                          (t nil)))
                   (l `((:startgrouptag)
                        (,tag-name)
                        (:grouptags)
                        ,@(vonfry--org-tag-alist-generate (nth 1 i) prefix (1+ level))
                        (:endgrouptag))))
               (append l c)))))
      nil
      m)))

(defcustom +org-tag-alist
  (vonfry--org-tag-alist-generate vonfry--org-tags-m)
  "org tag alist. It is generated from 'vonfry--org-tags-m', which struct is defined as following:\n\n\tvonfry tags\n\tIt is a list.\n\ttag := (list tag abbr)\n\tsubtag := (list tag tag ...)\n\t taglist := (list tag subtag)\n\n\n\tEach list's first element is the tag name and second is its subtag. A subtag is same as a tag list.\n\tEach tag is a list, first element is the whole name, and second is a abbr name.\n\tThe key start with '#' are the kinds used in gtd.The key start with ':' is category and start with '@' is context.\n\tCategory: number of ':' means the level of category.\n\tFiles are organized by workspace such as person and company. They will be set automatically by the filename under 'vonfry-org-dir'/agenda.\n\tYou can see an example in 'vonfry--org-tags-m'."
  :group 'vonfry-modules)

(let* ((org-dir-with    (lambda (d) (expand-file-name d vonfry-org-dir)))
       (file-with-org   (lambda (f) (concat f ".org")))
       (agenda-dir      (funcall org-dir-with "agenda/"))
       (agenda-dir-with (lambda (f) (expand-file-name (funcall file-with-org f) agenda-dir)))
       (agenda-files    (directory-files agenda-dir t "^.*\\.org$"))
       (note-dir        (funcall org-dir-with "notes/"))
       (note-files      (directory-files note-dir   t "^.*\\.org$"))
       (note-dir-with   (lambda (f) (expand-file-name (funcall file-with-org f) note-dir)))
       (unzip-tags-m (vonfry--unzip-org-agenda-tags-m vonfry--org-tags-m))
       (gtd-prefix (nth 1 (nth 0 unzip-tags-m)))
       (cat-prefix (nth 1 (nth 1 unzip-tags-m)))
       (ctx-prefix (nth 1 (nth 2 unzip-tags-m)))
       (tag-name     (lambda (names) (-last-item (split-string names cat-prefix))))
       (tag-level    (lambda (names) (if (string-prefix-p ctx-prefix names)
                                         77
                                         (length (split-string names cat-prefix)))))
       (unzip-tags-m-filtered
         (-filter (-lambda ((_ tagabbr))
                    (not (or (string= tagabbr gtd-prefix)
                             (string= tagabbr cat-prefix)
                             (string= tagabbr ctx-prefix))))
                  unzip-tags-m))
       (get-key   (lambda (um) (nth 1 um)))
       (get-tag   (lambda (um) (nth 0 um)))
       (get-desc  (-lambda ((tag key))
                    (cond ((string-prefix-p cat-prefix key) (concat "[TAGS:Category] " tag))
                          ((string-prefix-p ctx-prefix key) (concat "[TAGS:Context] "  tag)))))
       (all-tags
         (-map (lambda (tag) (funcall tag-name (funcall get-tag tag))) unzip-tags-m)))
  (defcustom +org-agenda-dir agenda-dir
    "my agenda dir, see `agenda-dir'"
    :group 'vonfry-modules)
  (defcustom +org-agenda-files agenda-files
    "global agenda dir, see `org-agenda-files'"
    :group 'vonfry-modules)
  (defcustom +org-capture-templates
    (let ((default-templates
            '(("c" "capture to inbox(Tasks), refile later" entry (file+headline +org-capture-file "Tasks")
               "\n* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n" :empty-lines 1)
              ("i" "capture to inbox(Idea), refile later" entry (file+headline +org-capture-file "Idea")
               "\n* %?\n:PROPERTIES:\n:CREATED: %U\n" :empty-lines 1)
              ("d" "capture to diary" plain (function +org--diary-templates-get-location)
               "\n#+TITLE:%^{title}\n#+DATE:%U\n\n* Context %^{tags}\n\n* Main Text\n\n%?" :empty-lines 1)
              ("n" "capture to note" plain (function +org--note-templates-get-location)
               "\n#+TITLE:%^{title}\n#+DATE:%U\n* Context %^{tags}\n\n* Main Text\n\n%?" :empty-lines 1)
              ("b" "Brain" plain (function org-brain-goto-end) "* %i%?" :empty-lines 1)
              ("a" "capture to agenda")))
          (agenda-templates
            (-map-indexed
              (lambda (index file-path)
                (let* ((file-name (file-name-nondirectory file-path))
                       (keys (concat "a" (string (+ ?A index)))))
                  `(,keys ,(concat "capture to " file-name ", refile later") entry (file ,file-path)
                    "\n* TODO %?\t\n:PROPERTIES:\n:CREATED: %U\n:END:\n" :empty-lines 1)))
              agenda-files)))
      (append default-templates agenda-templates))
    "org capture templates"
    :group 'vonfry-modules)
  (defcustom +org-refile-targets
    (-map
      (lambda (f)
        (-map
          (lambda (tag)
            `(,f :tag . ,tag))
            all-tags))
      +org-agenda-files)
    "org refile targets, see `org-refile-targets'"
    :group 'vonfry-modules)
  (defcustom +org-super-agenda-groups
    (-map
     (-lambda ((tag abbr))
       `(:name ,(funcall tag-name tag) :tag ,(funcall tag-name tag) :order ,(funcall tag-level tag)))
     unzip-tags-m-filtered)
    "org super agenda groups, see `org-super-agenda-groups'"
    :group 'vonfry-modules)
  (defcustom +org-agenda-custom-commands
    (let ((custom-tags-commands
            (-map
              (-lambda ((tag key))
                  `(,key ,(funcall get-desc `(,tag ,key)) tags ,tag))
              unzip-tags-m-filtered))
          (custom-commands
            `((,cat-prefix . "[TAGS]Category select")
              (,ctx-prefix . "[TAGS]Context  select")
              (,gtd-prefix . "[TAGS]All GTD")
              (">" . "[TODO]Keyword  select")
              (">t" tags "TODO"     )
              (">w" tags "WAITING"  )
              (">s" tags "SOMEDAY"  )
              (">d" tags "DONE"     )
              (">c" tags "CANCELLED"))))
      (append custom-tags-commands custom-commands))
    "org agenda custom commands, see `org-agenda-custom-commands'"
    :group 'vonfry-modules))

(defcustom +org-brains-path
  (expand-file-name "brains/" vonfry-org-dir)
  "org-brain path, see `org-brains-path'"
  :type 'directory
  :group 'vonfry-modules)
