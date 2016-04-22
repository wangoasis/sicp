( define ( inverter input output )
  ( define ( invert-input )
    ( let ( ( new-value ( logical-not ( get-signal input ) ) ) )
      ( after-delay inverter-delay 
        ( lambda () ( set-signal! output new-value ) ) ) ) )
  ( add-action! input invert-input )
  'ok )

( define ( logical-not value )
  ( cond ( ( = value 0 ) 1 )
         ( ( = value 1 ) 0 ) 
         ( else ( error " not 0 or 1 " ) ) ) )

( define ( and-gate input-1 input-2 output )
  ( define ( and-action-procedure )
    ( let ( ( new-value ( logical-and ( get-signal input-1 )
                                      ( get-signal input-2 ) ) ) )
      ( after-delay and-gate-delay 
        ( lambda () ( set-signal! output new-value ) ) ) ) )
  ( add-action! input-1 and-action-procedure )
  ( add-action! input-2 and-action-procedure ) 
  'ok )

( define ( logical-and input-1 input-2 )
  ( cond ( ( and ( = input-1 1 ) ( = input-2 1 ) ) 1 )
         ( else 0 ) ) )

( define ( or-gate input-1 input-2 output )
  ( define ( or-action-procedure )
    ( let ( ( new-value ( logical-or ( get-signal input-1 )
                                      ( get-signal input-2 ) ) ) )
      ( after-delay or-gate-delay
        ( lambda () ( set-signal! output new-value ) ) ) ) )
  ( add-action! input-1 or-action-procedure )
  ( add-action! input-2 or-action-procedure ) 
  'ok )

( define ( logical-or input-1 input-2 )
  ( cond ( ( or ( = input-1 1 ) ( = input-2 1 ) ) 1 )
         ( else 0 ) ) )

( define ( half-adder a b s c )
  ( let ( ( d ( make-wire ) )
          ( e ( make-wire ) ) )
    ( or-gate a b d )
    ( and-gate a b c )
    ( inverter c e )
    ( and-gate d e s )
    'ok ) )

( define ( full-adder a b c-in sum c-out )
  ( let ( ( s ( make-wire ) )
          ( c1 ( make-wire ) )
          ( c2 ( make-wire ) ) )
    ( half-adder b c-in s c1 )
    ( half-adder a s sum c2 )
    ( or-gate c1 c2 c-out )
    'ok ) )