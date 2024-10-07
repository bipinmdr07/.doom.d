(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; (setq exec-path (append exec-path '("~/.nvm/versions/node/v14.16.1/bin")))

(setq javascript-indent-level 2
      typescript-indent-level 2
      typescript-expr-indent-offset 2
      js-indent-level 2
      js2-indent-level 2
      js2-basic-offset 2
      web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2
      css-indent-offset 2)

(setq-hook! 'js2-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-mode-hook +format-with-lsp nil)

(add-hook! 'js2-mode-hook (modify-syntax-entry ?_ "w"))
(add-hook! 'typescript-mode-hook (modify-syntax-entry ?_ "w"))

;; (add-hook 'vue-mode-hook #'lsp)
(add-hook 'js2-mode-hook #'lsp)
(setq lsp-eldoc-render-all t)
;; (setq lsp-clients-typescript-max-ts-server-memory '512)

;; org-mode hook
(add-hook 'org-after-todo-state-change-hook
          'org-clock-todo-change)

(add-hook 'text-mode-hook #'type-break-mode)
(add-hook 'prog-mode-hook #'type-break-mode)
(setq type-break-interval (* 25 60))

;; bug-reference-mode
(defun jira-ticket-url ()
  (format
   "https://traytinc.atlassian.net/browse/%s-%s"
   (upcase (match-string 1))
   (match-string 3)))

(setq bug-reference-bug-regexp "\\b\\(AP\\|MBC\\|CPT\\)\\([-]\\)\\([0-9]+\\)\\b")
(setq bug-reference-url-format 'jira-ticket-url)
(add-hook 'prog-mode-hook #'bug-reference-prog-mode)
(add-hook 'text-mode-hook #'bug-reference-mode)
