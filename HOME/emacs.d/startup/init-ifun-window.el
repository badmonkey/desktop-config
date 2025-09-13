;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-window --- interactive funs for window manipulation


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


(provide 'init-ifun-window)
;;; init-ifun-window.el ends here
