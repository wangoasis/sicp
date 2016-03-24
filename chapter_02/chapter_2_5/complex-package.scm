( load "complex-rectangular-package.scm" )
( load "complex-polar-package.scm" )

( define ( install-complex-package )
  ;; imported procedures from rectangular and polar packages
  ( define ( make-from-real-imag x y )
           ( ( get 'make-from-real-imag 'rectangular ) x y ) )
  ( define ( make-from-mag-ang r a )
           ( ( get 'make-from-mag-ang 'polar ) r a ) )
  ;; internal procedures
  ( define ( add-complex z1 z2 )
           ( make-from-real-imag (+ ( real-part-1 z1 ) ( real-part-1 z2 ) )
                                 (+ ( imag-part-1 z1 ) ( imag-part-1 z2 ) ) ) )
  ( define ( sub-complex z1 z2 )
           ( make-from-real-imag (- ( real-part-1 z1 ) ( real-part-1 z2 ) )
                                 (- ( imag-part-1 z1 ) ( imag-part-1 z2 ) ) ) )
  ( define ( mul-complex z1 z2 )
           ( make-from-mag-ang (* ( magnitude-1 z1 ) ( magnitude-1 z2 ) )
                               (+ ( angle-1 z1 ) ( angle-1 z2 ) ) ) )
  ( define ( div-complex z1 z2 )
           ( make-from-mag-ang (/ ( magnitude-1 z1 ) ( magnitude-1 z2 ) )
                               (- ( angle-1 z1 ) ( angle-1 z2 ) ) ) )

          ;; interface to rest of the system
  ( define ( tag z ) ( attach-tag 'complex z ) )
  ( put 'add '( complex complex )
        ( lambda ( z1 z2 ) ( tag ( add-complex z1 z2 ) ) ) )
  ( put 'sub '( complex complex )
        ( lambda ( z1 z2 ) ( tag ( sub-complex z1 z2 ) ) ) )
  ( put 'mul '( complex complex )
        ( lambda ( z1 z2 ) ( tag ( mul-complex z1 z2 ) ) ) )
  ( put 'div '( complex complex )
         ( lambda ( z1 z2 ) ( tag ( div-complex z1 z2 ) ) ) )
  ( put 'make-from-real-imag 'complex
         ( lambda ( x y ) ( tag ( make-from-real-imag x y ) ) ) )
  ( put 'make-from-mag-ang 'complex
         ( lambda ( r a ) ( tag ( make-from-mag-ang r a ) ) ) )

  ;;;exercise 2.77
  ( put 'real-part-1 '( complex ) real-part-1 )
  ( put 'imag-part-1 '( complex ) imag-part-1 )
  ( put 'magnitude-1 '( complex ) magnitude-1 )
  ( put 'angle-1 '( complex ) angle-1 )
  ( put 'equ '( complex complex )
        ( lambda ( x y ) ( and ( = ( real-part-1 x ) ( real-part-1 y ) )
                               ( = ( imag-part-1 x ) ( imag-part-1 y ) ) ) ) )
  'done )

( define ( make-complex-from-real-imag x y )
  ( ( get 'make-from-real-imag 'complex ) x y ) )

( define ( make-complex-from-mag-ang r a )
  ( ( get 'make-from-mag-ang 'complex ) r a ) )
