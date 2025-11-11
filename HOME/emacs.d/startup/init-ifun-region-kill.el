;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-region-kill --- interactive funs for region kill


(defun region-kill-line (start &optional end)
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (kill-region start end)
    (kill-line)))


(defun region-kill-whole-line (start &optional end)
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (kill-region beg end)
    (kill-whole-line)))


(defun region-kill-to-left-margin (start &optional end)
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (kill-region start end)
    (kill-region (line-beginning-position) start)))


(defun region-delete-back-word (start &optional end)
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (delete-region start end)
    (backward-kill-word 1)))


(defun kill-inner-region (ch)
  (interactive (prompt-char-from-smart-region t))
  (change-inner* nil ch))


(defun kill-outer-region (ch)
  (interactive (prompt-char-from-smart-region t))
  (change-outer* nil ch))


(defun delete-ws-right (start end)
  "Delete all spaces and tabs from point to next non-white char."
  (interactive (prompt-region-ws-right))
  (delete-region start end))


(defun delete-ws-left (start end)
  "Delete all spaces and tabs from the previous non-white char to point."
  (interactive (prompt-region-ws-left))
  (delete-region start end))


(defun delete-char-kill-region (start &optional end)
  "Delete backwards a char or if a region is selected, kill the rgion"
  (interactive (prompt-region-or-point))
  (if (use-region-p)
    (kill-region start end)
    (backward-delete-char-untabify 1)))


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


(provide 'init-ifun-region-kill)
;;; init-ifun-region-kill.el ends here
