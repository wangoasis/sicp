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
  ( put 'real-part-1 '( rectangular ) real-part-1 )
  ( put 'imag-part-1 '( rectangular ) imag-part-1 )
  ( put 'magnitude-1 '( rectangular ) magnitude-1 )
  ( put 'angle-1 '(rectangular) angle-1 )
  ( put 'make-from-real-imag 'rectangular 
    ( lambda ( x y ) ( tag ( make-from-real-imag x y ) ) ) )
  ( put 'make-from-mag-ang 'rectangular 
    ( lambda ( r a ) ( tag ( make-from-mag-ang r a ) ) ) )
  'done )

( define ( make-from-real-imag x y )
  ( ( get 'make-from-real-imag 'rectangular ) x y ) )
