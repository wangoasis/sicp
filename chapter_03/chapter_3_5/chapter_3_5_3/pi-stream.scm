( load "stream.scm" )
( load "partial-sums.scm" )
( load "euler-transform.scm" )

( define ( pi-summands n )
  ( cons-stream ( / 1.0 n )
    ( stream-map - ( pi-summands ( + n 2 ) ) ) ) )

( define pi-stream 
  ( scale-stream ( partial-sums ( pi-summands 1 ) ) 4 ) )

;;; evaluate pi using accelerated sequence
( define pi-stream-acc 
  ( accelerated-sequence euler-transform pi-stream ) )
