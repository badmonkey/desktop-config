;;; -*- lexical-binding: t; -*-
;;;
;;; init-defun-misc --- misc funs


(defun er/mark-line ()
  "mark one line"
  (let ((inhibit-field-text-motion t))
    (end-of-line)
    (push-mark nil t t)
    (beginning-of-line)))


(provide 'init-defun-misc)
;;; init-defun-misc.el ends here
