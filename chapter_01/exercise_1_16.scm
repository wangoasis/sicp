( define ( expo b n )

  ( define ( expo-iter a product m ) 
    ( if ( = m 0 ) product
                   ( expo-iter a ( * a product ) ( - m 1 ) ) 
    )
  )
( cond ( ( even? n ) ( expo-iter ( * b b ) 1 ( / n 2 ) ) )
       ( else ( * b ( expo b ( - n 1 ) ) ) )
)
)
