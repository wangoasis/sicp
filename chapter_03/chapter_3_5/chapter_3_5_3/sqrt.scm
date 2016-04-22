( load "stream.scm" )

( define ( sqrt-improve guess x )
  ( / ( + ( / x guess ) guess ) 2 ) )

( define ( sqrt-stream x )
  ( define guesses
    ( cons-stream 1.0
      ( stream-map 
        ( lambda ( guess ) ( sqrt-improve guess x ) )
        guesses ) ) )
  guesses )

