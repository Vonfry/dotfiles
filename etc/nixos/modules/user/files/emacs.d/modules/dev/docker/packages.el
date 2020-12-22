;;; docker packages -*- lexical-binding: t -*-
;;

(package! docker
  :general
  (nmap-leader
    "v"   '(nil :which-key "docker")
    "v \"" 'docker
    "v c"  'docker-containers
    "v d"  'docker-rmi
    "v e"  'docker-unpause
    "v F"  'docker-pull
    "v k"  'docker-rm
    "v i"  'docker-images
    "v o"  'docker-stop
    "v P"  'docker-push
    "v p"  'docker-pause
    "v r"  'docker-restart
    "v s"  'docker-start))
