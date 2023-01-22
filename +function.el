;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;                 misc                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; sort the codes visually selected by length of code.
(defun sort-lines-by-length (reverse beg end)
  "Sort lines by length."
  (interactive "P\nr")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line` and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr reverse 'forward-line 'end-of-line nil nil
                   (lambda (l1 l2)
                     (apply #'< (mapcar (lambda (range) (- (cdr range) (car range)))
                                        (list l1 l2)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;                 GIT                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Accepting the both changes from the buffer A and B in ediff
(defun ediff-copy-both-to-C()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer )
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))

;; Add current branch name to commit.
(defun add-branch-name-to-commit-message()
  (insert (concat (magit-get-current-branch) ": ")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Prevent the yas snippet from expanding in the comment section ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun yas-no-expand-in-comment/string ()
  (setq yas-buffer-local-condition
        '(if (nth 8 (syntax-ppss)) ;; non-nil  if in as string or comment
             '(require-snippet-condition . force-in-comment)
           t)))

;; Auto clock in on changing the task status to inprogress;
(defun org-clock-todo-change ()
  (if (string= org-state "[-]")
      (org-clock-in)
    (org-clock-out-if-current)))

;; Convert comma separated string to js-docs params
(defun js-docs-params (str)
  (interactive)
  (if (equal (length str) 0)
      ""
    (concat "\n*\n"
            (string-join (mapcar(lambda(param)
                                  (concat "* @param {*} " param))
                                (remove-if (lambda(word)
                                             (equal (length word) 0))
                                           (mapcar (lambda(word)
                                                     (string-trim word))
                                                   (split-string str ","))))
                         "\n"))))

;; org-journal adding carryover tags from previous journal
;; Usage:
;; (setq org-journal-handle-old-carryover 'my-old-carryover)
(defun my-old-carryover (old_carryover)
  (save-excursion
    (let ((matcher (cdr (org-make-tags-matcher org-journal-carryover-items))))
      (dolist (entry (reverse old_carryover))
        (save-restriction
          (narrow-to-region (car entry) (cadr entry))
          (goto-char (point-min))
          (when (not (member ":carried:" (org-get-tags)))
            (org-scan-tags '(lambda ()
                              (org-set-tags ":carried:"))
                           matcher org--matcher-tags-todo-only)))))))

;; (defun my-filter-carryover-items (old-carryover)
;;   (let ((exclude-tags "carried"))
;;     (org-map-entries (lambda ()
;;                        (when (and (member exclude-tags (org-get-tags)) (not (org-get-todo-state)))
;;                          (setq old-carryover (delete (list (point) (point-at-eol)) old-carryover))))
;;                      ""
;;                      nil 'agenda)
;;     old-carryover))


(defun my-org-reschedule-carryover-tasks ()
  (save-excursion
    (goto-char (point-min))
    (let ((today (org-today))
          (matcher (cdr (org-make-tags-matcher org-journal-carryover-items))))
      (while (re-search-forward org-complex-heading-regexp nil t)
        (let ((state (org-get-todo-state)))
          (when (and (not (member state '("DONE" "CANCELED")))
                     (not (member ":carried:" (org-get-tags)))
                     (org-get-tags-at matcher))
            (let* ((scheduled-time (org-get-scheduled-time (point)))
                   (scheduled-date (time-to-days scheduled-time)))
              (when (< scheduled-date today)
                (org-schedule nil (org-read-date nil 'to-time))))))))))



;; org-journal: Configuring journal Capture template to integration org-journal with org-capture
;;
;; Usage:
;; (defvar org-journal--date-location-scheduled-time nil)
;;
;; (setq org-capture-templates '(("j" "Journal entry" plain (function org-journal-date-location)
;;                                "** TODO %?\n <%(princ org-journal--date-location-scheduled-time)>\n"
;;                                :jump-to-captured t))
(defun org-journal-date-location (&optional scheduled-time)
  (let ((scheduled-time (or scheduled-time (org-read-date nil nil nil "Date:"))))
    (setq org-journal--date-location-scheduled-time scheduled-time)
    (org-journal-new-entry t (org-time-string-to-time scheduled-time))
    (unless (eq org-journal-file-type 'daily)
      (org-narrow-to-subtree))
    (goto-char (point-max))))
