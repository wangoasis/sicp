( define ( cont-frac n d k ) 
  ( define ( cont-frac-iter count res ) 
    ( if ( = count k )
         res
         ( cont-frac-iter ( + count 1 ) ( / n ( + d res ) ) ) ) )
  ( cont-frac-iter 0 0 ) )

( define ( gold-calc k )
  ( cont-frac  1.0  1.0  k ) )
