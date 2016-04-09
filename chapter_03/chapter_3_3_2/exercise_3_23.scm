( define ( make-queue ) ( cons '() '() ) )

( define ( empty-queue? queue ) ( null? ( front-member queue ) ) )

( define ( front-deque queue ) ( cadr ( front-member queue ) ) )

( define ( rear-deque  queue ) ( cadr ( rear-member queue ) ) )

( define ( front-member queue ) ( car queue ) )

( define ( rear-member queue ) ( cdr queue ) )

( define ( front-insert-queue! queue item )
  ( cond ( ( empty-queue? queue )
           ( let ( ( new-member ( cons '() ( cons item '() ) ) ) )
              ( set-car! queue new-member )
              ( set-cdr! queue new-member ) 
              ) )
         ( else 
           ( let ( ( new-member ( cons '() ( cons item '() ) ) ) )
              ( set-cdr! ( cdr new-member ) ( front-member queue ) )
              ( set-car! ( front-member queue ) new-member )
              ( set-car! queue new-member ) 
              ) ) ) )

( define ( rear-insert-queue! queue item )
  ( cond ( ( empty-queue? queue )
           ( let ( ( new-member ( cons '() ( cons item '() ) ) ) )
              ( set-car! queue new-member )
              ( set-cdr! queue new-member ) 
              ) )
         ( else 
           ( let ( ( new-member ( cons '() ( cons item '() ) ) ) )
             ( set-car! new-member ( rear-member queue ) )
             ( set-cdr! ( cdr ( rear-member queue ) ) new-member )
             ( set-cdr! queue new-member ) 
             ) ) ) )

( define ( front-delete-queue! queue )
  ( cond ( ( empty-queue? queue )
           ( error " empty queue, cannot delete members " ) )
         ( else 
           ( set-car! queue ( cddr ( front-member queue ) ) )
           ( set-car! ( front-member queue ) '() ) ) ) )

( define ( rear-delete-queue! queue )
  ( cond ( ( empty-queue? queue )
           ( error " empty queue, cannot delete members " ) )
         ( else 
           ( set-cdr! queue ( car ( rear-member queue ) ) )
           ( set-cdr! ( cdr ( rear-member queue ) ) '() ) ) ) )
