;;; ...  -*- lexical-binding: t -*-
;;;
;;; init-general-defuns --- funs that are used when loading packages


;;
;; Buffer related general purpose functions
;;

;; buffers are fitlered in to classes based on buffer names
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



(defun shape/display ()
  (let* ((geo (assoc 'geometry (frame-monitor-attributes)))
          (w (nth 3 geo))
          (h (nth 4 geo)))
    (cond
      ((= w h) 'display-shape-square)
      ((> w h) 'display-shape-landscape)
      (t 'display-shape-portrait))))

(defun shape/frame ()
  (let* ((w (float (frame-width)))
          (h (float (frame-height)))
          (aspect (/ w h))
          (squareish (and (>= aspect 0.87) (<= aspect 1.15))))
    (message "frame %s x %s = %s aspect (squareish? %s)" w h aspect squareish)
    (cond
      (squareish 'frame-shape-square)
      ((> w h) 'frame-shape-landscape)
      (t 'frame-shape-portrait))))

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

(defun input-replace-from-to-args (prompt regexp-flag)
  (if query-replace-defaults
    (let ((last-query (car query-replace-defaults)))
      (list (car last-query) (cdr last-query)))
    (query-replace-read-args prompt regexp-flag)))

(defun require-region ()
  (if (region-active-p)
    (list (region-beginning)
      (region-end))
    (error "Requires a selected region")))

(defun input-region-ws-right ()
  (if (region-active-p)
    (list (point)
      (save-excursion
        (skip-chars-forward "[:space:]" (region-end))
        (point)))
    (list (point)
      (save-excursion
        (skip-chars-forward "[:space:]")
        (point)))))

(defun input-region-ws-left ()
  (if (region-active-p)
    (list (save-excursion
            (skip-chars-backward "[:space:]" (region-beginning))
            (point))
      (point))
    (list (save-excursion
            (skip-chars-backward "[:space:]")
            (point))
      (point))))

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

(defun input-buffer (predicate &optional prompt default)
  (unless prompt (setq prompt "Select Buffer: "))
  (unless default (setq default (current-buffer)))
  (list (read-buffer prompt default t predicate)))


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


(defun er/mark-line ()
  "mark one line"
  (let ((inhibit-field-text-motion t))
    (end-of-line)
    (push-mark nil t t)
    (beginning-of-line)))


;;
;; Icon funs
;;
(defun subword-icon ()
  ""
  (if subword-mode
    (all-the-icons-material "last_page")
    (all-the-icons-material "keyboard_tab")))

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
