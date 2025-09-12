;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-ctrl-x --- bindings for ctrl-x ...


(general-define-key
  :prefix "C-x"

  "-"               'split-window-below
  "\\"              'split-window-right
  "="               'balance-windows
  "<backspace>"     'delete-window
  "/"               'what-cursor-position
  "b"               'helm-buffers-list
  "k"               'kill-or-bury-selected-buffer
  )


(provide 'init-bind-ctrl-x)
;;; init-bind-ctrl-x ends here
