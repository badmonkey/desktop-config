;;; init-defuns --- Custom defuns
;;; Commentary:
;;; Code:


(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))


(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))


(defun kill-unmodified-buffers ()
  "Kill all unmodified buffers and closes all but the selected frame."
  (interactive)
  (save-window-excursion
    (dolist (buffer (buffer-list))
      (and (buffer-live-p buffer)
           (not (buffer-modified-p buffer))
           (kill-buffer buffer)))))


(defun kill-orphan-buffers ()
  "Kill all buffers where the matching file doesn't exist."
  (interactive)
  (save-window-excursion
    (dolist (buffer (buffer-list))
      (and (buffer-live-p buffer)
           (not (buffer-modified-p buffer))
           (not (file-exists-p (buffer-file-name buffer)))
           (kill-buffer buffer)))))


(defun git-difftool (file-a file-b)
  (ediff-files file-a file-b))

(defun git-mergetool (file-a file-b file-out &optional file-ancestor)
  (if (and file-ancestor
           (file-exists-p file-ancestor)
           (file-readable-p file-ancestor))
      (ediff-merge-files-with-ancestor file-a file-b file-ancestor nil file-out)
    (ediff-merge-files file-a file-b nil file-out)))

(defadvice indent-rigidly (after deactivate-mark-nil activate)
     (if (called-interactively-p 'any)
         (setq deactivate-mark nil)))

(defadvice indent-code-rigidly (after deactivate-mark-nil activate)
     (if (called-interactively-p 'any)
         (setq deactivate-mark nil)))

(defun comment-or-uncomment-line ()
  "Comment or uncomment current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))


(defun input-region-or-point ()
  (if (region-active-p)
     (list (region-beginning) (region-end))
	(list (point))))

(defun input-region-or-line ()
  (if (region-active-p)
     (list (region-beginning) (region-end))
	(list (line-beginning-position) (line-end-position))))


(defun region-indent-code (start &optional end)
  "If there is an active region use indent-code-rigidly else indent-for-tab-command."
  (interactive (input-region-or-point))
  (if (use-region-p)
	  (indent-code-rigidly start end tab-width)
	(indent-for-tab-command)))

(defun region-kill-line (start &optional end)
  (interactive (input-region-or-point))
  (if (use-region-p)
	  (kill-region start end)
	(kill-line)))

(defun region-kill-whole-line (start &optional end)
  (interactive (input-region-or-point))
  (if (use-region-p)
	  (kill-region beg end)
	(kill-whole-line)))

(defun region-kill-to-left-margin (start &optional end)
  (interactive (input-region-or-point))
  (if (use-region-p)
	  (kill-region start end)
	(kill-region (line-beginning-position) start)))

(defun region-copy-line (start &optional end)
  (interactive (input-region-or-point))
  (if (use-region-p)
	  (kill-ring-save start end)
	(copy-region-as-kill start (line-end-position))))

(defun region-copy-whole-line (start end)
  (interactive (input-region-or-line))
  (if (use-region-p)
	  (kill-ring-save start end)
	(copy-region-as-kill start end)))

(defun region-delete-back-word (start &optional end)
  (interactive (input-region-or-point))
  (if (use-region-p)
	  (delete-region beg end)
	(backward-kill-word)))


;; WIP ;;
(defun query-kill-matching-lines (regexp &optional beg end interactive)
  "fuck it."
  (interactive
   (list
	(keep-lines-read-args "Kill lines containing match for regexp")
	(region-beginning) (region-end)))
  (flush-lines regexp beg end interactive))

(defun kill-matching-lines (regexp &optional beg end interactive)
  "Kill lines containing matches for REGEXP."
  (interactive
   (keep-lines-read-args "Kill lines containing match for regexp"))
  (let ((buffer-file-name nil)) ;; HACK for `clone-buffer'
    (with-current-buffer (clone-buffer nil nil)
      (let ((inhibit-read-only t))
        (keep-lines regexp rstart rend interactive)
        (kill-region (or rstart (line-beginning-position))
                     (or rend (point-max))))
      (kill-buffer)))
  (unless (and buffer-read-only kill-read-only-ok)
    ;; Delete lines or make the "Buffer is read-only" error.
    (flush-lines regexp rstart rend interactive)))



(provide 'init-defuns)
;;; init-defuns.el ends here
