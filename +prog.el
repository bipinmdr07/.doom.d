(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(setq exec-path (append exec-path '("~/.nvm/versions/node/v14.16.1/bin")))

(setq javascript-indent-level 2
      js-indent-level 2
      js2-indent-level 2
      js2-basic-offset 2
      web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2
      css-indent-offset 2)

(setq-hook! 'js2-mode-hook +format-with-lsp nil)

(add-hook! 'js2-mode-hook (modify-syntax-entry ?_ "w"))

(add-hook 'js2-mode-hook #'lsp)
(setq lsp-eldoc-render-all t)
