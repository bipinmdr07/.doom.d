(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-key-sequence "jk")

(global-set-key (kbd "C-c L") 'sort-lines-by-length)
(global-set-key (kbd "C-c c") 'cfw:open-org-calendar)

(defun add-d-to-ediff-mode-map ()
  (define-key ediff-mode-map "B" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)

;; keybinding for org-calfw
;; | key | function                                                               |
;; |-----+------------------------------------------------------------------------|
;; | g   | Refresh data and re-draw contents (cfw:refresh-calendar-buffer)        |
;; | j   | Goto the specified date (cfw:org-goto-date)                            |
;; | k   | org-capture                                                            |
;; | x   | Close calfw and other buffers opened by calfw-org (cfw:org-clean-exit) |
;; | d   | Day view (cfw:change-view-day)                                         |
;; | v d | Day view (cfw:change-view-day)                                         |
;; | v w | 1 Week view (cfw:change-view-week)                                     |
;; | v m | Month View (cfw:change-view-month)                                     |
;; (setq cfw:org-overwrite-default-keybinding t)
