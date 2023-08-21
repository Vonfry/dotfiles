org-mode

(export-html-orgcss
 "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"https://gongzhitaao.org/orgcss/org.css\"/>"
 )

(export-latex-article
 "#+LATEX_CLASS: article" n
 "#+LATEX_CLASS_OPTIONS: [a4paper]")

(export-latex-cn
 "#+LATEX_HEADER: \usepackage{ctex}" n
 "#+LATEX_HEADER: \usepackage{fontspec}" n
 "#+LATEX_HEADER: \setmainfont{Source Han Serif SC}" n
 "#+LATEX_HEADER: \setsansfont{Source Han Sans SC}" n
 "#+LATEX_HEADER: \setmonofont{Sarasa Mono SC}")
