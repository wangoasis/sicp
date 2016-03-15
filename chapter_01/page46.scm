( define tolerance 0.0001 )

( define ( fixed-point func first-guess ) 
  ( define ( close-enough a b ) 
    ( < ( abs( - a b ) ) tolerance ) )
  ( define ( try guess ) 
    ( let ( ( next ( func guess ) ) )
    ( if ( close-enough guess next ) 
         next
         ( try next ) ) ) )
  ( try first-guess ) 
  )

( define ( average a b ) ( / ( + a b ) 2 ) )

( define ( _sqrt x ) 
  ( fixed-point ( lambda (y) ( average y ( / x y ) ) ) 1.0 ) )
