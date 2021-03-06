(define (accumulate combiner start n term)
  (if (equal? n 1) (combiner (term n) start) (combiner (term n) (accumulate combiner start (- n 1) term)))
)

(define (accumulate-tail combiner start n term)
   (if (equal? n 0) start (accumulate-tail combiner (combiner start (term n)) (- n 1) term))
)

(define (partial-sums stream)
(define (helper num stream)
   (if (null? stream) nil (cons-stream (+ num (car stream)) (helper (+ num (car stream)) (cdr-stream stream))))
  )
  (helper 0 stream)
)

(define (rle s)
  (define (helper num stream)
      (cond ((null? stream) nil)
            ((null? (cdr-stream stream)) (cons-stream (list (car stream) num) nil))
            ((equal? (car stream) (car (cdr-stream stream))) (helper (+ num 1) (cdr-stream stream)))
            (else
              (cons-stream (list (car stream) num) (helper 1 (cdr-stream stream)))
            )
      )
    )
    (helper 1 s)
)
