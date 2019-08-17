;; Par défaut, lors du reformatage du texte (M-q), Emacs ne respecte
;; pas les règles typographiques françaises qui veulent qu'un signe de
;; ponctuation double soit placé sur la même ligne que le mot qui le
;; précède, malgré l'espace (fine) qui le sépare de ce mot. Les
;; déclarations suivantes corrigent le problème. Merci à Matthieu Moy
;; pour la précieuse astuce (http://www-verimag.imag.fr/~moy/emacs/).
(defun my-fill-nobreak-predicate ()
  (save-match-data
    (or (looking-at "[ \t]*[])}»!?;:]")
        (looking-at "[ \t]*\\.\\.\\.")
        (save-excursion
          (skip-chars-backward " \t")
          (backward-char 1)
          (looking-at "[([{«]")
        ))))

(setq fill-nobreak-predicate 'my-fill-nobreak-predicate)

;; Prefer to split my C/C++ comments to 80 chars
(setq-default fill-column 80)
