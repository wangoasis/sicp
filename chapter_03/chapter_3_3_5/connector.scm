( define ( make-connector )
  ( let ( ( value false )
          ( informant false )
          ( constraints '() ) )
    ( define ( set-my-value new-value setter )
      ( cond ( ( not ( has-value? me ) )
               ( set! value new-value )
               ( set! informant setter )
               ( for-each-except setter
                                 inform-new-value
                                 constraints ) )
             ( ( not ( = value new-value ) )
               ( error " Contradiction, already has a value " ) )
             ( else 'ignored ) ) )
    ( define ( forget-my-value retractor )
      ( if ( eq? informant retractor )
           ( begin ( set! informant false )
                   ( for-each-except retractor
                                     inform-forget-value 
                                     constraints ) )
           'ignored ) )
    ( define ( connect new-constraint )
      ( if ( not ( memq new-constraint constraints ) )
           ( set! constraints
                  ( cons new-constraint constraints ) ) )
      ( if ( has-value? me )
           ( inform-new-value new-constraint ) ) 
      'done )
    ( define ( me request )
      ( cond ( ( eq? request 'has-value? )
               ( if informant true false ) )
             ( ( eq? request 'get-value )
               value ) 
             ( ( eq? request 'set-value! )
               set-my-value )
             ( ( eq? request 'forget-my-value )
               forget-my-value ) 
             ( ( eq? request 'connect )
               connect )
             ( else 
               ( error " unknown request " ) ) ) )
    me ) )
               
( define ( for-each-except exception procedure lists )
  ( define ( loop items )
    ( cond ( ( null? items ) 
             'done )
           ( ( eq? exception ( car items ) )
             ( loop ( cdr items ) ) )
           ( else 
             ( procedure ( car items ) )
             ( loop ( cdr items ) ) ) ) )
  ( loop lists ) )
      
;;; basic interface
( define ( has-value? connector )
  ( connector 'has-value? ) )

( define ( get-value connector )
  ( connector 'get-value ) )

( define ( set-value! connector new-value informant )
  ( ( connector 'set-value! ) new-value informant ) ) 

( define ( forget-value! connector retractor )
  ( ( connector 'forget-my-value ) retractor ) ) 

( define ( connect connector new-constraint )
  ( ( connector 'connect ) new-constraint ) ) 
