;;; -*- lexical-binding: t; -*-
;;;
;;; init-defun-stdlib --- extended stdlib funs


(defun add-list-to-list (dst src)
  "append list src to list dst"
  (set dst
    (append (eval dst) src)))


(provide 'init-defun-stdlib)
;;; init-defun-stdlib.el ends here
