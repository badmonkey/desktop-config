;;; init-keychords --- Custom behaviour
;;; Commentary:
;;; Code:


(general-define-key
 ;; https://www.johndcook.com/blog/2015/02/01/rare-bigrams/

 (general-chord ";;")      'region-toggle-comment

 (general-chord "\\\\")    'bm-toggle

 (general-chord "``")      'point-to-buffer-start
 (general-chord "\,\,")    'switch-to-last-buffer

 ;; aa
 ;; hh

 (general-chord "jj")      'avy-goto-char-timer
 (general-chord "kk")      'goto-last-change

 ;; qq
 ;; uu

 (general-chord "vv")      'toggle-supersub-mode

 ;; "ww" clashes with www. addresses
 ;; xx
 ;; yy
 ;; zz
 ;; "//" clashes with comments and 3-slash comments

 (general-chord "\'\'")    'ispell-word

 (general-chord "[[")      'previous-error
 (general-chord "]]")      'next-error

 (general-chord "\\[")     'bm-previous
 (general-chord "\\]")     'bm-next
 )


(provide 'init-keychords)
;;; init-keychords.el ends here
