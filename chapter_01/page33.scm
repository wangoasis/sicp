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
