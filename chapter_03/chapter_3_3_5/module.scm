;;; adder module
( define ( adder a1 m2 product )
  ( define ( process-new-value )
    ( cond ( ( and ( has-value? a1 ) ( has-value? m2 ) )
             ( set-value! product ( + ( get-value a1 ) ( get-value m2 ) )
                              me ) )
           ( ( and ( has-value? a1 ) ( has-value? product ) )
             ( set-value! m2 ( - ( get-value product ) ( get-value a1 ) )
                             me ) )
           ( ( and ( has-value? m2 ) ( has-value? product ) )
             ( set-value! a1 ( - ( get-value product ) ( get-value m2 ) ) me ) ) ) )
  ( define ( process-forget-value )
    ( forget-value! product me )
    ( forget-value! a1 me )
    ( forget-value! m2 me )
    ( process-new-value ) )
  ( define ( me request )
    ( cond ( ( eq? request 'I-have-a-value )
             ( process-new-value ) )
           ( ( eq? request 'I-lost-my-value )
             ( process-forget-value ) )
           ( else 
             ( error " unknown request " ) ) ) )
  ( connect a1 me )
  ( connect m2 me )
  ( connect product me ) 
  me )

;;; multiplier module
( define ( multiplier m1 m2 product )
  ( define ( process-new-value )
    ( cond ( ( or ( and ( has-value? m1 ) ( = ( get-value m1 ) 0 ) )
                ( and ( has-value? m2 ) ( = ( get-value m2 ) 0 ) ) )
             ( set-value! product 0 me ) )
           ( ( and ( has-value? m1 ) ( has-value? m2 ) )
             ( set-value! product ( * ( get-value m1 ) ( get-value m2 ) )
                              me ) )
           ( ( and ( has-value? m1 ) ( has-value? product ) )
             ( set-value! m2 ( / ( get-value product ) ( get-value m1 ) )
                             me ) )
           ( ( and ( has-value? m2 ) ( has-value? product ) )
             ( set-value! m1 ( / ( get-value product ) ( get-value m2 ) )
                             me ) ) ) )
  ( define ( process-forget-value )
    ( forget-value! product me )
    ( forget-value! m1 me )
    ( forget-value! m2 me )
    ( process-new-value ) )
  ( define ( me request )
    ( cond ( ( eq? request 'I-have-a-value )
             ( process-new-value ) )
           ( ( eq? request 'I-lost-my-value )
             ( process-forget-value ) )
           ( else 
             ( error " unknown request " ) ) ) )
  ( connect m1 me )
  ( connect m2 me )
  ( connect product me ) 
  me )

( define ( squarer a b )
  ( define ( process-new-value )
    ( cond ( ( has-value? b )
             ( set-value! a ( sqrt ( get-value b ) ) me ) )
           ( ( has-value? a )
             ( set-value! b ( * ( get-value a ) ( get-value a ) ) me ) ) ) )
  ( define ( process-forget-value )
    ( forget-value! b me )
    ( forget-value! a me )
    ( process-new-value ) )
  ( define ( me request )
    ( cond ( ( eq? request 'I-have-a-value )
             ( process-new-value ) )
           ( ( eq? request 'I-lost-my-value )
             ( process-forget-value ) )
           ( else 
             ( error " unknown request " ) ) ) )
  ( connect a me )
  ( connect b me ) 
  me )

;;; constant module
( define ( constant value connector )
  ( define ( me request )
    ( error " unknown request " ) )
  ( connect connector me )
  ( set-value! connector value me )
  me )

;;; module interface
( define ( inform-new-value constraint )
  ( constraint 'I-have-a-value ) )
( define ( inform-forget-value constraint )
  ( constraint 'I-lost-my-value ) )