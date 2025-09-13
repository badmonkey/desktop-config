;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-movement.el --- interactive funs for cursor movements


(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (buffer-list-next)))


(defun goto-line-with-prefix ()
  (interactive)
  (goto-char (point-min))
  (forward-line (1- (string-to-number
                      (read-from-minibuffer
                        "Goto line: "
                        (char-to-string last-command-event))))))


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


(provide 'init-ifun-movement.el)
;;; init-ifun-movement.el.el ends here
