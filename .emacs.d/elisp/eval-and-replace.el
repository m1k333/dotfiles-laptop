;; MSR 2015-04-27
;; Replace the preceding sexp with its value.
;; Adapted from elisp by Jorgen "forcer" Schafer

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(provide 'eval-and-replace)
