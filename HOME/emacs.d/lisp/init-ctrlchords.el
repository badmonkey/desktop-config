;;; init-ctrlchords --- Add ctrl-chord bindings
;;; Commentary:
;;; Code:



(general-unbind
;; So you can't accidently quit or suspend the emacs server
  "C-x C-c"
  "C-z"

;; Stop uppercase-region warning from fucking with undo
  "C-x C-u"

;; Need to delete this at the metsource
  "C-x C-b"
  )


(general-define-key
  "C-="           'er/expand-region
  "C-+"           'er/contract-region

  "<C-return>"    'crux-smart-open-line
  "<S-return>"    'crux-smart-open-line-above
  "<C-backspace>" 'region-kill-to-left-margin
  "<C-tab>"       'region-indent-code

  "<C-SPC>"       'smart-region

  "C-a"           'crux-move-beginning-of-line

  "C-k"           'region-kill-line
  "C-w"           'region-copy-line
  ;; "C-y"           'yank

  "C-s"           'swiper-helm

  "C->"           'mc/mark-next-like-this
  "C-<"           'mc/mark-previous-like-this

  "C-`"           'switch-to-last-buffer
  )


(general-define-key
  :prefix "C-x"

  "k"             'kill-or-bury-ask-buffer
  )



(provide 'init-ctrlchords)
;;; init-ctrlchords.el ends here
