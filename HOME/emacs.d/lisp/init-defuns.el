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


(defun comment-or-uncomment-line ()
  "Comment or uncomment current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(defun indent-code-region (beginning end)
  "If there is an active region use indent-code-rigidly else indent-for-tab-command."
  (interactive "r")
  (if (use-region-p)
	  (indent-code-rigidly beginning end tab-width)
	(indent-for-tab-command)))


(defun region-kill-line (beg end)
  (interactive "r")
  (if (use-region-p)
	  (kill-region beg end)
	(kill-line)))

(defun region-kill-to-left-margin (beg end)
  (interactive "r")
  (if (use-region-p)
	  (kill-region beg end)
	(kill-region (line-beginning-position) (point))))

(defun region-copy-line (beg end)
  (interactive "r")
  (if (use-region-p)
	  (kill-ring-save beg end)
	(copy-region-as-kill (point) (line-end-position))))

(defun region-delete-back-word (beg end)
  (interactive "r")
  (if (use-region-p)
	  (delete-region beg end)
	(backward-kill-word)))

(defun region-copy-whole-line (beg end)
  (interactive "r")
  (if (use-region-p)
	  (kill-ring-save beg end)
	(copy-region-as-kill (line-beginning-position) (line-end-position))))



(defadvice indent-rigidly (after deactivate-mark-nil activate)
     (if (called-interactively-p 'any)
         (setq deactivate-mark nil)))

(defadvice indent-code-rigidly (after deactivate-mark-nil activate)
     (if (called-interactively-p 'any)
         (setq deactivate-mark nil)))



(provide 'init-defuns)
;;; init-defuns.el ends here
