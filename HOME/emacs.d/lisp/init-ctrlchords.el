;;; init-ctrlchords --- Add ctrl-chord bindings
;;; Commentary:
;;; Code:



(general-unbind
;; So you can't accidently quit or suspend the emacs server
  "C-x C-c"
  "C-z"

;; Stop uppercase-region warning from fucking with undo
  "C-x C-u"

;; Need to delete this at the source
  "C-x C-b"
  )


(general-define-key
  "C-="           'er/expand-region

  "<C-return>"    'crux-smart-open-line
  "<S-return>"    'crux-smart-open-line-above
  "<C-backspace>" 'region-kill-to-left-margin
  "<C-tab>"       'region-indent-code

  "C-a"           'crux-move-beginning-of-line

  "C-k"           'region-kill-line
  "C-w"           'region-copy-line

  "C-s"           'swiper-helm

  "C->"           'mc/mark-next-like-this
  "C-<"           'mc/mark-previous-like-this

  "H-SPC"         'switch-to-last-buffer

  ;; https://www.emacswiki.org/emacs/SwitchingBuffers#BufferCycling
  "<H-up>"        'switch-to-last-buffer
  "<H-down>"      'bury-buffer

  "H-["           'previous-like-this-region
  "H-]"           'next-like-this-region

  "H-g"           'point-to-buffer-end
  )


(general-define-key
  :prefix "C-x"

  "k"             'kill-or-bury-ask-buffer
  )



(provide 'init-ctrlchords)
;;; init-ctrlchords.el ends here
