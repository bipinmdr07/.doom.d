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

(setq lsp-enable-file-watchers nil)

(setq auto-save-default t
      make-backup-files t)
(setq confirm-kill-emacs nil)
(setq type-break-mode t)

;; (setq company-idle-delay 0.1
;;       company-minimum-prefix-length 2)

;; (with-eval-after-load 'company
;;   (define-key company-active-map [tab] 'company-complete-selection)
;;   (define-key company-active-map (kbd "TAB") 'company-complete-selection))

(setq byte-complile-warning '(cl-functions))

(yas-global-mode 1)
(add-hook 'yas-minor-mode-hook (lambda ()
                                 (yas-activate-extra-mode 'fundamental-mode)))
(setq yas-triggers-in-field t)

(setq projectile-enable-caching nil)
(setq projectile-switch-project-action #'projectile-dired)

(add-hook 'git-commit-mode-hook 'add-branch-name-to-commit-message)
(add-hook 'js2-mode-hook 'yas-no-expand-in-comment/string)
;; (add-hook 'js2-mode-hook 'flyspell-prog-mode)

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
(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light)
      line-spacing 3)
;; doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; (setq doom-font (font-spec :family "Hack" :size 14 :slant 'italic))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'spacemacs-dark)
;; (setq doom-themes-treemacs-theme "doom-colors")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq deft-directory "~/Sync/org"
      deft-extensions '("org", "ledger")
      deft-recursive t)
(setq org-agenda-files '("~/Sync/org" "~/Sync/org/journal"))

(setq org-roam-directory "~/Sync/org/roam")
(org-roam-db-autosync-mode)

(setq org-journal-dir "~/Dropbox/org/journal")

(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-file-type 'daily
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")

(defvar org-journal--date-location-scheduled-time nil)

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

(setq evil-repeat-move-cursor 0.1)

;; dap-mode configuration
(setq dap-firefox-debug-program
      '("node" "/Users/leapfrog/.emacs.d/.extension/vscode/firefox-devtools/extension/dist/adapter.bundle.js"))

(setq dap-chrome-debug-program
      '("node" "/Users/leapfrog/.emacs.d/.extension/vscode/chrome-debug/extension/out/src/chromeDebug.js"))

(use-package ledger-mode
  :mode ("\\.dat\\'"
         "\\.ledger\\'")
  :custom (ledger-clear-whole-transactions t))

(use-package flycheck-ledger :after ledger-mode)

;; Copilot configuration;; accept completion from copilot and fallback to company
;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-TAB" . 'copilot-accept-completion-by-word)
;;               ("C-<tab>" . 'copilot-accept-completion-by-word)))


;; Number the candidates (use M-1, M-2 etc to select completions).
;; (setq company-show-quick-access t)

;; Org roam UI
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-oram ;; or :after org
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; org-mermaid
(setq ob-mermaid-cli-path "/Users/leapfrog/.nvm/versions/node/v20.10.0/bin/mmdc")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((mermaid . t)
   (scheme . t)))

;; (use-package! blamer
;;   :bind (("s-i" . blamer-show-commit-info))
;;   :defer 20
;;   :custom
;;   (blamer-idle-time 0.3)
;;   (blamer-min-offset 70)
;;   :custom-face
;;   (blamer-face ((t :foreground "#7a88cf"
;;                    :background nil
;;                    :height 140
;;                    :italic t)))
;;   :config
;;   (global-blamer-mode 1))
