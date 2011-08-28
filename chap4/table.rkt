(define (make-table)
  (let ((local-table (list '*table*)))
    (define (assoc key records)
      (cond ((null? records) nil)
            ((equal? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    (define (lookup key)
      (assoc key (cdr local-table)))
    (define (insert! key value)
      (let ((record (assoc key (cdr local-table))))
        (if (not (null? record))
            (set-cdr! record value)
            (set-cdr! local-table 
                      (cons (cons key value) 
                            (cdr local-table))))))
    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
            ((eq? m 'insert!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define (table-get table symbol)
  ((table 'lookup) symbol))

(define (table-put! table symbol value)
  ((table 'insert!) symbol value))

(define (binding-value binding)
  (cdr binding))
      
      
    
  
      
  
  
  