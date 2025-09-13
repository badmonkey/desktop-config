;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-misc --- misc interactive funs


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


(provide 'init-ifun-misc)
;;; init-ifun-misc.el ends here
