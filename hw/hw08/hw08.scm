(define (reverse lst)
  (if (null? lst) ()
  (if (null? (cdr lst)) (list (car lst))
    (append (reverse (cdr lst)) (list (car lst)))
  )
  )
)

(define (longest-increasing-subsequence lst)
    (define (find lst index)
      (if (= index 0) (car lst)
        (find (cdr lst) (- index 1))
      )
    )

    (define (slice lst index)
      (define (sliceit lst index new)
              (if (= index 0)
                new
                (sliceit (cdr lst) (- index 1) (append new (list (car lst))))
              )
            )
      (if (or (null? lst) (<= index 0))
        ()
        (if (< (length lst) index)
          lst
          (sliceit lst index ())
        )
      )
    )
    (define (longest lst values)
    (cond ((= (length values) 0) lst)
          ((= (length lst) 0) (longest (list (car values)) (cdr values)))
          ((< (find lst (- (length lst) 1)) (car values))
            (longest (append lst (list (car values))) (cdr values))
          )
          (else
            (if (> (length (longest (slice lst (- (length lst) 1)) values)) (length (longest lst (cdr values))) )
              (longest (slice lst (- (length lst) 1)) values)
              (longest lst (cdr values))

            )
        )
    )
  )
  (longest () lst)
)

(define (cadr s) (car (cdr s)))
(define (caddr s) (cadr (cdr s)))


; derive returns the derivative of EXPR with respect to VAR
(define (derive expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))
        ((sum? expr) (derive-sum expr var))
        ((product? expr) (derive-product expr var))
        ((exp? expr) (derive-exp expr var))
        (else 'Error)))

; Variables are represented as symbols
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

; Numbers are compared with =
(define (=number? expr num)
  (and (number? expr) (= expr num)))

; Sums are represented as lists that start with +.
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (sum? x)
  (and (list? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (caddr s))

; Products are represented as lists that start with *.
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
(define (product? x)
  (and (list? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplongest-increasing-subsequenceand p) (caddr p))

(define (derive-sum expr var)
  (make-sum (derive (cadr expr) var) (derive (caddr expr) var))
)

(define (derive-product expr var)
  (make-sum
    (make-product (derive (cadr expr) var) (caddr expr))
    (make-product (cadr expr) (derive (caddr expr) var))
  )
)

; Exponentiations are represented as lists that start with ^.
(define (make-exp base exponent)
  (cond ((and (number? base) (number? exponent)) (expt base exponent))
        ((=number? exponent 1) base)
        ((=number? exponent 0) 1)
        (else (list '^ base exponent))
        )

)

(define (base exp)
  (cadr exp)
)

(define (exponent exp)
  (caddr exp)
)

(define (exp? exp)
  (if (or (number? exp) (variable? exp)) #f
    (if (list? exp)
      (if (equal? (car exp) '^) #t #f)
    )
  )
)

(define x^2 (make-exp 'x 2))
(define x^3 (make-exp 'x 3))

(define (derive-exp exp var)
  (if (same-variable? (base exp) var) (make-product (exponent exp) (make-exp var (- (exponent exp) 1)))
  )
)
