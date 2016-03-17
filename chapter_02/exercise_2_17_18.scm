( define x ( list 1 4 9 16 ) )

( define ( last-pair-1 x )
  ( cond ( ( null? x ) ( display "empty list" ) ) 
         ( ( null? ( cdr x ) ) ( car x ) )
         ( else ( last-pair-1 ( cdr x) ) ) ) )

( define ( length-1 x ) 
  ( cond ( ( null? x ) 0 )
         ( ( null? ( cdr x ) ) 1 )
         ( else ( + 1 ( length-1 ( cdr x ) ) ) ) ) )

( define ( list-ref-1 x n ) 
  ( if ( = n 0 ) ( car x )
       ( list-ref-1 ( cdr x ) ( - n 1 ) ) ) )

( define ( reverse-1 x ) 
  ( define ( reverse-iter x res )
    ( if ( null? x ) res 
      ( reverse-iter ( cdr x ) ( cons ( car x ) res ) ) ) )  
  ( reverse-iter x '() ) )

;;; recursive method, not correct because of '()
;;;( define ( reverse-2 x )
;;;  ( cond ( ( null? x ) nil )
;;;         ( ( null? ( cdr x ) ) x )
;;;         ( else ( cons ( reverse-2 ( cdr x ) ) ( car x ) ) ) ) )

( define ( cube x ) ( * x x x ) )

( define ( map-1 process x ) 
  ( if ( null? x ) nil 
    ( cons ( proc ( car x ) ) ( map-1 process ( cdr x ) ) ) ) )
