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
      (let ((region-text (buffer-substring (region-beginning) (region-end))))
        (list region-text (query-replace-read-to region-text prompt regexp-flag)))
    (query-replace-read-args prompt regexp-flag)))


(defun working-buffer-p (buffer)
  (if buffer
      (with-current-buffer buffer
        (not (or (bound-and-true-p emacs-lock-mode)
                 (s-starts-with? " *" (buffer-name))
                 (s-starts-with? "*" (buffer-name)) )))))

;; with-current
;; with-locked
;; with-special  "*??*"
;;  always hide " *??*"

(defun input-working-buffer (style &optional prompt default)
  (unless prompt
    (setq prompt "Select Buffer: "))
  (cond ((eq style 'with-current)
         (setq default (buffer-name (current-buffer)))) )
  (read-buffer prompt default t 'working-buffer-p) )



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


(defun which-active-modes ()
  "Give a message of which minor modes are enabled in the current buffer."
  (interactive)
  (let ((active-modes))
    (mapc
     (lambda (mode)
       (condition-case nil
           (if (and (symbolp mode)
                    (symbol-value mode))
               (add-to-list 'active-modes mode))
         (error nil) ))
     minor-mode-list)
    (message "Active modes are %s" active-modes)))


(provide 'init-general-defuns)
;;; init-general-defuns.el ends here
