( define ( primes-sum a b ) ( filtered-accmulate + 
                                                 0
                                                 ( lambda (x) x )
                                                 a
                                                 ( lambda (x) (+ x 1) )
                                                 b
                                                 prime?
                                                 )
)

( define ( filtered-accmulate combiner null-value func a next b valid? )
   ( if ( > a b ) null-value 
        ( let ( ( rest-terms ( filtered-accmulate combiner
                                                null-value
                                                func
                                                ( next a )
                                                next 
                                                b 
                                                valid?
                                                 ) ) )
        ( if ( valid? a ) ( combiner ( func a ) rest-terms ) rest-terms ) ) 
) )

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
