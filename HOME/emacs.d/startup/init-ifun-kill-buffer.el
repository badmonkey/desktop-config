;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-kill-buffer --- interactive funs to kill buffers


(defun kill-or-bury-buffer (&optional buffer-or-name)
  "Kill specified buffer (or current-buffer if nil).
If the buffer is locked, bury it instead of attempting to kill it"
  (interactive)
  (let* ((current (current-buffer))
          (buffer (or buffer-or-name current))
          (is-current (eq (get-buffer buffer) current))
          (locked (buffer-lockedp buffer)))
    (when is-current (switch-to-buffer (buffer-list-next)))
    (if locked
      (bury-buffer buffer)
      (kill-buffer buffer))))


(defun kill-or-bury-selected-buffer (buffer)
  (interactive (prompt-buffer #'buffer-is-killable-p))
  (kill-or-bury-buffer buffer))


(defun kill-all-buffers ()
  "kill all buffers (excluding locked buffers), including transient and hidden buffers"
  (interactive)
  (mapc #'kill-buffer (buffer-list)))


(defun kill-other-buffers ()
  "Kill all other buffers except the current buffer (and locked buffers)"
  (interactive)
  (mapc #'kill-buffer (delq (current-buffer) (buffer-list))))


(defun kill-unmodified-buffers ()
  "Kill all unmodified working buffers"
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


(provide 'init-ifun-kill-buffer)
;;; init-ifun-kill-buffer.el ends here
