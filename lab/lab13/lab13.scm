; Lab 13: Final Review

; Q3
(define (compose-all funcs)
  (define (helper funcs num)
    (if (null? funcs) num (helper (cdr funcs) ((car funcs) num)))
  )
  (lambda (num) (helper funcs num))
)
