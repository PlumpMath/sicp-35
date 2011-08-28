(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (if (cond-=>-clause? first)
                (make-if (cond-predicate first)
                         (list (sequence->exp (cond-=>-actions first))
                               (cond-predicate first))
                         (expand-clauses rest))
                (make-if (cond-predicate first)
                         (sequence->exp (cond-actions first))
                         (expand-clauses rest)))))))
(define (cond-=>-clause? clause)
  (eq? (cadr clause) '=>))
(define (cond-=>-actions clause)
  (cddr clause))
                
     
