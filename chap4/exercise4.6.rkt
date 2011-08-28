
;(let ((var1 val1) (var2 val2) ...) body)
(define (let->lambda exp)
  (let ((vars (let-vars exp))
        (vals (let-vals exp))
        (body (let-body exp)))
    (cons (make-lambda vars body)
          vals)))

(define (let-vars exp)
  (let ((pairs (cadr exp)))
    (map car pairs)))

(define (let-vals exp)
  (let ((pairs (cadr exp)))
    (map cadr pairs)))

(define (let-body exp)
  (cddr exp))

(define (eval-let exp env)
  (eval (let->lambda exp) env))

(put 'let eval-let)