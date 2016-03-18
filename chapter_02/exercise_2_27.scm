( define x ( list ( list 1 ( list 2 3 4 ) ) ( list 4 5 ) ( list 6 7 ) ) )

( define ( deep-reverse L ) 
  ( define ( deep-reverse-iter x res )
    ( if ( null? x ) res
      ( deep-reverse-iter ( cdr x ) 
        ( cons ( if ( pair? ( car x ) ) ( deep-reverse ( car x ) )
                                        ( car x ) )
               res ) ) ) )
  ( deep-reverse-iter L '() ) )
