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

( define ( make-from-mag-ang r a )
  ( ( get 'make-from-mag-ang 'polar ) r a ) )
