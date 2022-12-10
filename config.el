;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(load! "+function")
(load! "+ui")
(load! "+prog")
(load! "+binding")

(setq user-full-name "Bipin Manandhar"
      user-mail-address "kubipin07@gmail.com")

(require 'dap-chrome)
(require 'livedown)

(setq auto-save-default t
      make-backup-files t)
(setq confirm-kill-emacs nil)

(setq company-idle-delay 0.2
      company-minimum-prefix-length 2)

(with-eval-after-load 'company
  (define-key company-active-map [tab] 'company-complete-selection)
  (define-key company-active-map (kbd "TAB") 'company-complete-selection))

(setq byte-complile-warning '(cl-functions))
(dap-mode 1)

;; (after! org
;;   (setq org-log-done t)
;;   (setq org-log-into-drawer t))

(yas-global-mode 1)
(add-hook 'yas-minor-mode-hook (lambda ()
                                 (yas-activate-extra-mode 'fundamental-mode)))
(setq yas-triggers-in-field t)

(setq deft-directory "~/Dropbox/org"
      deft-extensions '("org")
      deft-recursive t)

(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching nil)
(setq projectile-require-project-root t)
(setq projectile-switch-project-action #'projectile-dired)
(setq projectile-completion-system 'ido)

;; (autoload 'markdown-mode "markdown-mode" t)
;; (add-to-list 'auto-mode-alist
;;              '("\\.\\(?:md\\|markdown\\|mkd\\|mdown\\|mkdn\\|mdwn\\|mdx\\)\\'" . markdown-mode))

(add-hook 'git-commit-setup-hook 'add-branch-name-to-commit-message)
(add-hook 'js2-mode-hook 'yas-no-expand-in-comment/string)
(add-hook 'js2-mode-hook 'flyspell-prog-mode)

(add-hook 'js2-mode-hook
          #'(lambda ()
              (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
              (define-key js2-mode-map "@" 'js-doc-insert-tag)))


(setq magit-diff-refine-hunk 'all)

;; https://magit.vc/manual/forge.html
;; this issue may be helpful for forge pull request commit issue: https://github.com/magit/forge/issues/320#issuecomment-754812905
(setq auth-sources '("~/.authinfo.gpg"))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; (setq doom-font (font-spec :family "Hack" :size 14 :slant 'italic))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'spacemacs-dark)
;; (setq doom-themes-treemacs-theme "doom-colors")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package string-inflection)
(use-package lsp-dart
  :config
  (setq lsp-dart-flutter-sdk-dir "~/snap/flutter/common/flutter")
  (setq lsp-dart-sdk-dir "~/snap/flutter/common/flutter/bin/cache/dart-sdk"))


(use-package blamer
  :ensure t
  :defer 20
  :custom
  (blamer-idle-time 0.2)
  (blamer-min-offset 70)
  :config(global-blamer-mode 1)
  )
