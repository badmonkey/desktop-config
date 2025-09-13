;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-region-transform --- interactive funs for transforming regions


(defun untabify-everything (start end)
  (interactive (prompt-region-or-everything))
  (untabify start end))


(defun region-toggle-comment (start end)
  (interactive (prompt-region-or-line))
  (let ((text (string-trim (buffer-substring start end))))
    (if (s-blank? text)
      (comment-dwim nil)
      (comment-or-uncomment-region start end))))


(defun region-indent-code (start &optional end)
  "If there is an active region use indent-code-rigidly else indent-for-tab-command."
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (indent-code-rigidly start end tab-width)
    (indent-for-tab-command)))


(defun region-indent-left (start end)
  (interactive (prompt-region-or-line))
  (indent-rigidly-left-to-tab-stop start end))


(defun region-join-lines (start &optional end)
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (delete-indentation nil start end)
    (delete-indentation)))


(defun fill-region-or-line (start end)
  (interactive (prompt-region-or-line))
  (fill-region-as-paragraph start end))


(defun region-upcase-word (start &optional end)
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (upcase-region start end)
    (upcase-word 1)))


(defun region-downcase-word (start &optional end)
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (downcase-region start end)
    (downcase-word 1)))


(defun region-qp-encode (start end)
  (interactive (prompt-region-or-line))
  (quoted-printable-encode-region start end t))


(defun region-qp-decode (start end)
  (interactive (require-region))
  (quoted-printable-decode-region start end))


(defun unfill-region (start end)
  "Unfill the region, joining text paragraphs into a single
    logical line.  This is useful, e.g., for use with
    `visual-line-mode'."
  (interactive (require-region))
  (let ((fill-column (point-max)))
    (fill-region start end)))


(provide 'init-ifun-region-transform)
;;; init-ifun-region-transform.el ends here
