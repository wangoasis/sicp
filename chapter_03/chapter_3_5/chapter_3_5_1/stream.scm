( define false #f )
( define true #t ) 

( define ( stream-cons a b )
  ( cons a ( delay b ) ) )

( define ( stream-car s ) ( car s ) )
( define ( stream-cdr s ) ( force ( cdr s ) ) )

( define ( stream-enumerate-interval low high )
  ( if ( > low high )
       '()
       ( stream-cons 
         low 
         ( stream-enumerate-interval ( + low 1 ) high ) ) ) )

( define ( stream-ref s n )
  ( if ( = n 0 )
       ( car s )
       ( stream-ref ( stream-cdr s ) ( - n 1 ) ) ) )

( define ( stream-map proc s )
  ( if ( null? s )
       '()
       ( stream-cons 
         ( proc ( stream-car s ) )
         ( stream-map proc ( stream-cdr s ) ) ) ) )

( define ( stream-for-each proc s )
  ( if ( null? s )
       'done
       ( begin ( proc ( stream-car s ) )
               ( stream-for-each proc ( stream-cdr s ) ) ) ) )

( define ( memo-proc proc )
  ( let ( ( run-already false ) 
          ( result false ) )
    ( lambda ()
      ( if ( not run-already )
           ( begin ( set! result ( proc ) )
                   ( set! run-already true )
                   result )
           result ) ) ) )

( define ( stream-filter pred s ) 
  ( cond ( ( null? s ) '() )
         ( ( pred ( stream-car s ) )
           ( stream-cons ( stream-car s )
                         ( stream-filter pred ( stream-cdr s ) ) ) )
         ( else 
           ( stream-filter pred ( stream-cdr s ) ) ) ) )

( define ( delay proc )
  ( memo-proc ( lambda () proc ) ) )
( define ( force delay-project )
  ( delay-project ) )
