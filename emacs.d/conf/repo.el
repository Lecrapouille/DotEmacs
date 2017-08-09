(defun repo-forward-line ()
  (interactive)
  (when (re-search-forward "\nproject " nil t)
    (beginning-of-line)))

(defun repo-backward-line ()
  (interactive)
  (when (re-search-backward "^project " nil t)
    (beginning-of-line)))

(with-eval-after-load 'repo
  (define-key repo-mode-map (kbd "p") (function repo-backward-line))
  (define-key repo-mode-map (kbd "n") (function repo-forward-line)))
