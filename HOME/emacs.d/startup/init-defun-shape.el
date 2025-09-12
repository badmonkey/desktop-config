;;; -*- lexical-binding: t; -*-
;;;
;;; init-defun-shape --- funs for shapes



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


(provide 'init-defun-shape)
;;; init-defun-shape.el ends here
