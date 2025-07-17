;;; init-interactive-defuns --- Interactive funs that require packages are loaded and
;;; are use by key bindings
;;; Commentary:
;;; Code:


;;
;; Interactive buffer funs
;;

(defun debug-beep ()
  (interactive)
  (message "beep %s" (char-to-string last-command-event)))

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (buffer-list-next)))


(defun toggle-supersub-mode ()
  (interactive)
  (if subword-mode
    (progn
      (message ".. superword on")
      (superword-mode)
      (subword-mode -1))
    (message ".. subword on")
    (subword-mode)
    (superword-mode -1)))


(defun activate-venv ()
  (interactive)
  (venv-projectile-auto-workon))


(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if
       (let ((window (get-buffer-window (current-buffer))))
         (set-window-dedicated-p window (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))


(defvar box/top-left "\u256d")
(defvar box/bot-left "\u2570")
(defvar box/left "\u2502")
(defvar box/top "\u2500")
(defvar box/top-long (s-repeat 8 box/top))

(defun kill-with-linenum (beg end)
  (interactive "r")
  (save-excursion
    (goto-char end)
    (skip-chars-backward "\n \t")
    (setq end (point))
    (let* ((chunk (buffer-substring beg end))
           (chunk (concat
                   (format "%s%s #%-d %s %s %s\n%s "
                           box/top-left
                           box/top-long
                           (line-number-at-pos beg)
                           box/top
                           (or (buffer-file-name) (buffer-name))
                           (s-repeat 2 box/top)
                           box/left)
                   (replace-regexp-in-string "\n" (format "\n%s " box/left) chunk)
                   (format "\n%s%s #%-d %s"
                           box/bot-left
                           box/top-long
                           (line-number-at-pos end)
                           box/top-long))))
      (kill-new chunk)))
  (deactivate-mark))

(defun kill-or-bury-current-buffer ()
  (interactive)
  (if (bound-and-true-p emacs-lock-mode)
    (progn
      (switch-to-buffer (buffer-list-next))
      (bury-buffer))
    (kill-buffer)))


(defun kill-or-bury-ask-buffer (buffer unlocked)
  (interactive (input-buffer))
  (if unlocked
    (let ((next-buffer (buffer-list-next)) )
      (switch-to-buffer next-buffer)
      (bury-buffer buffer)
      (message "bury %s" buffer) )
    (kill-buffer buffer)))


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
           (buffer-file-name buffer)
           (not (file-exists-p (buffer-file-name buffer)))
           (kill-buffer buffer)))))


(defun goto-line-with-prefix ()
   (interactive)
   (goto-char (point-min))
   (forward-line (1- (string-to-number
               (read-from-minibuffer
            "Goto line: "
            (char-to-string last-command-event))))))


(defun point-to-buffer-start ()
  (interactive)
  (goto-char (point-min)))

(defun point-to-buffer-end ()
  (interactive)
  (goto-char (point-max)))


(defun narrow-to-region-indirect (start end)
  "Restrict editing in this buffer to the current region, indirectly."
  (interactive "r")
  (deactivate-mark)
  (let ((buf (clone-indirect-buffer nil nil)))
    (with-current-buffer buf
      (narrow-to-region start end))
    (switch-to-buffer buf)))

(defun toggle-fancy-narrow (start end)
  "Toggle fancy narrow-to-region"
  (interactive (input-region-or-everything))
  (if (fancy-narrow-active-p)
    (fancy-widen)
    (progn
      (deactivate-mark)
      (fancy-narrow-to-region start end)
      (point-to-buffer-end))))

;;
;; General interactive functions
;;
(defun delete-ws-right (start end)
  "Delete all spaces and tabs from point to next non-white char."
  (interactive (input-region-ws-right))
  (delete-region start end))

(defun delete-ws-left (start end)
  "Delete all spaces and tabs from the previous non-white char to point."
  (interactive (input-region-ws-left))
  (delete-region start end))

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
  (let ((text (string-trim (buffer-substring start end))))
    (if (s-blank? text)
      (comment-dwim nil)
      (comment-or-uncomment-region start end))))


(defun region-indent-code (start &optional end)
  "If there is an active region use indent-code-rigidly else indent-for-tab-command."
  (interactive (input-region-or-point))
  (if (use-region-p)
    (indent-code-rigidly start end tab-width)
    (indent-for-tab-command)))

(defun region-indent-left (start end)
  (interactive (input-region-or-line))
  (indent-rigidly-left-to-tab-stop start end))


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

(defun region-join-lines (start &optional end)
  (interactive (input-region-or-point))
  (if (use-region-p)
    (delete-indentation nil start end)
    (delete-indentation)))

(defun region-delete-back-word (start &optional end)
  (interactive (input-region-or-point))
  (if (use-region-p)
    (delete-region start end)
    (backward-kill-word 1)))

(defun untabify-everything (start end)
  (interactive (input-region-or-everything))
  (untabify start end))


(defun query-replace-from-region (from-string to-string &optional start end interactive)
  (interactive (input-region-from-to-args "Query replace" nil))
  (when mark-active
    (goto-char (region-beginning))
    (deactivate-mark))
  (query-replace from-string to-string))


(defun repeat-query-replace (from-string to-string)
  (interactive (input-replace-from-to-args "Query replace" nil))
  (query-replace from-string to-string))


(defun repeat-query-replace-regexp (from-string to-string)
  (interactive (input-replace-from-to-args "Query replace" t))
  (query-replace-regexp from-string to-string))


(defun fill-region-or-line (start end)
  (interactive (input-region-or-line))
  (fill-region-as-paragraph start end))


(defun ispell-region-or-line (start end)
  (interactive (input-region-or-line))
  (ispell-region start end))


(defun region-upcase-word (start &optional end)
  (interactive (input-region-or-point))
  (if (use-region-p)
    (upcase-region start end)
    (upcase-word 1)))


(defun region-downcase-word (start &optional end)
  (interactive (input-region-or-point))
  (if (use-region-p)
    (downcase-region start end)
    (downcase-word 1)))

(defun region-qp-encode (start end)
  (interactive (input-region-or-line))
  (quoted-printable-encode-region start end t))

(defun region-qp-decode (start end)
  (interactive (require-region))
  (quoted-printable-decode-region start end))

(defun unfill-region (start end)
  "Unfill the region, joining text paragraphs into a single
    logical line.  This is useful, e.g., for use with
    `visual-line-mode'."
  (interactive (require-region))
  (let ((fill-column (point-max)))
    (fill-region start end)))


(defun kill-inner-region (ch)
  (interactive (input-char-from-smart-region t))
  (change-inner* nil ch))

(defun kill-outer-region (ch)
  (interactive (input-char-from-smart-region t))
  (change-outer* nil ch))

(defun copy-inner-region (ch)
  (interactive (input-char-from-smart-region t))
  (change-inner* t ch))

(defun copy-outer-region (ch)
  (interactive (input-char-from-smart-region t))
  (change-outer* t ch))


;;  Help functions
(defun describe-function-at-point ()
  (interactive)
  (describe-function (function-called-at-point)))


;;  python functions

(defun switch-to-python-shell ()
  (interactive)
  (unless (python-shell-get-process)
    (run-python))
  (python-shell-switch-to-shell))


;;  Frame functions

(defun transpose-windows ()
   "Transpose two windows.  If more or less than two windows are visible, error."
   (interactive)
   (unless (= 2 (count-windows))
     (error "There are not 2 windows."))
   (let* ((windows (window-list))
          (w1 (car windows))
          (w2 (nth 1 windows))
          (w1b (window-buffer w1))
          (w2b (window-buffer w2)))
     (set-window-buffer w1 w2b)
     (set-window-buffer w2 w1b)))


(defun toggle-window-transparency ()
  "Cycle the frame transparency from default to transparent."
  (interactive)
  (let ((transparency 85)
         (opacity 100))
    (if (and (not (eq (frame-parameter nil 'alpha) nil))
          (< (frame-parameter nil 'alpha) opacity))
      (set-frame-parameter nil 'alpha opacity)
      (set-frame-parameter nil 'alpha transparency))))


;; WIP
(defun select-at-point ()
  (interactive)
  (let* ((bds (bounds-of-thing-at-point 'word))
          (p1 (car bds))
          (p2 (cdr bds)))
    (set-mark p1)
    (goto-char p2)))

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
;; currently replaces the text of a line with "" so leaves a blank line
(defun query-kill-matching-lines (regexp &optional start end interactive)
  (interactive
    (keep-lines-read-args "Kill lines containing match for regexp"))
  (unless (string-prefix-p "^" regexp)
    (setq regexp (format "^.*%s" regexp)))
  (unless (string-suffix-p "$" regexp)
    (setq regexp (format "%s.*$" regexp)))
  (query-replace-regexp regexp "" nil start end))


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
        (bm-bookmark-annotate bookmark annotation)))
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
