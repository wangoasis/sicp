( define ( make-monitored f )
  ( let ( ( initial-count 0 ) )
    ( lambda ( input )
             ( cond ( ( eq? input 'how-many-calls? ) initial-count )
                    ( ( eq? input 'reset-count ) 
                      ( begin ( set! initial-count 0 )
                              initial-count ) )
                    ( else ( begin ( set! initial-count ( + 1 initial-count ) )
                                   ( f input ) ) ) ) ) ) )

( define main ( make-monitored sqrt ) )
