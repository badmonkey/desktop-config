;;; -*- lexical-binding: t; -*-
;;;
;;; init-keychords --- Custom behaviour


(general-define-key
  ;; https://www.johndcook.com/blog/2015/02/01/rare-bigrams/

  (general-chord ";;")      'region-toggle-comment

  (general-chord "\\\\")    'bm-toggle

  (general-chord "``")      'point-to-buffer-start
  (general-chord "\,\,")    'switch-to-last-buffer
  ;; ".." is likely to clash

  (general-chord "aa")      'debug-beep
  (general-chord "bb")      'debug-beep
  (general-chord "hh")      'debug-beep

  (general-chord "jj")      'avy-goto-char-timer
  (general-chord "kk")      'goto-last-change

  (general-chord "LL")      'debug-beep

  (general-chord "qq")      'debug-beep
  (general-chord "uu")      'debug-beep

  (general-chord "vv")      'toggle-supersub-mode

  ;; "ww" clashes with www. addresses
  (general-chord "xx")      'debug-beep
  (general-chord "yy")      'debug-beep
  (general-chord "zz")      'debug-beep

  ;; "//" clashes with comments and 3-slash comments

  (general-chord "\'\'")    'ispell-word

  (general-chord "[[")      'previous-error
  (general-chord "]]")      'next-error

  (general-chord "\\[")     'bm-previous
  (general-chord "\\]")     'bm-next
  )


(provide 'init-keychords)
;;; init-keychords.el ends here
