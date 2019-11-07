;;; init-keychords --- Custom behaviour
;;; Commentary:
;;; Code:


(general-define-key
  (general-chord ";;")      'region-toggle-comment

  (general-chord "\\\\")    'bm-toggle

  (general-chord "``")      'point-to-buffer-start
  (general-chord "\,\,")    'switch-to-last-buffer

  ;; WIP
  (general-chord "..")      (general-predicate-dispatch ".."
                              (derived-mode-p 'markdown-mode) 'hydra-mark/body)

  (general-chord "[;")      'previous-error
  (general-chord ";[")      'previous-error
  (general-chord "];")      'next-error
  (general-chord ";]")      'next-error

  (general-chord "[\\")     'bm-previous
  (general-chord "\\[")     'bm-previous
  (general-chord "]\\")     'bm-next
  (general-chord "\\]")     'bm-next
  )


(provide 'init-keychords)
;;; init-keychords.el ends here
