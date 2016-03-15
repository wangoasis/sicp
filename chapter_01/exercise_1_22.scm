( define ( continue-prime n count ) 
  ( cond ( ( = count 0 ) ( display " are primes " ) )
         ( ( prime? n ) 
           ( display n )
           ( newline )
           ( continue-prime ( next-odd n )  ( - count 1 ) ) ) 
         ( else ( continue-prime ( next-odd n ) count ) ) ) ) 

( define ( next-odd n ) 
  ( if ( even? n ) ( + n 1 ) ( + n 2 ) ) )

( define ( timed-prime-test n ) 
  ( newline )
  ( display n )
  ( start-prime-test n ( runtime ) ) )

( define ( start-prime-test n start-time ) 
   ( if ( prime? n ) ( report-prime ( -  ( runtime ) start-time ) ) 
        ( report-not-prime n ) ) )

( define ( report-not-prime n ) 
  ( newline )
  ( display " not prime " ) )
  ( newline )

( define ( report-prime elapsed-time ) 
  ( display " *** " )
  ( display elapsed-time ) )
  ( newline )

( define ( smallest-advisor n ) ( find-advisor n 2 ) )

( define ( find-advisor n test-advisor ) 
  ( cond ( ( < n ( * test-advisor test-advisor) ) n  )
         ( ( divides? test-advisor n ) test-advisor )
         ( else ( find-advisor n ( next-advisor test-advisor ) ) )
  )
)

( define ( next-advisor m ) 
  ( if ( even? m ) ( + m 1 ) ( + m 2 ) )
)

( define ( divides? a b ) ( = 0 ( remainder b a ) ) )

( define ( prime? n ) ( = n ( smallest-advisor n ) ) )

( define ( runtime ) ( tms:clock ( times ) ) )
