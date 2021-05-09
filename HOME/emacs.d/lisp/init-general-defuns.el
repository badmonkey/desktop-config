;;; init-general-defuns --- funs that are used when loading packages
;;; Commentary:
;;; Code:



;;
;; Buffer related general purpose functions
;;

(defun buffer-list-next ()
  (seq-some
   '(lambda (x) (if (s-starts-with? " *" (buffer-name x)) nil x))
   (cdr (buffer-list))) )


(defun as-buffer-name (buffer)
  (cond ((not buffer) (buffer-name (current-buffer)))
        ((stringp buffer) buffer)
        ((bufferp buffer) (buffer-name buffer)) ))

(defun buffer-lockedp (buffer)
  (with-current-buffer buffer
    (bound-and-true-p emacs-lock-mode)))


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

(defun input-region-or-everything ()
  (if (region-active-p)
      (list (region-beginning)
            (region-end))
    (list (point-min) (point-max))))

(defun input-region-from-to-args (prompt regexp-flag)
  (if (region-active-p)
      (let ((region-text (buffer-substring (region-beginning) (region-end))))
        (list region-text (query-replace-read-to region-text prompt regexp-flag)))
    (query-replace-read-args prompt regexp-flag)))

(defun require-region ()
  (if (region-active-p)
      (list (region-beginning)
            (region-end))
    (error "Requires a selected region")))

;;
;; Interactive prompts for misc
;;

(defun input-char-from-smart-region (&optional as-string atpoint ch)
  (unless atpoint
    (setq atpoint (if (region-active-p)
                      (region-beginning)
                    (point))))
  (unless ch
    (setq ch (char-after atpoint)))
  (if as-string
      (list (char-to-string ch))
    (list ch)))


(defun filter-buffer-p (buffer default)
  (if buffer
      (or (equal buffer default)
          (with-current-buffer buffer
            (let ((name (buffer-name)))
              (not (or (bound-and-true-p emacs-lock-mode)
                       ;; (s-starts-with? "*" name)
                       (s-starts-with? " *" name) )))))))


(defun input-buffer (&optional prompt default predicate)
  (unless prompt
    (setq prompt "Select Buffer: "))
  (unless default
    (setq default (current-buffer)))
  (unless predicate
    (setq predicate '(lambda (x) (filter-buffer-p x default))))
  (let* ((select (read-buffer prompt default t predicate))
         (locked (buffer-lockedp select)) )
    (list select locked) ))


;;
;; General purpose interactive functions
;;

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



;;
;; Icon funs
;;
(defun with-alltheicon (icon str &optional height v-adjust)
  "Displays an icon from all-the-icon."
  (s-concat
   (all-the-icons-alltheicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

(defun with-faicon (icon str &optional height v-adjust)
  "Displays an icon from Font Awesome icon."
  (s-concat
   (all-the-icons-faicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

(defun with-fileicon (icon str &optional height v-adjust)
  "Displays an icon from the Atom File Icons package."
  (s-concat
   (all-the-icons-fileicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

(defun with-octicon (icon str &optional height v-adjust)
  "Displays an icon from the GitHub Octicons."
  (s-concat
   (all-the-icons-octicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))



(provide 'init-general-defuns)
;;; init-general-defuns.el ends here
