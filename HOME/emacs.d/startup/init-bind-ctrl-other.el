;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-ctrl-misc --- Add general ctrl-? bindings


(general-define-key
  "C-="             'er/expand-region
  "C-+"             'er/contract-region

  "<C-return>"      'crux-smart-open-line
  "<S-return>"      'crux-smart-open-line-above
  "<C-backspace>"   'region-kill-to-left-margin
  "<C-tab>"         'region-indent-code

  "<C-SPC>"         'smart-region

  "C-a"             'crux-move-beginning-of-line

  "C-k"             'region-kill-line
  "C-w"             'region-copy-line
  "C-y"             'region-yank

  "C-s"             'swiper-helm
  "C-o"             'imenu-anywhere

  "C->"             'mc/mark-next-like-this
  "C-<"             'mc/mark-previous-like-this

  "C-`"             'switch-to-last-buffer

  "C-."             'helm-ucs
  )


(provide 'init-bind-ctrl-misc)
;;; init-bind-ctrl-misc.el ends here
