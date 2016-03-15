( define ( fixed-point-of-transform g transform guess )
  ( fixed-point ( transform g ) guess ) )

;;; the root of x is the fixed point of 1/2*(y+x/y)
( define ( sqrt-1 x ) 
  ( fixed-point-of-transform ( lambda (y) ( / x y) )
    average-damp 1.0 ) )

;;; the root of x is the zero-point of y^2-x=0
;;; and to solve this equation, we can use newton transform
;;; the zero-point of a function is the fixed point of newton transformed function
( define ( sqrt-2 x ) 
  ( fixed-point-of-transform ( lambda (y) ( - ( * y y ) x ) )
    newton-transform 1.0 ) )

( define ( newton-transform g ) 
  ( lambda (x) ( - x ( / ( g x ) ( ( deriv g ) x ) ) ) ) )

;;; derivative of a function
( define dx 0.0001 )
( define ( deriv f ) ( lambda (x) (/ ( - ( f ( + x dx ) ) ( f x) ) dx ) ) )

( define ( average a b ) ( / ( + a b ) 2 ) )

( define ( average-damp f ) ( lambda (x) ( average x (f x) ) ) )

( define tolerance 0.0001 )

( define ( fixed-point func guess ) 
  ( define ( close-enough? a b ) 
           ( < ( abs ( - a b ) ) tolerance ) )
  ( define ( try-iter guess ) 
    ( if ( close-enough? guess ( func guess ) )
         guess
         ( try-iter ( func guess ) ) ) )
  ( try-iter 1.0 ) )
