(evil-mode)

(bind-map leader-map
  :evil-keys ("SPC")
  :evil-states (normal motion visual))

(defmacro int (&rest body)
  `(lambda () (interactive) ,@body))

(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))

(add-hook 'edebug-mode-hook 'evil-normalize-keymaps)
(add-hook 'nhexl-mode-hook 'evil-emacs-state)

(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'picture-mode 'emacs)
(evil-set-initial-state 'xkcd-mode 'emacs)
(evil-set-initial-state 'undo-tree-visualizer-mode 'emacs)
(evil-set-initial-state 'ggtags-global-mode 'emacs)
(evil-set-initial-state 'Man-mode 'emacs)
(evil-set-initial-state 'repo-mode 'emacs)
(evil-set-initial-state 'gerrit-mode 'emacs)
(evil-set-initial-state 'pdir-mode 'emacs)
(evil-set-initial-state 'pass-mode 'emacs)
(evil-set-initial-state 'jabber-roster-mode 'emacs)
(evil-set-initial-state 'lsgit-mode 'emacs)
(evil-set-initial-state 'geiser-debug-mode 'emacs)
(evil-set-initial-state 'debbugs-gnu-mode 'emacs)
(evil-set-initial-state 'Info-mode 'emacs)

(my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(my-move-key evil-motion-state-map evil-normal-state-map " ")

(bind-map-set-keys leader-map
  "a" 'ggtags-navigation-mode-abort
  "b" 'alchemy-popup
  "c" 'cleanup-dwim
  "d" (int (ansi-term "/bin/bash"))
  "e" 'eshell
  "f" 'ag-dired
  "g" 'magit-status
  "i" (int (my-telnet "localhost" 5222))
  "j" 'make-cursors-column
  "k" 'kill-path-link
  "l" 'generic-find-library
  "m" 'mu4e
  "n" 'ggtags-next-mark
  "o" 'repo-status
  "p" 'generic-pop-stack
  "r" 'ag
  "s" 'shell
  "t" 'generic-find-tag
  "u" 'undo-tree-visualize
  "x" 'guix
  ";" 'comment-or-uncomment-region
  "/" 'make-cursors-search-ring
  "<SPC>" 'rename-buffer
  "2" 'org-popup
  "3" 'gerrit-popup
  "4" 'auto-popup
  "9" 'paredit-splice-sexp-killing-backward
  "0" 'paredit-splice-sexp-killing-forward)
