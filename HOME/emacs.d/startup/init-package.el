;;; -*- lexical-binding: t; -*-
;;;
;;; init-package --- Configure the package system.


(require 'package)

(when (startup? 'with-internet)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t))

(unless (startup? 'with-internet) 
  (setq package-archives nil))

(package-initialize)


;; Bootstrap `use-package'.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; Make use-package available.
(require 'use-package)
(setq use-package-always-ensure t)


(when (startup? 'with-internet)
  ;; Download the ELPA archive description if needed.
  ;; This informs Emacs about the latest versions of all packages, and
  ;; makes them available for download.
  (when (not package-archive-contents)
    (package-refresh-contents)))


(provide 'init-package)
;;; init-package.el ends here
