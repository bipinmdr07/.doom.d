(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-key-sequence "jk")

(global-set-key (kbd "C-c L") 'sort-lines-by-length)

(defun add-d-to-ediff-mode-map ()
  (define-key ediff-mode-map "B" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)
