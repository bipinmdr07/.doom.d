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
