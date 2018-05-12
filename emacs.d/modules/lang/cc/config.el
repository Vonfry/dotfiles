;;; cc config -*- lexical-binding: t -*-
;;

(defcustom +irony-dir
  (expand-file-name "irony/" vonfry-local-dir)
  "irony local dir"
  :type 'directory
  :group 'vonfry-modules)

(defcustom +irony-extra-cmake-args
  (if (eq system-type 'darwin)
    (list "-DCMAKE_CXX_COMPILER=/usr/local/opt/llvm/bin/clang++"
          "-DCMAKE_C_COMPILER=/usr/local/opt/llvm/bin/clang"
          "-DCMAKE_PREFIX_PATH=/usr/local/opt/llvm")
    nil)
  "Set irony-extra-cmake-args. It is mainly for macos."
  :type '(repeat string)
  :group 'vonfry-modules)
