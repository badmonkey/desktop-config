;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-goto --- Add meta-goto bindings


;;; M-g  goto commands ;;;
(general-define-key
  :prefix "M-g"

  ;; TAB    move-to-column
  "\\"      'goto-last-change
  "`"       'switch-to-last-buffer
  "["       'point-to-buffer-start
  "]"       'point-to-buffer-end

  ","       'backward-list
  "."       'forward-list

  "1"       'goto-line-with-prefix
  "2"       'goto-line-with-prefix
  "3"       'goto-line-with-prefix
  "4"       'goto-line-with-prefix
  "5"       'goto-line-with-prefix
  "6"       'goto-line-with-prefix
  "7"       'goto-line-with-prefix
  "8"       'goto-line-with-prefix
  "9"       'goto-line-with-prefix

  ;; c      goto-char
  ;; g      goto-line

  ;; i      imenu

  "j"       'avy-goto-line
  "l"       'dogears-go

  ;; n      next-error
  ;; p      previous-error

  "t"       'hl-todo-next
  "C-t"     'hl-todo-previous
  )


(provide 'init-bind-goto)
;;; init-bind-goto ends here
