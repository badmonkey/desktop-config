;;; init-general-defuns --- funs that are used when loading packages
;;; Commentary:
;;; Code:


;;
;; Interactive prompts for regions/lines
;;

(defun input-region-or-point ()
  (if (region-active-p)
      (list (region-beginning)
            (region-end))
    (list (point))))

(defun input-region-or-line ()
  (if (region-active-p)
      (list (region-beginning)
            (region-end))
    (list (line-beginning-position)
          (line-end-position))))

(defun input-region-from-to-args (prompt regexp-flag)
  (if (region-active-p)
      (let ((region-text
             (buffer-substring
              (region-beginning)
              (region-end))))
        (list region-text (query-replace-read-to region-text prompt regexp-flag)))
    (query-replace-read-args prompt regexp-flag)))



(defun append-to-list (list-var elements)
  "Append ELEMENTS to the end of LIST-VAR.

The return value is the new value of LIST-VAR."
  (unless (consp elements)
    (error "ELEMENTS must be a list"))
  (let ((list (symbol-value list-var)))
    (if list
        (setcdr (last list) elements)
      (set list-var elements)))
  (symbol-value list-var))


(defun venv-display-name ()
  (interactive)
  (when (bound-and-true-p venv-current-name)
    (let ((tmp-venv-name (file-truename venv-current-name)))
      (if (file-directory-p tmp-venv-name)
          (venv-dir-to-name tmp-venv-name)
        venv-current-name))))


(defun load-buffer (&optional buffer)
  (interactive "b")
  (let ((buffer-path (buffer-file-name (get-buffer buffer))))
    (when buffer-path
      (load-file buffer-path))))

(defun load-current-buffer ()
  (interactive)
  (let ((buffer-path (buffer-file-name)))
    (when buffer-path
      (load-file buffer-path))))



(provide 'init-general-defuns)
;;; init-general-defuns.el ends here
