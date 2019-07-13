;;; init-package --- Initialize the package system.
;;; Commentary:
;;; Code:

(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)


(package-initialize)


;; Bootstrap `use-package'.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; Make use-package available.
(require 'use-package)
(setq use-package-always-ensure t)


;; Download the ELPA archive description if needed. 
;; This informs Emacs about the latest versions of all packages, and 
;; makes them available for download. 
(when (not package-archive-contents)
   (package-refresh-contents))


(provide 'init-package)
;;; init-package.el ends here
