;; Colorize log files by a regexp

(defface clem-grey
  '((t  (:foreground  "grey"))) "dummy")

(defface clem-white
  '((t  (:foreground  "white"))) "dummy")

(defface clem-yellow-b
  '((t  (:foreground  "yellow" :weight bold))) "dummy")

(defface clem-green
  '((t  (:foreground  "green"))) "dummy")

(defface clem-chartreuse3
  '((t  (:foreground  "chartreuse3"))) "dummy")

(defun highlight-ulog ()
  (interactive)
  ;; (highlight-regexp ".* C .*" (quote hi-black-hb))
  (highlight-regexp ".*INFO.*" (quote clem-green))
  (highlight-regexp ".*DEBUG.*" (quote clem-white))
  (highlight-regexp ".*WARNI.*" (quote clem-yellow-b))
  (highlight-regexp ".*ERROR.*" (quote hi-red-b))
  (highlight-regexp ".*FATAL.*" (quote clem-grey))
  (highlight-regexp ".*clem:.*" (quote clem-chartreuse3)))

(defun ansi-color-apply ()
  (interactive)
  (save-restriction
    (when (evil-visual-state-p)
      (narrow-to-region evil-visual-beginning evil-visual-end))
    (ansi-color-apply-on-region (point-min) (point-max))))
