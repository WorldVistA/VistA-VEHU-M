VECSG11
 ;;1
 ;VARIABLE LIST
 ;
 ;RECORD....CURRENT RECORD
 ;RECNR.....RECORD NUMBER OF CURRENT RECORD
 ;ADDR......FULL ADDRESS OF CURRENT RECORD
 ;ZIPCODE...ZIPCODE THAT USER WANTS TO SEARCH FOR
 ;ZIP.......ZIPCODE OF CURRENT RECORD
 ;ANS.......USER'S RESPONSE TO "PRESS ENTER TO RETURN TO THE MENU"
 ;
START ;
 R !!,"ENTER ZIP CODE: ",ZIPCODE:DTIME
 I '$T!(ZIPCODE["^") GOTO EXIT
 I ZIPCODE'?5N W !,"ZIPCODE MUST BE 5  DIGITS" G START
 F RECNR=1:1:NAMES(0) DO SEARCH
 G EXIT
SEARCH ;
 S RECORD=NAMES(RECNR)
 S ADDR=$P(RECORD,"^",3)
 S ZIP=$P(ADDR," ",2)
 I ZIP[ZIPCODE DO WRREC^VECSG7
 QUIT
EXIT ;
 R !!,"PRESS ENTER TO GO TO THE MENU",ANS:DTIME
 K ADDR,ZIPCODE,RECNR,RECORD,ANS
 Q
  
  
