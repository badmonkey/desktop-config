;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-system --- interactive funs for system state or actions


(defun debug-beep ()
  (interactive)
  (message "beep %s" (char-to-string last-command-event)))


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


(defun point-to-buffer-start ()
  (interactive)
  (goto-char (point-min)))


(defun point-to-buffer-end ()
  (interactive)
  (goto-char (point-max)))


(defun describe-function-at-point ()
  (interactive)
  (describe-function (function-called-at-point)))


;; WIP
(defun select-at-point ()
  (interactive)
  (let* ((bds (bounds-of-thing-at-point 'word))
          (p1 (car bds))
          (p2 (cdr bds)))
    (set-mark p1)
    (goto-char p2)))


(defun screenshot ()
  "Take a SVG screenshot of the current frame."
  (interactive)
  (let ((filename
          (make-temp-file
            (concat "emacs-"
              (format-time-string "%Y-%m-%dT%H:%M"))
            nil
            ".svg"
            (x-export-frames nil 'svg))))))


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


(provide 'init-ifun-system)
;;; init-ifun-system.el ends here
