;;; init.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(defun require-init (pkg &optional maybe-disabled)
  "Load PKG if `MAYBE-DISABLED' is nil or it's nil but start up in normal slowly."
  (when (not maybe-disabled)
    (load (file-truename (format "%s/%s" (concat (file-name-as-directory user-emacs-directory) "lisp") pkg)) t t)))
(font-lock-add-keywords 'emacs-lisp-mode '(("\\<require-init\\>" . font-lock-builtin-face)))

(defun add-subdirs-to-load-path (lisp-dir)
  "Add sub-directories under `LISP-DIR' into `load-path'."
  (let* ((default-directory lisp-dir))
    (setq load-path
          (append
           (delq nil
                 (mapcar (lambda (dir)
                           (unless (string-match "^\\." dir)
                             (expand-file-name dir)))
                         (directory-files lisp-dir)))
           load-path))))

;; @see https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;; Normally file-name-handler-alist is set to
;; (("\\`/[^/]*\\'" . tramp-completion-file-name-handler)
;; ("\\`/[^/|:][^/|]*:" . tramp-file-name-handler)
;; ("\\`/:" . file-name-non-special))
;; Which means on every .el and .elc file loaded during start up, it has to runs those regexps against the filename.
(let ((gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      (file-name-handler-alist nil))
  (require-init 'init-base)
  (require-init 'init-evil)
  (require-init 'init-ivy)
  (require-init 'init-tool)
  ;;(add-subdirs-to-load-path (file-name-as-directory (concat (file-name-as-directory user-emacs-directory) "site-lisp")))
  )

(run-with-idle-timer
 4 nil
 #'(lambda ()
     (setq gc-cons-threshold 67108864)
     (setq gc-cons-percentage 0.1)
     (garbage-collect)))

(message "[Emacs] Loaded in %s with %d garbage collections."
         (format "%.6f seconds" (float-time (time-subtract after-init-time before-init-time)))
         gcs-done)

(provide 'init)
;;; init.el ends here
