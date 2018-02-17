(put 'erase-buffer     'disabled nil)
(put 'narrow-to-defun  'disabled nil)
(put 'narrow-to-page   'disabled nil)
(put 'narrow-to-region 'disabled nil)

(add-to-list 'auto-mode-alist '("\\.ly$" . LilyPond-mode))
(add-to-list 'auto-mode-alist '("\\.pentadactylrc$" . dactyl-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.offlineimaprc$" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.octaverc$" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.ftex$" . french-tex-mode))
(add-to-list 'auto-mode-alist '("bashrc$" . sh-mode))
(add-to-list 'auto-mode-alist '("network-security.data$" . emacs-lisp-mode))

(setq initial-scratch-message ""
      inhibit-startup-message t
      debug-on-error t
      backup-inhibited t
      markdown-coding-system 'utf-8
      markdown-content-type "text/html"
      auto-save-default nil
      column-number-mode t
      epa-file-cache-passphrase-for-symmetric-encryption t
      visible-bell 1 ; disable sound
      mouse-autoselect-window t
      browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox"
      vc-follow-symlinks t
      uniquify-buffer-name-style 'forward
      initial-buffer-choice (lambda () (other-buffer))
      shell-file-name "bash"
      x-select-enable-primary t
      custom-file "~/.emacs.d/conf/custom.el"
      pdf-misc-print-programm lpr-command
      ag-highlight-search t
      ;;irfc-assoc-mode t
      nsm-settings-file "~/.emacs.d/conf/network-security.data")

;; Display undo/redo as a graphical tree
(global-undo-tree-mode)
;; Refresh the document when git or another text editor modified it
(global-auto-revert-mode)
;; (pdf-tools-install)
;; RFC documents
;;(require 'irfc)

(add-hook 'after-make-frame-functions 'disable-scrollbars)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(add-hook 'prog-mode-hook 'fic-mode)
(add-hook 'prog-mode-hook '(lambda () (setq evil-symbol-word-search t)))
(add-hook 'prog-mode-hook '(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'prog-mode-hook '(lambda () (unless (string= major-mode "lua-mode")
                                        (modify-syntax-entry ?- "w"))))
