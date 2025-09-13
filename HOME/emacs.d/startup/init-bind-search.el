;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-search --- Add meta-search bindings


;;; M-s  search commands ;;;
(general-define-key
  :prefix "M-s"

  ;; .      isearch-forward-symbol-at-point
  ;; _      isearch-forward-symbol

  ;; "f"       'xref-find -apropos -definitions
  "g"       'google-this-search
  ;; o      occur
  "r"       'isearch-backward
  "C-r"     'isearch-backward-regexp
  "s"       'isearch-forward
  ;; t      counsel-etags-find-tag ??
  ;; C-t    counsel-etags-grep-symbol-at-point ??
  ;; w      isearch-forward-word
  "x"       'isearch-forward-regexp
  )


(provide 'init-bind-search)
;;; init-bind-search.el ends here
