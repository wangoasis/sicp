( define f 
  ( lambda ( x ) 
           ( set! f ( lambda ( x ) 0 ) )
           x ) )

( define a1 ( + ( f 0 ) ( f 1 ) ) )
( define a2 ( + ( f 1 ) ( f 0 ) ) )
