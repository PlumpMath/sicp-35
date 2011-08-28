
;;; 利用练习4.3的结果，以数据导向的方式添加确实比较方便。
(define (eval-and exp env)
  (define (and-loop exps env)
    (if (null? exps)
        'true
        (if (eval (car exps) env)
            (and-loop (cdr exps) env)
            'false)))
  (and-loop (cdr exp) env))

(define (eval-or exp env)
  (define (or-loop exps env)
    (if (null? exps)
        'false
        (if (eval (car exps) env)
            'true
            (or-loop (cdr exps) env))))
  (or-loop (cdr exp) env))

;;;利用派生表达式的方式实现
(define (and->if exp)
  (define (expand-clauses clauses)
    (if (null? clauses)
        'true
        (let ((first (car clauses))
              (rest (cdr clauses)))
          (make-if first
                   (expand-clauses rest)
                   'false))))
  (expand-clauses (cdr exp)))
(define (eval-and exp env)
  (eval (and->if exp) env))

(define (or->if exp)
  (define (expand-clauses clauses)
    (if (null? clauses)
        'false
        (let ((first (car clauses))
              (rest (cdr clauses)))
          (make-if first
                   'true
                   (expand-clauses rest)))))
  (expand-clauses (cdr exp)))
(define (eval-or exp env)
  (eval (or->if exp) env))


(put 'and eval-and)
(put 'or eval-or)


;;;
;(load "F:\\编程语言\\sicp\\exercise\\chaterp4\\apply.rkt")
;(load "F:\\编程语言\\sicp\\exercise\\chapter4\\exercise4.4.rkt")
;(load "F:\\编程语言\\sicp\\exercise\\chapter4\\data_structure.rkt")
;(load "F:\\编程语言\\sicp\\exercise\\chapter4\\representation.rkt")

