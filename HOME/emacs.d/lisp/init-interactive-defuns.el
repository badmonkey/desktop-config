;;; init-interactive-defuns --- Interactive funs that require packages are loaded and
;;; are use by key bindings
;;; Commentary:
;;; Code:


;;
;; Interactive buffer funs
;;

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (cadr (buffer-list))))


(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))


(defun activate-venv ()
  (interactive)
  (venv-projectile-auto-workon))


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


(defun point-to-buffer-start ()
  (interactive)
  (goto-char (point-min)))

(defun point-to-buffer-end ()
  (interactive)
  (goto-char (point-max)))


;;
;; advice for indent funs
;;

(defadvice indent-rigidly (after deactivate-mark-nil activate)
     (if (called-interactively-p 'any)
         (setq deactivate-mark nil)))


(defadvice indent-code-rigidly (after deactivate-mark-nil activate)
     (if (called-interactively-p 'any)
         (setq deactivate-mark nil)))


;;
;; Interactive region funs
;;

(defun region-toggle-comment (start end)
  (interactive (input-region-or-line))
  (if (eq start end)
      (comment-dwim nil)
    (comment-or-uncomment-region start end)))


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
	  (delete-region start end)
	(backward-kill-word 1)))


(defun query-replace-from-region (from-string to-string &optional start end interactive)
  (interactive (input-region-from-to-args "Query replace" nil))
  (progn
	(when mark-active
	  (goto-char (mark))
	  (deactivate-mark))
	(query-replace from-string to-string)))


;; WIP
(defun select-at-point ()
  (interactive)
  (setq default (thing-at-point 'word))
  (setq bds (bounds-of-thing-at-point 'word))
  (setq p1 (car bds))
  (setq p2 (cdr bds))
  (set-mark p1)
  (goto-char p2))

(defun next-like-this-region (arg)
  (interactive "p")
  (if (not (region-active-p))
      (select-at-point)
    (mc/mark-next-like-this arg)))

(defun previous-like-this-region (arg)
  (interactive "p")
  (if (not (region-active-p))
      (select-at-point)
    (mc/mark-previous-like-this arg)))




;; still WIP
(defun query-kill-matching-lines (regexp &optional start end interactive)
  (interactive
   (keep-lines-read-args "Kill lines containing match for regexp"))
  (progn
	(unless (string-prefix-p "^" regexp)
	  (setq regexp (format "^.*%s" regexp)))
	(unless (string-suffix-p "$" regexp)
	  (setq regexp (format "%s.*$" regexp)))
	(query-replace-regexp regexp "" nil start end)))


;;
;; Interactive bookmark funs
;;

(defun bm-annotate-or-create (&optional bookmark annotation)
  (interactive)
  (if (null bookmark)
      (setq bookmark (bm-bookmark-at (point))))

  (if bookmark
	  (progn
		(setq annotation (overlay-get bookmark 'annotation))
		(setq annotation (read-from-minibuffer "Annotation: " annotation nil nil 'bm-annotation-history))
		(if annotation
			(bm-bookmark-annotate bookmark annotation)
		  ))
      (bm-bookmark-annotate (bm-bookmark-add annotation))))



;;
;; Misc funs
;;

(defun git-difftool (file-a file-b)
  (ediff-files file-a file-b))


(defun git-mergetool (file-a file-b file-out &optional file-ancestor)
  (if (and file-ancestor
           (file-exists-p file-ancestor)
           (file-readable-p file-ancestor))
      (ediff-merge-files-with-ancestor file-a file-b file-ancestor nil file-out)
    (ediff-merge-files file-a file-b nil file-out)))





(provide 'init-interactive-defuns)
;;; init-interactive-defuns.el ends here
