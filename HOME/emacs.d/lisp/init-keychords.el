;;; init-keychords --- Custom behaviour
;;; Commentary:
;;; Code:


(general-define-key
  (general-chord ";;")      'region-toggle-comment

  (general-chord "\\\\")    'bm-toggle

  (general-chord "``")      'point-to-buffer-start
  (general-chord "\,\,")    'switch-to-last-buffer

  ;; (general-chord "jj")      'avy-goto-char-2
  (general-chord "jj")      'avy-goto-char-timer

  (general-chord "/.")      'hydra-mark/body

  (general-chord "\'\'")    'ispell-word

  (general-chord "[[")      'previous-error
  (general-chord "]]")      'next-error

  (general-chord "\\[")     'bm-previous
  (general-chord "\\]")     'bm-next
  )


(provide 'init-keychords)
;;; init-keychords.el ends here
