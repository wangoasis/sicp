( load "initial.scm" )

( define main 
  ( begin ( half-adder input-1 input-2 sum carry ) 
          ( set-signal! input-1 1 ) 
          ( propagate ) ) )
