( define ( apply-generic op . args )
  ( let ( ( type-tags ( map type-tag args ) ) )
    ( let ( ( proc ( get op type-tags ) ) )
      ( if proc
           ( apply proc ( map contents args ) )
           ( error " no method " ( list op type-tags ) ) ) ) ) )

( define square ( lambda (x) (* x x) ) )

( define ( real-part-1 z ) ( apply-generic 'real-part-1 z ) )
( define ( imag-part-1 z ) ( apply-generic 'imag-part-1 z ) )
( define ( magnitude-1 z ) ( apply-generic 'magnitude-1 z ) ) 
( define ( angle-1     z ) ( apply-generic 'angle-1     z ) )

( define ( attach-tag type-tag contents )
  ( cons type-tag contents ) )

( define ( type-tag datum ) 
  ( if ( pair? datum ) ( car datum )
       ( error " bad tagged datum " ) ) )

( define ( contents datum ) 
  ( if ( pair? datum ) ( cdr datum )
       ( error " bad tagged datum " ) ) )
