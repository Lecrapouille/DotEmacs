(defun kill-buffer-maybe (buffer-name)
  (when (get-buffer buffer-name)
    (kill-buffer buffer-name)))

(defun woof-file ()
  (interactive)
  ;; because woof is asynchronous, we must loop until it matches
  (defun search-until (regexp)
    (when (null (re-search-forward regexp nil t))
      (sleep-for 0.1)
      (goto-char (point-min))
      (search-until regexp)))
  (let ((program-name "woof")
        (buffer-name "*woof*")
        (exec-name "woof"))
    (kill-buffer-maybe buffer-name)
    (start-process program-name buffer-name exec-name buffer-file-name)
    (with-current-buffer buffer-name
      (search-until "http://.*")
      (let ((link (match-string 0)))
        (message link)
        (kill-new (match-string 0))))))

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (file-exists-p (buffer-file-name))
                 (not (buffer-modified-p)))
        (revert-buffer t t t) )))
  (message "Refreshed open files."))

(defun my-telnet (host port)
  (interactive)
  (kill-buffer-maybe (concat "*telnet-" host ":" (int-to-string port) "*"))
  (telnet host port))

(defun epa-decrypt-armor-in-buffer ()
  (interactive)
  (epa-decrypt-armor-in-region (point-min) (point-max)))
