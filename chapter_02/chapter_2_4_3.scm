( define ( install-rectangular-package ) 
  ;;; internal procedures
  ( define ( make-from-real-imag x y )
    ( cons x y ) )
  ;;; add "-1" to avoid scheme internal real-part
  ( define ( real-part-1 z ) ( car z ) )
  ( define ( imag-part-1 z ) ( cdr z ) )
  ( define ( magnitude-1 z ) 
    ( sqrt ( + ( square ( real-part-1 z ) )
               ( square ( imag-part-1 z ) ) ) ) )
  ( define ( angle-1 z ) 
    ( atan ( imag-part-1 z ) ( real-part-1 z ) ) )
  ( define ( make-from-mag-ang r a ) 
    ( cons ( * r ( cos a ) ) ( * r ( sin a ) ) ) )

  ( define ( tag x ) ( attach-tag 'rectangular x ) )
  ( put 'real-part '( rectangular ) real-part-1 )
  ( put 'imag-part '( rectangular ) imag-part-1 )
  ( put 'magnitude '( rectangular ) magnitude-1 )
  ( put 'angle '(rectangular) angle-1 )
  ( put 'make-from-real-imag 'rectangular 
    ( lambda ( x y ) ( tag ( make-from-real-imag x y ) ) ) )
  ( put 'make-from-mag-ang 'rectangular 
    ( lambda ( r a ) ( tag ( make-from-mag-ang r a ) ) ) )
  'done )

( define ( install-polar-package ) 
  ;;; internal procedures
  ( define ( make-from-mag-ang r a )
    ( cons r a ) )
  ;;; add "-1" to avoid scheme internal real-part
  ( define ( real-part-1 z ) ( * ( magnitude-1 z ) ( cos ( angle-1 z ) ) ) )
  ( define ( imag-part-1 z ) ( * ( magnitude-1 z ) ( sin ( angle-1 z ) ) ) )
  ( define ( magnitude-1 z ) ( car z ) )
  ( define ( angle-1 z ) ( cdr z ) )
  ( define ( make-from-real-imag x y ) 
    ( cons ( sqrt ( + ( square x ) ( square y ) ) )
           ( atan y x ) ) )

  ( define ( tag x ) ( attach-tag 'polar x ) )
  ( put 'real-part '(polar) real-part-1 )
  ( put 'imag-part '(polar) imag-part-1 )
  ( put 'magnitude '(polar) magnitude-1 )
  ( put 'angle '(polar) angle-1 )
  ( put 'make-from-real-imag 'polar 
    ( lambda ( x y ) ( tag ( make-from-real-imag x y ) ) ) )
  ( put 'make-from-mag-ang 'polar 
    ( lambda ( r a ) ( tag ( make-from-mag-ang r a ) ) ) )
  'done )

;;; apply-generic method from book
( define ( apply-generic op . args )
  ( let ( ( type-tags ( map type-tag args ) ) )
    ( let ( ( proc ( get op type-tags ) ) )
      ( if proc
           ( apply proc ( map contents args ) )
           ( error " no method " ( list op type-tags ) ) ) ) ) )

;;; apply-generic method, process one argument
( define ( apply-generic-1 op arg )
    ( let ( ( proc ( get op ( list ( type-tag arg ) ) ) ) )
      ( if proc
           ( proc ( contents arg ) )
           ( error " no method " ( list op ( type-tag arg ) ) ) ) ) )

( define square ( lambda (x) (* x x) ) )

( define ( real-part-1 z ) ( apply-generic 'real-part z ) )
( define ( imag-part-1 z ) ( apply-generic 'imag-part z ) )
( define ( magnitude-1 z ) ( apply-generic 'magnitude z ) ) 
( define ( angle-1     z ) ( apply-generic 'angle     z ) )

( define ( real-part-2 z ) ( apply-generic-1 'real-part z ) )
( define ( imag-part-2 z ) ( apply-generic-1 'imag-part z ) )
( define ( magnitude-2 z ) ( apply-generic-1 'magnitude z ) ) 
( define ( angle-2     z ) ( apply-generic-1 'angle     z ) )

( define ( add-complex z1 z2 )
  (make-from-real-imag (+ (real-part-1 z1) (real-part-1 z2))
                       (+ (imag-part-1 z1) (imag-part-1 z2))) )
                         
(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part-1 z1) (real-part-1 z2))
                       (- (imag-part-1 z1) (imag-part-1 z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude-1 z1) (magnitude-1 z2))
                        (+ (angle-1 z1) (angle-1 z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude-1 z1) (magnitude-1 z2))
                        (- (angle-1 z1) (angle-1 z2)))) 

( define ( make-from-real-imag x y )
  ( ( get 'make-from-real-imag 'rectangular ) x y ) )
( define ( make-from-mag-ang r a )
  ( ( get 'make-from-mag-ang 'polar ) r a ) )

( define ( attach-tag type-tag contents )
  ( cons type-tag contents ) )
( define ( type-tag datum ) 
  ( if ( pair? datum ) ( car datum )
       ( error " bad tagged datum " ) ) )
( define ( contents datum ) 
  ( if ( pair? datum ) ( cdr datum )
       ( error " bad tagged datum " ) ) )

;;; code from chapter 3, table methods, put and get
( define false #f )
(define (assoc key records)
  (cond ((null? records) false)
          ((equal? key (caar records)) (car records))
                  (else (assoc key (cdr records)))))

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
                (cdr record)
                false))
          false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
            (if record
              (set-cdr! record value)
                (set-cdr! subtable
                  (cons (cons key-2 value)
                    (cdr subtable)))))
                      (set-cdr! local-table
                                (cons (list key-1
                                       (cons key-2 value))
                                       (cdr local-table)))))
     'ok)    
     (define (dispatch m)
       (cond ((eq? m 'lookup-proc) lookup)
         ((eq? m 'insert-proc!) insert!)
           (else (error "Unknown operation -- TABLE" m))))
             dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
