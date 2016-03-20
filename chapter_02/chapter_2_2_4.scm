( define ( make-leaf symbol weight )
  ( list 'leaf symbol weight ) )

( define ( leaf? object )
  ( eq? ( car object ) 'leaf ) )

( define ( symbol-leaf object ) ( cadr object ) )

( define ( weight-leaf object ) ( caddr object ) )

( define ( make-code-tree left right )
  ( list left right 
         ( append ( symbol left ) ( symbol right ) )
         ( + ( weight left ) ( weight right ) ) ) )

( define ( left-branch tree ) ( car tree ) )

( define ( right-branch tree ) ( cadr tree ) )

( define ( symbol tree ) 
  ( if ( leaf? tree ) ( list ( symbol-leaf tree ) )
       ( caddr tree ) ) )

( define ( weight tree ) 
  ( if ( leaf? tree ) ( weight-leaf tree )
       ( cadddr tree ) ) )

( define ( decode bits-list tree ) 
  ( define ( decode-1 bits current-branch )
    ( if ( null? bits ) '()
         ( let ( ( next-branch
                 ( choose-branch ( car bits ) current-branch ) ) )
           ( if ( leaf? next-branch ) 
                ( cons ( symbol-leaf next-branch ) 
                       ( decode-1 ( cdr bits ) tree ) )
                ( decode-1 ( cdr bits ) next-branch ) ) ) ) )
  ( decode-1 bits-list tree ) )

( define ( choose-branch bit branch ) 
  ( if ( = bit 0 ) ( left-branch branch ) 
       ( right-branch branch ) ) )

( define ( adjoin-set x set ) 
  ( cond ( ( null? set ) ( list x ) )
         ( ( < ( weight x ) ( weight ( car set ) ) ) ( cons x set ) )
         ( else ( cons ( car set )
                       ( adjoin-set x ( cdr set ) ) ) ) ) )

( define ( make-leaf-set pairs ) 
  ( if ( null? pairs ) '()
       ( let ( ( pair ( car pairs ) ) )
           ( adjoin-set ( make-leaf ( car pair ) ( cadr pair ) )
                        ( make-leaf-set ( cdr pairs ) ) ) ) ) )

( define tree 
  ( list ( list 'A 4 ) ( list 'B 2 ) ( list 'C 1 ) ( list 'D 1 ) ) )

;;; exercise 2.67
( define sample-tree 
  ( make-code-tree ( make-leaf 'A 4 )
                   ( make-code-tree 
                      ( make-leaf 'B 2 )
                      ( make-code-tree ( make-leaf 'D 1 ) 
                                       ( make-leaf 'C 1 ) ) ) ) )

( define sample-message (list  0 1 1 0 0 1 0 1 0 1 1 1 0 ) )

;;; exercise 2.68
( define ( encode message tree ) 
  ( if ( null? message ) '()
       ( append ( encode-symbol ( car message ) tree )
                ( encode ( cdr message ) tree ) ) ) )

( define ( encode-symbol letter tree ) 
  ( cond ( ( leaf? tree ) '() )
         ( ( symbol-in-tree? letter ( left-branch tree ) )
           ( cons 0 ( encode-symbol letter ( left-branch tree ) ) ) )
         ( ( symbol-in-tree? letter ( right-branch tree ) )
           ( cons 1 ( encode-symbol letter ( right-branch tree ) ) ) )
         ( else ( error " not in tree " ) ) ) )

( define ( symbol-in-tree? letter tree ) 
  ( define ( iter x symbol-list ) 
    ( cond ( ( null? symbol-list ) #f )
           ( ( eq? x ( car symbol-list ) ) #t )
           ( else ( iter x ( cdr symbol-list ) ) ) ) )
  ( iter letter ( symbol tree ) ) )

( define sample-code ( list 'A 'D 'A 'B 'B 'C 'A ) )

;;; exercise 2.69
( define sample-pairs '( ( A 4 ) ( B 2 ) ( C 1 ) ( D 1 ) ) )

( define ( generate-huffman-tree pairs )
  ( successive-merge ( make-leaf-set pairs ) ) )

( define ( successive-merge leaf-set ) 
  ( define ( iter set res ) 
    ( cond ( ( null? set ) res )
           ( else ( iter 
                  ( cdr set )
                  ( make-code-tree ( car set ) res ) ) ) ) ) 
  ( iter ( cddr leaf-set ) 
         ( make-code-tree ( car leaf-set ) ( cadr leaf-set ) ) ) ) 

( define main ( generate-huffman-tree sample-pairs ) )
