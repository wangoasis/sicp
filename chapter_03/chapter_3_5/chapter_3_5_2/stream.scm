( use-modules ( ice-9 syncase ) )

;;; basic definitions of stream
( define false #f )
( define true #t )
( define-syntax cons-stream
  ( syntax-rules ()
    ( ( _ x y ) ( cons x ( delay y ) ) ) ) )

( define ( stream-car stream )
  ( car stream ) )
( define ( stream-cdr stream )
  ( force ( cdr stream ) ) )
( define-syntax delay
  ( syntax-rules () 
  ( ( _ x ) ( memo-proc ( lambda () x ) ) ) ) )
( define ( force delayed-objects )
  ( delayed-objects ) )
( define ( memo-proc proc )
  ( let ( ( already-run? false )
          ( result false ) )
    ( lambda () 
      ( if ( not already-run? )
           ( begin ( set! already-run? true )
                   ( set! result ( proc ) )
                   result )
           result ) ) ) )

( define ( integers-starting-from n )
  ( cons-stream n ( integers-starting-from ( + n 1 ) ) ) )

( define integers
  ( integers-starting-from 1 ) )

( define ( add-streams s1 s2 )
  ( stream-map + s1 s2 ) )

( define ( stream-map proc . args )
  ( if ( null? ( car args ) )
       '()
       ( cons-stream 
         ( apply proc ( map 
                        ( lambda ( s ) ( stream-car s ) )
                        args ) )
         ( apply stream-map 
                 ( cons proc ( map
                               ( lambda ( s ) ( stream-cdr s ) ) ) ) ) ) ) )

( define ( add-streams s1 s2 )
  ( stream-map + s1 s2 ) )

( define ( divisible? x y )
  ( = 0 ( remainder x y ) ) )

( define ( stream-filter pred stream )
  ( if ( null? stream )
       '() 
       ( if ( pred ( stream-car stream ) )
            ( cons-stream ( stream-car stream )
                          ( stream-filter pred ( stream-cdr stream ) ) )
            ( stream-filter pred ( stream-cdr stream ) ) ) ) )

( define ( sieve stream )
  ( cons-stream 
    ( stream-car stream )
    ( sieve ( stream-filter 
              ( lambda ( x ) ( not ( divisible? x ( stream-car stream ) ) ) )
              ( stream-cdr stream ) ) ) ) )

( define primes ( sieve ( integers-starting-from 2 ) ) )

( define ( stream-ref stream index )
  ( if ( = 0 index )
       ( stream-car stream )
       ( stream-ref ( stream-cdr stream ) ( - index 1 ) ) ) )
