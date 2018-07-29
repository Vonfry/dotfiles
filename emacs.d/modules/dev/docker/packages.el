;;; docker packages -*- lexical-binding: t -*-
;;

(package! docker
  :general
  (nmap :prefix +nmap-docker-prefix
        ""  '(nil :which-key "docker")
        "'"  'docker
        "c" 'docker-containers
        "d" 'docker-rmi
        "e" 'docker-unpause
        "F" 'docker-pull
        "k" 'docker-rm
        "i" 'docker-images
        "o" 'docker-stop
        "P" 'docker-push
        "p" 'docker-pause
        "r" 'docker-restart
        "s" 'docker-start))
