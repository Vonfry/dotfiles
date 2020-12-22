;;; evil config -*- lexical-binding: t -*-
;;

;; +mmap-at-def
(mmap-leader-prefix! at "@")
(map-which-key! +mmap-at-def "web/..")

(+mmap-leader-def "'" '(nil :which-key "repl"))
