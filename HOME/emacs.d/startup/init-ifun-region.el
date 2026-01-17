;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-region --- interactive funs for regions


(defun region-copy-line (start &optional end)
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (kill-ring-save start end)
    (copy-region-as-kill start (line-end-position))))


;; (defun region-yank (start &optional end)
;;   (interactive (prompt-region-or-point))
;;   (if (use-region-p)
;;     (let ((text (buffer-substring-no-properties start end)))
;;       (message "stash '%s'\n" text)
;;       (delete-region start end)
;;       (yank)
;;       (kill-new text)
;;       )
;;     (yank)))

(defun region-yank (start &optional end)
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (progn
      (delete-region start end)
      (insert (current-kill 1)))
    (yank)))


(defun region-copy-whole-line (start end)
  (interactive (prompt-region-or-line))
  (if (use-region-p)
    (kill-ring-save start end)
    (copy-region-as-kill start end)))


(defun ispell-region-or-line (start end)
  (interactive (prompt-region-or-line))
  (ispell-region start end))


(defun copy-inner-region (ch)
  (interactive (prompt-char-from-smart-region t))
  (change-inner* t ch))

(defun copy-outer-region (ch)
  (interactive (prompt-char-from-smart-region t))
  (change-outer* t ch))


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
  (interactive (prompt-region-or-everything))
  (if (fancy-narrow-active-p)
    (fancy-widen)
    (progn
      (deactivate-mark)
      (fancy-narrow-to-region start end)
      (point-to-buffer-end))))


(provide 'init-ifun-region)
;;; init-ifun-region.el ends here
