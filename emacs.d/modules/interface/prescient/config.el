;;; prescient config -*- lexical-binding: t -*-
;;

(defcustom +prescient-save-file
  (expand-file-name "prescient" vonfry-cache-dir)
  "prescient save file, see `prescient-save-file'"
  :group 'vonfry-modules
  :type 'file)
