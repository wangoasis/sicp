( define ( queens board-size )
  ( define ( queen-cols k )
    ( if ( = k 0 ) ( list '() )
         ( filter 
           ( lambda (positions) ( safe? k positions) )
           ( flatmap 
             ( lambda (rest-of-queens)
               ( map ( lambda (new-row)
                       ( adjoin-position new-row k rest-of-queens ) )
                 ( enumerate-interval 1 board-size ) ) )
             ( queen-cols ( - k 1 ) ) ) 
          ) ) )
  ( queen-cols board-size ) )

( define ( safe? k positions ) 
  ( define ( same-row? new-queen pre-queens )
    ( cond ( ( null? pre-queens ) #f )
           ( ( = new-queen ( car pre-queens ) ) #t )
           ( else ( same-row? new-queen ( cdr pre-queens ) ) ) ) )
  ( define ( same-skew? new-queen pre-queens )
    ( define ( same-skew-iter new-queen queens i )
      ( cond ( ( null? queens ) #f )
             ( ( = i ( - new-queen ( car queens ) ) ) #t )
             ( else ( same-skew-iter new-queen ( cdr queens ) ( + i 1 ) ) ) ) )
    ( same-skew-iter new-queen pre-queens 1 ) )
  ( not ( or ( same-row? ( car positions ) ( cdr positions ) ) ( same-skew? ( car positions ) ( cdr positions ) ) ) ) )

( define ( safe? k positions ) 
  ( define ( safe-iter new-queen pre-queens i )
    ( cond ( ( null? pre-queens ) #t )
           ( ( = new-queen ( car pre-queens ) ) #f )
           ( ( = i ( abs ( - new-queen ( car pre-queens ) ) ) ) #f )
           ( else ( safe-iter new-queen ( cdr pre-queens ) ( + i 1 ) ) ) ) )
  ( safe-iter ( car positions ) ( cdr positions ) 1 ) ) 

( define ( adjoin-position new-row k rest-of-queens )
  ( cons new-row rest-of-queens ) )

( define ( accumulate op initial sequence ) 
  ( if ( null? sequence ) initial 
    ( op ( car sequence )
         ( accumulate op initial ( cdr sequence ) ) ) ) )

( define ( flatmap proc seq )
  ( accumulate append '() ( map proc seq ) ) )

( define ( enumerate-interval low high ) 
  ( if ( > low high ) '() 
    ( cons low ( enumerate-interval ( + low 1 ) high ) ) ) ) 

( define main ( queens 8 ) )
