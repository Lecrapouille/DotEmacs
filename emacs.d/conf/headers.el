(defun insert-current-date () (interactive)
    (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

(autoload 'auto-make-header "header2")
;;(add-hook 'c-mode-common-hook 'auto-make-header)

(add-hook 'find-file-hooks 'auto-insert)
(load-library "autoinsert")
