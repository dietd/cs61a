; Lab 13: Final Review - Optional Questions

; Q6
(define (nodots s)
  (cond ((null? s) nil)
      ((pair? (cdr s)) (list (car s) (nodots (cdr s))))
       ((pair? (car s)) (list (nodots (car s)) (nodots (cdr s))))

       ((pair? s) (list (car s) (cdr s)))
       (else s)
  )
)

; Q7
(define (has-cycle? s)
  (define (pair-tracker seen-so-far curr)
    (cond (_________________ ____________)
          (_________________ ____________)
          (else _________________________))
    )
  ______________________________
)

(define (contains? lst s)
  'YOUR-CODE-HERE
)

(define (has-cycle-constant s)
  'YOUR-CODE-HERE
)

; Q8
(define-macro (switch expr cases)
    'YOUR-CODE-HERE
)
