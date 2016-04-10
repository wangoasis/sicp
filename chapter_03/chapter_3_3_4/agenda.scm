;;; segment
( define ( make-time-segment time queue )
  ( cons time queue ) )

( define ( segment-time s ) ( car s ) )

( define ( segment-queue s ) ( cdr s ) )

;;; agenda 
( define ( make-agenda ) ( list 0 ) )

( define ( current-time agenda ) ( car agenda ) )

( define ( set-current-time! agenda time )
  ( set-car! agenda time ) )

( define ( segments agenda ) ( cdr agenda ) )

( define ( set-segments! agenda segments )
  ( set-cdr! agenda segments ) )

( define ( first-segment agenda ) ( car ( segments agenda ) ) )

( define ( rest-segments agenda ) ( cdr ( segments agenda ) ) )

( define ( empty-agenda? agenda ) ( null? ( segments agenda ) ) )

( define ( add-to-agenda! time action agenda )
  ;;; test whether the timestamp is early than all of the segments
  ( define ( belong-before? segments )
    ( or ( null? segments )
         ( < time ( segment-time ( car segments ) ) ) ) )
  ;;; make a new timestamp and its queue of action
  ( define ( make-new-time-segment time action )
    ( let ( ( q ( make-queue ) ) )
      ( insert-queue! q action )
      ( make-time-segment time q ) ) )
  ;;; add a action to segments 
  ( define ( add-to-segments! segments )
    ( if ( = ( segment-time ( car segments ) ) time )
         ;;; find exact timestamp, insert action to the queue
         ( insert-queue! ( segment-queue ( car segments ) ) action )
         ;;; search for exact timestamp
         ( let ( ( rest ( cdr segments ) ) )
           ( if ( belong-before? rest )
                ;;; early than rest
                ( set-cdr! segments ( cons ( make-new-time-segment time action ) ( cdr segments ) ) )
                ;;; not early than rest, search for exact timestamp
                ( add-to-segments! rest ) ) ) ) )
  ( let ( ( segments ( segments agenda ) ) )
    ( if ( belong-before? segments )
         ( set-segments! agenda ( cons ( make-new-time-segment time action ) segments ) )
         ( add-to-segments! segments ) ) ) )

( define ( remove-first-agenda-item! agenda )
  ( let ( ( q ( segment-queue ( first-segment agenda ) ) ) )
    ( delete-queue! q )
    ( if ( empty-queue? q )
         ( set-segments! agenda ( rest-segments agenda ) ) ) ) )

( define ( first-agenda-item agenda ) 
  ( if ( empty-agenda? agenda )
       ( error " agenda empty " )
       ( let ( ( first-seg ( first-segment agenda ) ) )
         ( set-current-time! agenda ( segment-time first-seg ) )
         ( front-queue ( segment-queue first-seg ) ) ) ) )
