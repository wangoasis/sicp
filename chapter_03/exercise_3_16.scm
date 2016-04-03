( define ( count-pairs x ) 
  ( if ( not ( pair? x ) )
       0
       ( + ( count-pairs ( car x ) )
           ( count-pairs ( cdr x ) ) 
           1 ) ) )

;;; return 3
( define x1 ( cons ( cons 1 2 ) ( cons 1 2 ) ) )

;;; return 4
( define x2 ( cons ( cons 1 ( cons 2 3 ) ) ( cons 4 5 ) ) )

;;; return 7
( define x3 ( cons ( cons 1 ( cons 2 ( cons 3 4 ) ) )
                   ( cons 1 ( cons 2 ( cons 3 4 ) ) ) ) )
