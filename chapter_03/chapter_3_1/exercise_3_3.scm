( define ( make-account balance password )
  
  ( define ( withdraw amount )
    ( if ( >= balance amount )
         ( begin ( set! balance ( - balance amount ) )
                 balance )
         " insuffient funds" ) )

  ( define ( deposit amount ) 
    ( begin ( set! balance ( + balance amount ) )
            balance ) )

  ( define ( password-match? try )
    ( eq? try password ) )

  ( define ( wrong-password arg )
    ( display " incorrect password " ) )

  ( define ( dispatch given-password mode )
    ( if ( password-match? given-password )
         ( cond ( ( eq? mode 'withdraw )
                  withdraw )
                ( ( eq? mode 'deposit )
                  deposit )
                ( else ( error " unknown mode " ) ) )
         ( wrong-password mode ) ) )

  dispatch )

( define main ( make-account 100 'aaa ) )
