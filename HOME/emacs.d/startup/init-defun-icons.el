;;; -*- lexical-binding: t; -*-
;;;
;;; init-defun-icons --- funs for icons


(defun subword-icon ()
  ""
  (if subword-mode
    (all-the-icons-material "last_page")
    (all-the-icons-material "keyboard_tab")))

(defun with-alltheicon (icon str &optional height v-adjust)
  "Displays an icon from all-the-icon."
  (s-concat
    (all-the-icons-alltheicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

(defun with-faicon (icon str &optional height v-adjust)
  "Displays an icon from Font Awesome icon."
  (s-concat
    (all-the-icons-faicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

(defun with-fileicon (icon str &optional height v-adjust)
  "Displays an icon from the Atom File Icons package."
  (s-concat
    (all-the-icons-fileicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))

(defun with-octicon (icon str &optional height v-adjust)
  "Displays an icon from the GitHub Octicons."
  (s-concat
    (all-the-icons-octicon icon :v-adjust (or v-adjust 0) :height (or height 1)) " " str))


(provide 'init-defun-icons)
;;; init-defun-icons.el ends here
