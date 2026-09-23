DVBAUDASK2  ;ALB/CP - UTL Reusable prompting subroutines #2 ; 10/26/18 10:02am
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this DVBROUTINE should not be modified6
 ;       $$GET1^DIQ      ;......IA # 2056
 ;         GETS^DIQ      ;......IA # 2056
 ;         $$UP^XLFSTR   ;......IA #10104
 ;             ^%ZOSF("RSEL") ; IA #10096
 ;             ^DIC(     ;..... IA #  821
 ;             ^DIC(4    ;..... IA #10090
 ;             ^DISV(    ;..... IA #  510
 Q
 ;
ENTRIES(DVBROUTINE,DVBFILENUM) ; DVBPROMPT for which for file entries to include
 ;
 N DVBDEFAULT,DIERR,DVBERRMSG,DVBFILENAME,DVBMAXIMUM
 S DVBQUIT=0
 ;
 S DVBDEFAULT=$G(^DISV(DUZ,$T(+0),"DVBENTRY"),1)
 I $G(DVBENTRY) S DVBDEFAULT="" ; No DVBDEFAULT when repeatedly executed
 S DVBFILENAME=$$GET1^DIQ(1,DVBFILENUM_",",.01) ;DVBFILENAME from ,01 of file 1
 I DVBFILENAME="" D  S DVBQUIT=1 Q
 . S DVBERRMSG="FILENAME for File #"_DVBFILENUM_" does not exist"
 . D CENTER^DVBAUDPRT1(DVBERRMSG,1,IOM,1)
 . D CONTINUE^DVBAUDPRT1(2,"R")
 ;
 S DVBMAXIMUM=3,DVBQUIT=0
 W !
 W !,"Which ",DVBFILENAME," file entries"
 W !?5,"1) Select a from-to entry range"
 W !?5,"2) All entries for a selected package"
 W !?5,"3) All entries"
 ;
 S DVBENTRY=$$ASKNUM^DVBAUDASK1(DVBMAXIMUM,DVBDEFAULT)
 I "^"[DVBENTRY S DVBQUIT=1 Q
 S ^DISV(DUZ,$T(+0),"DVBENTRY")=DVBENTRY
 ;
 K DVBENTRY
 Q  ; ENTRIES
 ;
FILERNG  ; DVBPROMPT for the beginning & ending file number range
 ;
 N DVBMSG
 ; ZEXCEPT: DTIME,DVBNUMBEG,DVBNUMEND,DVBQUIT
 S DVBQUIT=0
 S DVBMSG=" Enter the first number of the numeric number range."
 ;
NUMVALS1 ;
 N DVBNUMBEG,DVBNUMEND
 S (DVBNUMBEG,DVBNUMEND)="" ; Initialize from-to range to null.
 W !!,"Enter the range of numeric values"
NUMVALS2 ;
 S DVBMSG=" Enter the first number of the numeric number range."
 W !,"    Start with: " R DVBNUMBEG:DTIME
 I "^"[DVBNUMBEG S DVBQUIT=1 Q
 I DVBNUMBEG["?"!(DVBNUMBEG=" ") W !,DVBMSG  G NUMVALS2
 S DVBNUMBEG=$$UP^XLFSTR(DVBNUMBEG) ; Convert to uppercase format
NUMVALS3 ;
 W !,"      End with: " R DVBNUMEND:DTIME
 S DVBMSG=" Enter the last number of the numeric number range."
 I DVBNUMEND["?"!(DVBNUMBEG=" ") W !,DVBMSG G NUMVALS3
 I DVBNUMEND["^" S DVBQUIT=1 Q
 I DVBNUMEND="" G NUMVALS1
 S DVBNUMEND=$$UP^XLFSTR(DVBNUMEND) ; Convert to uppercase format
 ;
 I '$$FTVALSOK(DVBNUMBEG,DVBNUMEND)!$G(DVBQUIT) G NUMVALS1
 ;
 Q  ; FILERNG
 ;
FTVALS(DVBFILENAME) ; DVBPROMPT for the beginning & ending free text data
 ;
 N DVBMSG
 ; ZEXCEPT: DTIME,DVBFTBEG,DVBFTEND,DVBQUIT
 ;
 ; Validate the input FILENAME first.
 I '$O(^DIC("B",DVBFILENAME,0)) S DVBQUIT=1 G FTVALSX
 S DVBMSG=" Enter the complete or partial entry name from the "
 S DVBMSG=DVBMSG_DVBFILENAME_" file."
 S DVBQUIT=0
 ;
FTVALS1  ;
 S (DVBFTBEG,DVBFTEND)="" ; Initialize output values to null.
 W !!,"Enter the range of ",DVBFILENAME," values"
FTVALS2  ;
 W !,"    Start with: " R DVBFTBEG:DTIME
 I "^"[DVBFTBEG S DVBQUIT=1 G FTVALSX
 I DVBFTBEG["?"!(DVBFTBEG=" ") W !,DVBMSG  G FTVALS2
 S DVBFTBEG=$$UP^XLFSTR(DVBFTBEG) ; Convert to uppercase format
FTVALS3  ;
 W !,"      End with: " R DVBFTEND:DTIME
 I DVBFTEND["?"!(DVBFTBEG=" ") W !,DVBMSG G FTVALS3
 I DVBFTEND["^" S DVBQUIT=1 Q
 I DVBFTEND="" G FTVALS1
 S DVBFTEND=$$UP^XLFSTR(DVBFTEND) ; Convert to uppercase format
 ;
 I '$$FTVALSOK(DVBFTBEG,DVBFTEND)!$G(DVBQUIT)=1 G FTVALS1
 ;
FTVALSX  ; Exit FTVALS subroutine
 ;
 Q  ; FTVALS
 ;
FTVALSOK(DVB2FTBEG,DVB2FTEND) ; Extrinsic function to verify a from-to
 ;
 N DVBRETURN
 ; ZEXCEPT: DVBQUIT
 S DVBRETURN=1
 ;
 I DVB2FTBEG'>0!(DVB2FTEND'>0),DVB2FTBEG]DVB2FTEND D  ; Handles a free text range
 . I DVB2FTBEG,DVB2FTEND Q:$E(DVB2FTEND)>$E(DVB2FTBEG)  ; Quit if numeric end<beg
 . I DVB2FTBEG,DVB2FTEND,$L(DVB2FTEND)>$L(DVB2FTBEG) Q
 . W $C(7)
 . D CENTER^DVBAUDPRT1("Error:  'Start with' value follows 'End with' value",2,80,1)
 . S DVBRETURN=0,DVBQUIT=1
 ;
 I DVB2FTBEG>0!(DVB2FTEND>0),DVB2FTEND<DVB2FTBEG D  ; Handles a numeric range
 . W $C(7)
 . D CENTER^DVBAUDPRT1("Error:  'End with' value is less than 'Start with' value",2,80,1)
 . S DVBRETURN=0,DVBQUIT=1
 ;
 Q DVBRETURN ; Extrinsic $$FTVALSOK
 ;
RSEL     ; Routine selector with user message when no routine selected.
 ;
 N %JO,%R,%Y
 N DVBROUTINE,XRSEL
 ; ZEXCEPT: IOM,DVBQUIT
 ;
 S DVBQUIT=0
 K ^UTILITY($J) ; Start with a fresh ^UTILITY($J) global
 S XRSEL=$G(^%ZOSF("RSEL")) I XRSEL="" S DVBQUIT=1 Q
 X XRSEL
 S DVBROUTINE=$O(^UTILITY($J,"%")) ; % is the 1st valid DVBROUTINE name char
 I DVBROUTINE']"" D  ;
 . D CENTER^DVBAUDPRT1("No valid routines names were selected!",2,IOM,1)
 . D CONTINUE^DVBAUDPRT1(2,"R")
 . S DVBQUIT=1
 ;
 Q  ; RSEL
 ;
SITE200(DVBRTN,DVBSTANUM,DVBPROMPT) ; DVBPROMPT for 'Which INSTITUTION(S) "
 ;
 N DVBCNT,DVBDEF,DVBFIELDS,DVBIEN4,DVBIENS,DVBINARRAY,DVBMAX,DVBSITE,DVBSUFFIX
 ; ZEXCEPT: DIERR,DUZ,DVBQUIT,DVBSITE,U
 ;
 K DVBSITE ; Start with a fresh output array
 S DVBQUIT=0 ; DVBDEFAULT output quit flag to zero (don't quit)
 ;
 ; Quit if required DVBRTN parameter is missing.
 ;
 I $G(DVBRTN)="" S DVBQUIT=1 Q
 ;
 S DVBSTANUM=$G(DVBSTANUM,$$HOSTSITE^DVBAUDSTR1("SN")) ; STATION NUMBER #99
 S DVBPROMPT=$G(DVBPROMPT,"Which INSTITUTION(S): ")
 ;
 S DVBDEF=$G(^DISV(DUZ,DVBRTN,DVBSTANUM,"DVBSITE")) ; Set DVBPROMPT DVBDEFAULT
 ;
 S DVBIEN4=$O(^DIC(4,"D",DVBSTANUM,0)),DVBIENS=DVBIEN4_"," I DVBIEN4="" S DVBQUIT=1 Q
 ;
 ; NAME (#.01);STATUS (#11);STATION NUMBER (#99);INACTIVE FLAG (#101)
 S DVBFIELDS=".01;11;99;101"
 D GETS^DIQ(4,DVBIENS,DVBFIELDS,"ER","DVBSITE") I $G(DIERR) S DVBQUIT=1 Q
 S DVBQUIT=0 D SCRN200(.DVBSITE,DVBIENS) I DVBQUIT S DVBQUIT=1 Q
 S DVBCNT=1
 S $P(DVBPROMPT(DVBCNT),U,1)=DVBIEN4
 S $P(DVBPROMPT(DVBCNT),U,2)=DVBSITE(4,DVBIENS,"NAME","E")
 S $P(DVBPROMPT(DVBCNT),U,3)=$G(DVBSITE(4,DVBIENS,"STATION NUMBER","E"))
 ;
 ; For multi-station facilities, loop through all of the STATION
 ; NUMBER 'D' cross references to retrieve and display
 ; all of the various facilities with a STATION NUMBER DVBSUFFIX
 ; for possible input selection.
 ;
 S DVBSUFFIX=DVBSTANUM_" " ; Concatenate ' ' to avoid missing any suffixes
 F  S DVBSUFFIX=$O(^DIC(4,"D",DVBSUFFIX)) Q:$E(DVBSUFFIX,1,3)]DVBSTANUM!DVBQUIT  D  ;
 . S DVBIEN4=$O(^DIC(4,"D",DVBSUFFIX,0)) Q:'DVBIEN4  S DVBIENS=DVBIEN4_","
 . D GETS^DIQ(4,DVBIENS,DVBFIELDS,"ER","DVBSITE") I $G(DIERR) S DVBQUIT=1 Q
 . S DVBQUIT=0 D SCRN200(.DVBSITE,DVBIENS) I DVBQUIT S DVBQUIT=0 Q
 . I DVBSITE(4,DVBIENS,"INACTIVE FACILITY FLAG","E")'="" Q
 . S DVBCNT=DVBCNT+1
 . S $P(DVBPROMPT(DVBCNT),U,1)=DVBIEN4
 . S $P(DVBPROMPT(DVBCNT),U,2)=DVBSITE(4,DVBIENS,"NAME","E")
 . S $P(DVBPROMPT(DVBCNT),U,3)=DVBSITE(4,DVBIENS,"STATION NUMBER","E")
 ;
 S DVBMAX=DVBCNT ; DVBMAXIMUM number for input selection choices
 ;
 ; If no previous DVBDEFAULT found, set the DVBDEFAULT to 1-DVBMAX
 ; and also set the number of list choices in variable DVBSITE("DVBCNT")
 ;
 I DVBDEF="" S DVBDEF="1-"_DVBMAX ; First time DVBDEFAULT response of 1-DVBMAX
 S DVBSITE("DVBCNT")=DVBMAX ;.... Number active National Institutions
 ;
 W !!,DVBPROMPT,"   (Example 1,3 or 1-",DVBMAX,")"
 S DVBCNT=0
 F  S DVBCNT=$O(DVBPROMPT(DVBCNT)) Q:'DVBCNT  D  ;
 . W !?3,$J(DVBCNT,2),")  ",$P(DVBPROMPT(DVBCNT),U,2)
 . I $P(DVBPROMPT(DVBCNT),U,3)]"" W " (",$P(DVBPROMPT(DVBCNT),U,3),")"
 ;
 S DVBQUIT=0 D ASKLIST^DVBAUDASK1(.DVBSITE,.DVBPROMPT,DVBMAX,DVBDEF) Q:DVBQUIT
 ;
 ; Save the user's response which will become the future DVBDEFAULT
 ;
 S ^DISV(DUZ,DVBRTN,DVBSTANUM,"DVBSITE")=DVBSITE
 ;
 Q  ; SITE200
 ;
SCRN200(DVBSITE,DVBIENS) ;Screen site200 (Institution) entry, set DVBQUIT=1 to bypass
 ; Input:
 ;   DVBSITE ; Required ; Output of GETS^DIQ(4, of SITE200 entry point
 ;                     called by reference.
 ;   DVBIENS ; Required ; Internal entry number string for referencing
 ;                     an array from the output array element of
 ;                     GETS^DIQ of the GETSITE entry point.
 ;
 ; Output:
 ;   DVBQUIT ; 0 ; if entry is to be kept.
 ;            1 ; if entry is to be bypassed because it is not
 ;                a 'National' STATUS or the INACTIVE FACILITY
 ;                FLAG is set.
 ;
 ; Intended use:
 ;   Subroutine to support entry point SITE200 and is NOT supported
 ;   as an independent API entry point.
 ;
 ; Verify the Institution is a 'National' active 'VAMC'
 ; ZEXCEPT: DVBIENS,DVBQUIT,DVBSITE
 ;
 S DVBQUIT=0
 I DVBSITE(4,DVBIENS,"STATUS","E")'="National" S DVBQUIT=1 ; Node 0 piece 11
 I DVBSITE(4,DVBIENS,"INACTIVE FACILITY FLAG","E")'="" S DVBQUIT=1 ; Node 99 piece 4
 I DVBQUIT K DVBSITE(4,DVBIENS) ; Kills off array entry.
 ;
 Q  ; SCRN200
