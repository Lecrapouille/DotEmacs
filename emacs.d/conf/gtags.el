(add-hook 'c-mode-common-hook 'ggtags-mode)

(setq ggtags-oversize-limit 0
      ggtags-update-on-save t)

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
