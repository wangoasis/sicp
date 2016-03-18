( define x ( list ( list 1 2 ) ( list 3 ( list 4 5 ) ) ( list 6 7 ) ) )

( define ( square-tree L )
  ( cond ( ( null? L ) '() )
         ( ( not ( pair? L ) ) ( * L L ) )
         ( else ( cons ( square-tree ( car L ) ) 
                       ( square-tree ( cdr L ) ) ) ) ) )

( define ( square-tree-map L )
  ( map ( lambda ( x ) ( if ( pair? x ) 
                            ( square-tree-map x )
                            ( * x x ) ) ) 
    L ) )

( define square ( lambda (x) ( * x x ) ) )

( define cube ( lambda (x) ( * x x x ) ) )

( define ( tree-map proc tree ) 
  ( cond ( ( null? tree ) '() )
         ( ( not ( pair? tree ) ) ( proc tree ) )
         ( else ( cons ( tree-map proc ( car tree ) )
                       ( tree-map proc ( cdr tree ) ) ) ) ) )

( define ( square-tree-3 L ) ( tree-map square L ) )
