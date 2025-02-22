ISIIMPR1 ;ISI GROUP/MLS -- Import RPC
 ;;1.0;;;Jun 26,2012;Build 30
 Q
PNTIMPRT(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input params+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ; 
 D  
 . S ISIRC=$$PNTMISC^ISIIMPU1(.MISC,.ISIMISC) Q:ISIRC<0 
 . K MISC
 . S ISIRC=$$PATIENT^ISIIMP02(.ISIRESUL,.ISIMISC)
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ;W !,"ERROR"
 Q
 ;
APPMAKE(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input params+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ; 
 D  
 . S ISIRC=$$APPTMISC^ISIIMPU2(.MISC,.ISIMISC)  Q:ISIRC<0 
 . I $G(ISIPARAM("DEBUG"))>0 D  
 . . W !,"+++Read in values+++",!
 . . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . . W !,"<HIT RETURN TO PROCEED>" R X:5
 . . Q
 . K MISC
 . S ISIRC=$$APPOINT^ISIIMP04
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ;W !,"ERROR"
 Q
 ;
PROBMAKE(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input params (PR1)+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ; 
 D  
 . S ISIRC=$$PROBMISC^ISIIMPU4(.MISC,.ISIMISC)  Q:+ISIRC<0 
 . K MISC
 . S ISIRC=$$PROBLEM^ISIIMP06(.ISIRESUL,.ISIMISC)
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ; W !,"ERROR"
 Q
 ;
VITMAKE(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input params+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ; 
 D  
 . S ISIRC=$$VITMISC^ISIIMPU5(.MISC,.ISIMISC)  Q:ISIRC<0 
 . I $G(ISIPARAM("DEBUG"))>0 D  
 . . W !,"+++Read in values+++",!
 . . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . . W !,"<HIT RETURN TO PROCEED>" R X:5
 . . Q
 . K MISC
 . S ISIRC=$$VITALS^ISIIMP08(.ISIRESUL,.ISIMISC)
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ;W !,"ERROR"
 Q
 ;
RADOMAKE(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input params+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ; 
 D  
 . S ISIRC=$$RADMISC^ISIIMPUC(.MISC,.ISIMISC)  Q:ISIRC<0 
 . I $G(ISIPARAM("DEBUG"))>0 D  
 . . W !,"+++Read in values+++",!
 . . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . . W !,"<HIT RETURN TO PROCEED>" R X:5
 . . Q
 . K MISC
 . S ISIRC=$$RADORDER^ISIIMP20(.ISIRESUL,.ISIMISC)
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ;W !,"ERROR"
 Q
