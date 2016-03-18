( define x ( list ( list 1 2 ) ( list 3 4 ) ( list 5 6 7 ) ) )

( define ( fringe L ) 
  ( define ( fringe-iter x res ) 
    ( if ( null? x ) res
      ( fringe-iter ( cdr x ) 
        ( append res ( if ( pair? ( car x ) )
                        ( fringe ( car x ) )
                        ( list ( car x ) ) ) ) ) ) )
  ( fringe-iter L '() ) )
