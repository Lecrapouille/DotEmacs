;; (bind-map leader-map
;;   :keys ("C-SPC"))

(global-set-key (kbd "<f4>") (lambda () (interactive) (shell-command "thunar ."))) ; replace thunar by nautilus for Ubuntu
(global-set-key (kbd "<C-space>") 'set-mark-command)
(global-set-key (kbd "<C-tab>") 'other-window)          ; Ctrl-Tab = Next buffer
(global-set-key (kbd "<C-left>") 'windmove-left)        ; move to left windnow
(global-set-key (kbd "<C-right>") 'windmove-right)      ; move to right window
(global-set-key (kbd "<C-up>") 'windmove-up)            ; move to upper window
(global-set-key (kbd "<C-down>") 'windmove-down)        ; move to lower window
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows) ; zygospore lets you revert C-x 1 (delete-other-window) by pressing C-x 1 again
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "<f1>") 'ggtags-find-tag-dwim)
(global-set-key (kbd "<f2>") 'ggtags-prev-mark)
(global-set-key (kbd "<f7>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))
(global-set-key (kbd "<f8>") 'gdb)
(global-set-key (kbd "<f11>") 'iedit-mode)
(global-set-key (kbd "<f12>") 'xah-search-current-word)
(global-set-key (kbd "C-z") 'undo-tree-visualize)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x g") 'magit-status)
;; (global-set-key (kbd "C-x C-f") 'ido-find-file)

;; (define-key pdf-view-mode-map (kbd "k") (int (message "kill-buffer disabled")))

(with-eval-after-load 'ag
  (define-key ag-mode-map (kbd "M-p") (function previous-error-no-select))
  (define-key ag-mode-map (kbd "M-n") (function next-error-no-select)))
