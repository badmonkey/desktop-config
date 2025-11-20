;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-buffer --- Add meta-buffer bindings


;;; M-k  kill buffer commands ;;;
(general-define-key
  :prefix "M-k"
  :prefix-command 'killbuffer-keymap
  "DEL"     'crux-delete-file-and-buffer

  "0"       'kill-all-buffers
  "1"       'kill-other-buffers

  "b"       'bury-buffer
  "k"       'kill-or-bury-buffer
  "o"       'kill-orphan-buffers
  "p"       'projectile-kill-buffers
  "u"       'kill-unmodified-buffers
  "w"       'kill-with-linenum
  )


(provide 'init-bind-buffer)
;;; init-bind-buffer.el ends here
