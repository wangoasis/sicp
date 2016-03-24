( define ( install-scheme-number-package ) 
  ( define ( tag x ) ( attach-tag 'scheme-number x ) )
    ( put 'add '( scheme-number scheme-number ) 
          ( lambda ( x y )  ( tag ( + x y ) ) ) ) 
    ( put 'sub '( scheme-number scheme-number ) 
          ( lambda ( x y )  ( tag ( - x y ) ) ) ) 
    ( put 'mul '( scheme-number scheme-number ) 
          ( lambda ( x y )  ( tag ( * x y ) ) ) ) 
    ( put 'div '( scheme-number scheme-number ) 
          ( lambda ( x y )  ( tag ( / x y ) ) ) ) 
    ( put 'make 'scheme-number
          ( lambda ( x )  ( tag x ) ) )

    ;;; exercise 2.79, 2.80
    ( put 'equ? '( scheme-number scheme-number )
          ( lambda ( x y ) ( = x y ) ) )
    ( put '=zero? '( scheme-number )
          ( lambda ( x ) ( = x 0 ) ) )
  'done ) 

( define ( make-scheme-number n )
  ( ( get 'make 'scheme-number ) n ) )
