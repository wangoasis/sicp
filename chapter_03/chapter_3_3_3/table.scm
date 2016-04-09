( define ( make-table )
  ( let ( ( local-table ( list '*table* ) ) )
    ( define ( insert! key-1 key-2 item )
      ( let ( ( subtable ( assoc key-1 ( cdr local-table ) ) ) )
        ( if subtable 
             ( let ( ( record ( assoc key-2 ( cdr subtable ) ) ) )
               ( if record 
                    ( set-cdr! record item )
                    ( set-cdr! subtable ( cons ( cons key-2 item )
                                               ( cdr  subtable ) ) ) ) )
             ( set-cdr! local-table 
                        ( cons ( list key-1 ( cons key-2 item ) )
                               ( cdr local-table ) ) ) ) )
      'ok )
    ( define ( lookup key-1 key-2 )
      ( let ( ( subtable ( assoc key-1 ( cdr local-table ) ) ) )
        ( if subtable 
             ( let ( ( record ( assoc key-2 ( cdr subtable ) ) ) )
               ( if record
                    ( cdr record )
                    false ) )
             false ) ) )
    ( define ( dispatch m )
      ( cond ( ( eq? m 'lookup-proc ) lookup )
             ( ( eq? m 'insert-proc! ) insert! ) 
             ( else ( error " no process " ) ) ) )
  dispatch ) ) 

( define table ( make-table ) )
( define get ( table 'lookup-proc ) )
( define put ( table 'insert-proc! ) )
