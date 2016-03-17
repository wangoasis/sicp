( define ( same-parity x )
  ( define ( iter y res ) 
    ( cond ( ( null? y) res )
           ( else ( if ( even? ( abs ( - ( car y ) ( car res ) ) ) )
                       ( iter ( cdr y ) ( append res ( list ( car y ) ) ) )
                       ( iter ( cdr y ) res ) ) ) ) )
  ( iter ( cdr x ) ( list ( car x ) ) ) )

( define x ( list 1 2 3 4 5 6 7 ) )

( define y ( list 2 3 4 5 6 7 8 ) )
