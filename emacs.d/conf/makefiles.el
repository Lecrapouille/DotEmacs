(setq auto-mode-alist (cons '("Makefile.mk$"  . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Makefile$"  . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Imakefile$"  . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("make.incl$"  . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Makefile.rules$"  . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Imake.incl$"  . makefile-mode) auto-mode-alist))

;; CMAKE
;;(cmake-ide-setup)

;; Look in the current directory the Makfile and if not found look in
;; parents directory
(setq compile-command
      '(let ((mf (locate-dominating-file default-directory "Makefile")))
         (if mf (setq mf (file-name-directory mf)))
         (concat (if (and mf (not (equal mf default-directory)))
                     (format "cd %s; "
                             (shell-quote-argument
                              (file-relative-name
                               (directory-file-name mf)))))
                 "make -j8 ")))

;; this hook must be put last, otherwise last line does not color well
;; ansi color
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(setq compilation-scroll-output t)
