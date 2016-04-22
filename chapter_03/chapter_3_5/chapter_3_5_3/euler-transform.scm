( define ( euler-transform s )
  ( let ( ( s0 ( stream-ref s 0 ) )
          ( s1 ( stream-ref s 1 ) )
          ( s2 ( stream-ref s 2 ) ) )
    ( cons-stream ( - s2 ( / ( square ( - s2 s1 ) )
                             ( + s0 ( * -2 s1 ) s2 ) ) )
                  ( euler-transform ( stream-cdr s ) ) ) ) )

( define square ( lambda ( x ) ( * x x ) ) )

( define ( make-tableau transform stream )
  ( cons-stream stream 
    ( make-tableau transform ( transform stream ) ) ) )

( define ( accelerated-sequence transform stream )
  ( stream-map 
    stream-car
    ( make-tableau transform stream ) ) )

