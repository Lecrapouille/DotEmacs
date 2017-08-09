;;
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'paren)
(show-paren-mode t)
(setq blink-matching-paren t)
(setq blink-matching-paren-on-screen t)
(setq show-paren-style 'expression)
(setq blink-matching-paren-dont-ignore-comments t)
(setq truncate-partial-width-windows t)
;; (set-face-background 'show-paren-match-face "#000099")
;; (set-face-attribute 'show-paren-match-face nil
;;      :weight 'bold
;;      :underline nil
;;      :overline nil
;;      :slant 'normal)
