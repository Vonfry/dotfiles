;;; ledge config -*- lexical-binding: t -*-
;;

(custom! +hledger-path (file-name-directory (getenv "LEDGER_FILE"))
  "hledger files path."
  :group 'vonfry-modules
  :type 'directory)
