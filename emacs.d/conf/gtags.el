(add-hook 'c-mode-common-hook 'ggtags-mode)

(setq ggtags-highlight-tag nil)

(setq ggtags-oversize-limit 0
      ggtags-update-on-save t)





(defun gtags-root-dir ()
    "Returns GTAGS root directory or nil if doesn't exist."
    (with-temp-buffer
      (if (zerop (call-process "global" nil t nil "-pr"))
          (buffer-substring (point-min) (1- (point-max)))
        nil)))

  (defun gtags-update ()
    "Make GTAGS incremental update"
    (call-process "global" nil nil nil "-u"))


 (defun gtags-update-single(filename)  
      "Update Gtags database for changes in a single file"
      (interactive)
      (start-process "update-gtags" "update-gtags" "bash" "-c" (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))


(defun gtags-update-current-file()
      (interactive)
      (defvar filename)
      (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
      (gtags-update-single filename)
      (message "Gtags updated for %s" filename))


 (defun gtags-update-hook()
      "Update GTAGS file incrementally upon saving a file"
      (when gtags-mode
        (when (gtags-root-dir)
          (gtags-update-current-file))))

(defun create-android-gtags ()
  (interactive)
  (message "updating Android gtags")
  (let ((command
         (s-join " "
                 '("cd /media/qquadrat/EspaceLibre/android_8 &&"
                   "rm -f GPATH GRTAGS GTAGS &&"
                   "find . -type f -name \"*.[ch]pp\" -o -name \"*.[ch]\" -o -name \"*.inc\" "
                   "| gtags -f - &&"
                   "emacsclient --eval"
                   "'(message \"Android gtags updated\")'"))))
    (start-process-shell-command "gtags" "gtags" command)))







(defun update-simtadyn-gtags ()
  (interactive)
  (message "updating SimTaDyn gtags")
  (let ((command
         (s-join " "
                 '("cd ~/SimTaDyn/src &&"
                   "rm -f GPATH GRTAGS GTAGS &&"
                   "find . -name \"*.[ch]pp\""
                   "| gtags -f - &&"
                   "emacsclient --eval"
                   "'(message \"SimTaDyn gtags updated\")'"))))
    (start-process-shell-command "gtags" "gtags" command)))

(defun generic-find-tag ()
  (interactive)
  (call-interactively
   (cond ((bound-and-true-p ggtags-mode) 'ggtags-find-tag-dwim)
         ((string= major-mode "scheme-mode") 'geiser-edit-symbol-at-point)
         ((string= major-mode "emacs-lisp-mode") 'find-function)
         (t (error "wrong mode")))))

(defun generic-find-library ()
  (interactive)
  (call-interactively
   (cond ((bound-and-true-p ggtags-mode) 'ggtags-find-file)
         ((string= major-mode "scheme-mode") 'geiser-edit-module-at-point)
         ((string= major-mode "emacs-lisp-mode") 'find-library)
         (t (error "wrong mode")))))

(defun generic-pop-stack ()
  (interactive)
  (call-interactively
   (cond ((bound-and-true-p ggtags-mode) 'ggtags-prev-mark)
         ((string= major-mode "scheme-mode") 'geiser-pop-symbol-stack)
         (t (error "wrong mode")))))
