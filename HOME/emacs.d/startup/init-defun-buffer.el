;;; -*- lexical-binding: t; -*-
;;;
;;; init-defun-buffer --- buffer functionality funs


;; buffers are fitlered into classes based on buffer names
;; "hidden" buffer begin with " *" and are usually buffers for communicating
;;      with subprocesses
;; "transient" buffers are buffers from modes or other functionality that aren't
;;      closed automatically when they're not needed anymore
;; "metabuffer" buffers starting "*.." that are not included as `transient`
;; "project" buffer belongs to a project
;;
;; "general.el"                             - killable ordinary
;; "library.el"     project                 - killable ordinary
;; "commit_msg"     locked                  - ordinary
;; "*scratch*"      metabuffer locked       -
;; "*Backtrace*"    metabuffer              - killable
;; "*magit-diff*"   metabuffer transient    - boring killable
;; " *Minibuf-1*"   hidden                  - boring


(defun buffer-matches-any (buffer-or-name regexp-list)
  "true if buffer-or-name matches and of the regexp in regexp-list"
  (let ((name (buffer-get-name buffer-or-name)))
    (-any? #'(lambda (x) (s-matches-p x name)) regexp-list)))

(defun buffer-is-transient-p (buffer-or-name)
  (buffer-matches-any buffer-or-name transient-buffer-regexp-list))

(defun buffer-is-hidden-p (buffer-or-name)
  (buffer-matches-any buffer-or-name hidden-buffer-regexp-list))

(defun buffer-is-metabuffer-p (buffer-or-name)
  (buffer-matches-any buffer-or-name meta-buffer-regexp-list))

(defun buffer-is-locked-p (buffer-or-name)
  (with-current-buffer buffer-or-name
    (bound-and-true-p emacs-lock-mode)))

(defun buffer-is-boring-p (buffer-or-name)
  (or
    (buffer-is-transient-p buffer-or-name)
    (buffer-is-hidden-p buffer-or-name)))

(defun buffer-is-killable-p (buffer-or-name)
  (not (or
         (buffer-is-locked-p buffer-or-name)
         (buffer-is-hidden-p buffer-or-name))))

(defun buffer-is-ordinary-p (buffer-or-name)
  (not (or
         (buffer-is-metabuffer-p buffer-or-name)
         (buffer-is-hidden-p buffer-or-name))))

;; (defun modi/kill-non-project-buffers (&optional kill-special)
;;   "Kill buffers that do not belong to a `projectile' project.

;; With prefix argument (`C-u'), also kill the special buffers."
;;   (interactive "P")
;;   (let ((bufs (buffer-list (selected-frame))))
;;     (dolist (buf bufs)
;;       (with-current-buffer buf
;;         (let ((buf-name (buffer-name buf)))
;;           (when (or (null (projectile-project-p))
;;                   (and kill-special
;;                     (string-match "^\*" buf-name)))
;;             ;; Preserve buffers with names starting with *scratch or *Messages
;;             (unless (string-match "^\\*\\(\\scratch\\|Messages\\)" buf-name)
;;               (message "Killing buffer %s" buf-name)
;;               (kill-buffer buf))))))))

(defun buffer-list-grouped (prefer-pred &optional select)
  (let ((buffers (if (not select) (buffer-list) (match-buffers select))))
    (-flatten (-separate #'(lambda (x) (funcall prefer-pred x)) buffers))))

(defun buffer-list-next ()
  (seq-some
    #'(lambda (x) (unless (buffer-is-boring-p x) x))
    (cdr (buffer-list))))

(defun buffer-get-name (buffer-or-name)
  (cond
    ((stringp buffer-or-name) buffer-or-name)
    ((bufferp buffer-or-name) (buffer-name buffer-or-name))))

(defun buffer-lockedp (buffer-or-name)
  (with-current-buffer buffer-or-name
    (bound-and-true-p emacs-lock-mode)))


(provide 'init-defun-buffer)
;;; init-defun-buffer.el ends here
