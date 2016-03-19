( define ( unique-triples n ) 
  ( flatmap 
    ( lambda (x) 
      ( map ( lambda (y) ( cons x y )) (unique-pairs ( - x 1 ) ) ) )
    ( enumerate-interval 1 n ) ) )

( define ( unique-pairs n )
  ( flatmap
    ( lambda ( x ) 
      ( map ( lambda ( y ) ( list x y ) )
        ( enumerate-interval 1 ( - x 1 ) ) ) ) 
    ( enumerate-interval 1 n ) ) ) 

( define ( select-three n sum ) 
  ( filter 
    ( lambda (x) ( = sum ( + ( car x ) ( cadr x ) ( caddr x ) ) ) )
    ( unique-triples n ) ) )

( define ( accumulate op initial sequence ) 
  ( if ( null? sequence ) initial 
    ( op ( car sequence )
         ( accumulate op initial ( cdr sequence ) ) ) ) )

( define ( flatmap proc seq )
  ( accumulate append '() ( map proc seq ) ) )

( define ( enumerate-interval low high ) 
  ( if ( > low high ) '() 
    ( cons low ( enumerate-interval ( + low 1 ) high ) ) ) ) 

( define x 8 )

( define main ( select-three x 10 ) )
