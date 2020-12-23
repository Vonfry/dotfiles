;;; docker packages -*- lexical-binding: t -*-
;;

(use-package docker
  :general
  (nmap-leader :infix "v"
    ""   '(:ignore t :which-key "docker")
    "\"" 'docker
    "c"  'docker-containers
    "d"  'docker-rmi
    "e"  'docker-unpause
    "F"  'docker-pull
    "k"  'docker-rm
    "i"  'docker-images
    "o"  'docker-stop
    "P"  'docker-push
    "p"  'docker-pause
    "r"  'docker-restart
    "s"  'docker-start))
