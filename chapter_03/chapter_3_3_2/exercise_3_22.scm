( define ( make-queue )
  ( let ( ( front-ptr '() )
          ( rear-ptr  '() ) )
    ( define ( insert-queue! item )
      ( cond ( ( empty-queue? )
               ( set! front-ptr ( list item ) )
               ( set! rear-ptr  ( list item ) )
               front-ptr )
             ( else 
               ( set-cdr! rear-ptr ( list item ) )
               ( set! rear-ptr ( list item ) )
               front-ptr ) ) )
    ( define ( delete-queue! )
      ( cond ( ( empty-queue? )
               ( error " empty queue " ) )
             ( else
               ( set! front-ptr ( cdr front-ptr ) )
               front-ptr ) ) )
    ( define ( empty-queue? )
      ( null? front-ptr ) )
    ( define ( dispatch m )
      ( cond ( ( eq? m 'insert-queue! )
               insert-queue! )
             ( ( eq? m 'delete-queue! )
               ( delete-queue! ) )
             ( else 
               ( error " error process " ) ) ) )
    dispatch ) )