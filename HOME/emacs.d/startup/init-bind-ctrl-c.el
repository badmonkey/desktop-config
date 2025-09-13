;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-ctrl-c --- bindings for ctrl-c


(general-define-key
  :prefix "C-c"

  "g"               'counsel-git-grep
  "j"               'counsel-git
  "k"               'counsel-ag
  "r"               'counsel-rg
  )


(provide 'init-bind-ctrl-c)
;;; init-bind-ctrl-help ends here
