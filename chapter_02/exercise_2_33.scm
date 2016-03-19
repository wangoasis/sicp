( define x ( list 5 6 7 8 ) )

( define y ( list 1 2 3 4 ) )

( define ( accumulate op initial sequence )
  ( if  ( null? sequence ) initial 
         ( op ( car sequence )
              ( accumulate op initial ( cdr sequence ) ) ) ) )

( define ( map-1 proc sequence ) 
  ( accumulate
    ( lambda ( x y ) ( cons ( proc x ) y ) ) 
    '()
    sequence ) )

( define ( append-1 seq1 seq2 ) 
  ( accumulate cons seq2 seq1 ) )

( define ( length-1 sequence )
  ( accumulate ( lambda ( x y ) ( + 1 y ) ) 
               0
               sequence ) )

( define square ( lambda (x) ( * x x ) ) )
