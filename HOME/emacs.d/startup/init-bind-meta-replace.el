;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-replace --- Add meta-replace bindings


;;; M-r  replace commands ;;;
(general-define-key
  :prefix "M-r"
  :prefix-command 'replace-keymap

  "b"       'crux-rename-buffer-and-file
  "k"       'query-kill-matching-lines
  "r"       'query-replace-from-region
  "C-r"     'repeat-query-replace
  "x"       'query-replace-regexp
  "C-x"     'repeat-query-replace-regexp
  ;; replace with top of kill buffer
  )


(provide 'init-bind-replace)
;;; init-bind-replace.el ends here
