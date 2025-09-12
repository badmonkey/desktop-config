;;; -*- lexical-binding: t; -*-
;;;
;;; init-defun-prompts --- interactive prompt funs


(defun prompt-region-or-point ()
  (if (region-active-p)
    (list (region-beginning)
      (region-end))
    (list (point))))

(defun prompt-region-or-line ()
  (if (region-active-p)
    (list (region-beginning)
      (region-end))
    (list (line-beginning-position)
      (line-end-position))))

(defun prompt-region-or-everything ()
  (if (region-active-p)
    (list (region-beginning)
      (region-end))
    (list (point-min) (point-max))))

(defun prompt-region-from-to-args (prompt regexp-flag)
  (if (region-active-p)
    (let ((region-text (buffer-substring (region-beginning) (region-end))))
      (list region-text (query-replace-read-to region-text prompt regexp-flag)))
    (query-replace-read-args prompt regexp-flag)))

(defun prompt-replace-from-to-args (prompt regexp-flag)
  (if query-replace-defaults
    (let ((last-query (car query-replace-defaults)))
      (list (car last-query) (cdr last-query)))
    (query-replace-read-args prompt regexp-flag)))

(defun require-region ()
  (if (region-active-p)
    (list (region-beginning)
      (region-end))
    (error "Requires a selected region")))

(defun prompt-region-ws-right ()
  (if (region-active-p)
    (list (point)
      (save-excursion
        (skip-chars-forward "[:space:]" (region-end))
        (point)))
    (list (point)
      (save-excursion
        (skip-chars-forward "[:space:]")
        (point)))))

(defun prompt-region-ws-left ()
  (if (region-active-p)
    (list (save-excursion
            (skip-chars-backward "[:space:]" (region-beginning))
            (point))
      (point))
    (list (save-excursion
            (skip-chars-backward "[:space:]")
            (point))
      (point))))

(defun prompt-char-from-smart-region (&optional as-string atpoint ch)
  (unless atpoint
    (setq atpoint (if (region-active-p)
                    (region-beginning)
                    (point))))
  (unless ch
    (setq ch (char-after atpoint)))
  (if as-string
    (list (char-to-string ch))
    (list ch)))

(defun prompt-buffer (predicate &optional prompt default)
  (unless prompt (setq prompt "Select Buffer: "))
  (unless default (setq default (current-buffer)))
  (list (read-buffer prompt default t predicate)))


(provide 'init-defun-prompts)
;;; init-defun-prompts.el ends here
