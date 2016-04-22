( load "stream.scm" )

( define ( partial-sums stream )
  ( cons-stream ( stream-car stream )
      ( add-streams ( partial-sums stream ) ( stream-cdr stream ) ) ) )

( define sums ( partial-sums integers ) )

( define main ( stream-head sums 10 ) )
