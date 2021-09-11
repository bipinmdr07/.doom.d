(display-time-mode 1)
(setq doom-modeline-buffer-encoding t)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; (set-frame-parameter (selected-frame) 'alpha '(95 50))

;; (setq doom-font (font-spec :family "Hack" :size 14 :slant 'italic))
(setq doom-theme 'doom-one)

;;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
;; (doom-themes-neotree-config)
;; or for treemacs users
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;; (doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(setq display-line-numbers-type 'relative)
