(defun xml-style ()
  (setq indent-tabs-mode nil)
  (set (make-local-variable 'whitespace-line-column) 1000)
  (whitespace-mode))

(setq whitespace-style '(face
                         trailing
                         lines-tail
                         space-before-tab
                         newline
                         indentation
                         empty
                         space-after-tab))

(add-hook 'nxml-mode-hook #'xml-style)
