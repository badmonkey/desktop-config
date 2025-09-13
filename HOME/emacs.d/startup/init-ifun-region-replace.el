;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-region-replace --- interactive funs for search and replace


(defun query-replace-from-region (from-string to-string &optional start end interactive)
  (interactive (prompt-region-from-to-args "Query replace" nil))
  (when mark-active
    (goto-char (region-beginning))
    (deactivate-mark))
  (query-replace from-string to-string))


(defun repeat-query-replace (from-string to-string)
  (interactive (prompt-replace-from-to-args "Query replace" nil))
  (query-replace from-string to-string))


(defun repeat-query-replace-regexp (from-string to-string)
  (interactive (prompt-replace-from-to-args "Query replace" t))
  (query-replace-regexp from-string to-string))


(provide 'init-ifun-region-replace)
;;; init-ifun-region-replace.el ends here
