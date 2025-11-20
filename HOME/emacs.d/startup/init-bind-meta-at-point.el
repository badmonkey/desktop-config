;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-at-point --- Add meta-at-point bindings


;;; M-.  at-point commands ;;;
(general-define-key
  :prefix "M-."
  :prefix-command 'at-point-keymap

  "TAB"     'completion-at-point
  "SPC"     'just-one-space
  "DEL"     'delete-horizontal-space

  "<left>"  'delete-ws-right
  "["       'delete-ws-right
  "]"       'delete-ws-left

  "/"       'helm-dash-at-point
  "\\"      'bm-annotate-or-create
  "?"       'symbol-at-point

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-generate-docstring-at-point)

  "e"       'flycheck-display-error-at-point
  ;;"f"       'xref-...
  "g"       'google-this

  "h"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'describe-function-at-point
              (derived-mode-p 'python-mode) 'pydoc-at-point)
  "i"       'helm-info-at-point

  "s"       'ispell-word
  ;; "t"    'ggtags- ??
  "u"       'crux-view-url
  "x"       'exchange-point-and-mark
  "z"       'zeal-at-point
  )


(provide 'init-bind-at-point)
;;; init-bind-at-point.el ends here
