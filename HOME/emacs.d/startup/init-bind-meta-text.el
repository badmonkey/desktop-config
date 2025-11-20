;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-text --- Add meta-text bindings


;;; M-u  text commands ;;;
(general-define-key
  :prefix "M-u"
  :prefix-command 'text-keymap

  "TAB"     'untabify-everything

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'markdown-mode) 'markdown-toc-delete-toc)

  "f"       'fill-region-or-line

  "g"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-buffer
              (derived-mode-p 'markdown-mode) 'markdown-toc-generate-toc)

  "l"       'region-downcase-word

  "r"       (general-predicate-dispatch nil
              (derived-mode-p 'markdown-mode) 'markdown-toc-refresh-toc)

  "s"       'ispell-region-or-line
  "t"       'transpose-words
  "u"       'region-upcase-word
  )


(provide 'init-bind-text)
;;; init-bind-text.el ends here
