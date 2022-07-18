ISIIMPR2 ;ISI GROUP/MLS -- DATA LOADER RPC (2)
 ;;1.0;;;Jun 26,2012;Build 30
 ;
ALGMAKE(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input parameters+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 D
 . S ISIRC=$$ALGMISC^ISIIMPU6(.MISC,.ISIMISC) Q:ISIRC<0
 . I $G(ISIPARAM("DEBUG"))>0 D  
 . . W !,"++Read in values+++",!
 . . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . . Q
 . K MISC
 . S ISIRC=$$ALLERGY^ISIIMP10(.ISIRESUL,.ISIMISC)
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ;W !,"ERROR" Q
 Q
 ;
LABMAKE(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input parameters+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 D
 . S ISIRC=$$LABMISC^ISIIMPU7(.MISC,.ISIMISC) Q:ISIRC<0
 . I $G(ISIPARAM("DEBUG"))>0 D  
 . . W !,"++Read in values+++",!
 . . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . . Q
 . K MISC
 . S ISIRC=$$LAB^ISIIMP12(.ISIRESUL,.ISIMISC)
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ; W !,"ERROR" Q
 Q
 ;
NOTEMAKE(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input parameters+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 D
 . S ISIRC=$$NOTMISC^ISIIMPU8(.MISC,.ISIMISC) Q:ISIRC<0
 . I $G(ISIPARAM("DEBUG"))>0 D  
 . . W !,"++Read in values+++",!
 . . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . . Q
 . K MISC
 . S ISIRC=$$NOTES^ISIIMP14(.ISIRESUL,.ISIMISC)
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ;W !,"ERROR" Q
 Q
 ;
MEDMAKE(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input parameters+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 D
 . S ISIRC=$$MEDMISC^ISIIMPU9(.MISC,.ISIMISC) Q:ISIRC<0
 . I $G(ISIPARAM("DEBUG"))>0 D  
 . . W !,"++Read in values+++",!
 . . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . . Q
 . K MISC
 . S ISIRC=$$MEDS^ISIIMP16(.ISIRESUL,.ISIMISC)
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ;W !,"ERROR" Q
 Q
 ;
TABLEGET(ISIRESUL,TABLE)
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 K ARRAY S ISIRESUL(0)=0
 ;
 I $G(TABLE)="" S ISIRESUL(0)="-1^Incorrect parameter passed" Q
 S TABLE=$$PARAM^ISIIMPUA(TABLE)
 I TABLE=-1 S ISIRESUL(0)="-1^Incorrect parameter passed" Q
 ;
 D ENTRY^ISIIMPUA(.ISIRESUL,.TABLE)
 Q
 ;
CONMAKE(ISIRESUL,MISC)
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Raw input parameters+++",!
 . I $D(MISC) S X="" F  S X=$O(MISC(X)) Q:X=""  W !,$G(MISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 D
 . S ISIRC=$$CONMISC^ISIIMPUB(.MISC,.ISIMISC) Q:ISIRC<0
 . I $G(ISIPARAM("DEBUG"))>0 D  
 . . W !,"++Read in values+++",!
 . . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . . Q
 . K MISC
 . S ISIRC=$$CONSULTS^ISIIMP18(.ISIRESUL,.ISIMISC)
 . Q
 ;
 I +ISIRC<0 S ISIRESUL(0)=ISIRC ;W !,"ERROR" Q
 Q
 ;
ICD9GET(ISIRESUL,TXT)
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIIMPER"
 K ARRAY S ISIRESUL(0)=0
 I $G(TXT)="" S ISIRESUL(0)="-1^Incorrect parameter passed" Q
 S TXT=$$UP^XLFSTR(TXT)
 D ICD9^ISIIMPUA(.ISIRESUL,.TXT)
 Q
