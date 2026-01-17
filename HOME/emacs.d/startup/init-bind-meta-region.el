;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-region --- Add meta-region bindings


;;; M-SPC  region commands ;;;
(general-define-key
  :prefix "M-SPC"
  :prefix-command 'bufferaction-keymap

  "SPC"     'smart-region
  "DEL"     'delete-region
  "TAB"     'indent-rigidly

  ";"       'region-toggle-comment

  "0"       'mark-sexp
  "1"       'just-one-space

  "a"       'region-qp-decode

  "b"       'mc/edit-lines

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-region)

  "e"       'toggle-fancy-narrow

  "i"       'kill-inner-region
  "j"       'region-join-lines
  "k"       'region-kill-whole-line

  "m"       'hydra-mark/body
  "n"       'narrow-to-region-indirect

  "o"       'kill-outer-region
  "p"       'mark-paragraph
  "q"       'region-qp-encode
  "s"       'mc/mark-all-like-this
  "w"       'region-copy-whole-line
  "y"       'clipmon-autoinsert-toggle
  )


(provide 'init-bind-region)
;;; init-bind-region.el ends here
