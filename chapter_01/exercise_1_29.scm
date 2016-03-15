( define ( sum func a next b ) 
  ( if ( > a b ) 0
       ( + ( func a ) ( sum func ( next a ) next b ) ) ) )

( define ( cube x ) ( * x x x ) )

( define ( add-by-1 x ) ( + x 1 ) )

( define ( add-dx a dx ) ( + a dx ) ) 

( define ( pre-num count n ) 
  ( cond ( ( = count 0 ) 1 )
         ( ( = count n ) 1 )
         ( ( odd? count ) 4 )
         ( ( even? count ) 2 )
         )
)

( define ( integral-iter func a b res n count dx ) 
  ( cond ( ( = count n ) res ) 
         ( else ( + ( * ( pre-num count n ) ( func a ) ) 
                    ( integral-iter func ( add-dx a dx ) b res n ( + count 1 ) dx ) ) )
  ) 
)

( define ( integral func a b n )
  ( * ( / ( / ( - b a ) n ) 3.0 )  
  ( integral-iter func a b 0 n 0 ( / ( - b a ) n ) ) ) )
