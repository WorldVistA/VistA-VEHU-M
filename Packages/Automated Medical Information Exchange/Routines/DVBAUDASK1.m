DVBAUDASK1  ;ALB/CP - UTL Reusable prompting subroutines #1 ; 10/11/18 8:08am
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;           ^DIR      ; IA #10006
 ;             ^DISV(  ; IA #  510
 Q
 ;
ASKLIST(DVBOUTPUT,DVBINPUT,DVBMAXNUM,DVBDEF) ; DVBPROMPT the user to 'Select NUMBER(S): '.
 ;
 N @($$DIR^DVBAUDNEW1())
 N DVBCODE,DVBNUM,DVBPCE,DVBVALUE
 ; ZEXCEPT: DIR,DVBQUIT,U,X,Y
 ;
 K DVBOUTPUT ; Refresh DVBOUTPUT array
 S DVBQUIT=0 ;. Initialize DVBOUTPUT status flag to successful
 ;
 S DIR(0)="LAO^1:"_DVBMAXNUM ;....... User may select list or range
 S DIR("A")="Select NUMBER(S): " ; Set text of DVBPROMPT
 I $G(DVBDEF)]"" S DIR("B")=DVBDEF ;.... Optionally set DVBPROMPT default DVBVALUE
 D ^DIR ;......................... DVBPROMPT user
 ;
 S DVBOUTPUT=X ;................... Return user's selection in DVBOUTPUT
 S DVBOUTPUT("DVBCNT")=DVBMAXNUM ;....... Number of choices in DVBPROMPT list
 I "^"[X SET DVBQUIT=1 Q  ;........ Set status to unsuccessful on '^'
 ;
 S DVBNUM=""
 F DVBPCE=1:1 S DVBNUM=$P(Y,",",DVBPCE) Q:'DVBNUM  D  ;
 . S DVBCODE=$P(DVBINPUT(DVBNUM),U,1),DVBVALUE=$P(DVBINPUT(DVBNUM),U,2)
 . S DVBOUTPUT(DVBCODE)=DVBVALUE
 ;
 I '$O(DVBOUTPUT(""))']"" SET DVBQUIT=1 Q  ; No choice made by user
 ;
 Q  ; ASKLIST
 ;
ASKNUM(DVBMAXNUM,DVBDEF,DVBPROMPT,DVBLINEFEED) ; Extrinsic to DVBPROMPT from 1 to DVBMAXNUM
 ;
 N DVBCNT,DVBRESPONSE
 ; ZEXCEPT: DTIME
 ;
 S DVBMAXNUM=$G(DVBMAXNUM) ; There is not a default maximum number set
 S DVBDEF=$G(DVBDEF) ; There is no default DVBRESPONSE to the DVBPROMPT, unless the default is passed.
 S DVBPROMPT=$G(DVBPROMPT,"Select NUMBER")
 S DVBPROMPT=DVBPROMPT_$S(DVBMAXNUM<2:": ",1:"(1-"_DVBMAXNUM_"): ")
 S DVBLINEFEED=$G(DVBLINEFEED,1)
 F DVBCNT=1:1:DVBLINEFEED W ! ; Issue number of linefeeds based on DVBLINEFEED variable
 ;
ASKNUM1  ; Return to this label upon receiving an incorrect DVBRESPONSE
 ;
 W DVBPROMPT I DVBDEF]"" W DVBDEF_"// "
 R DVBRESPONSE:DTIME I DVBRESPONSE="",DVBDEF="" S DVBRESPONSE="^"
 S:$T DVBRESPONSE="^"
 I DVBDEF]"",DVBRESPONSE="" S DVBRESPONSE=DVBDEF
 I "^"[DVBRESPONSE Q DVBRESPONSE
 I DVBRESPONSE'?1.20N!(DVBRESPONSE<1)!((DVBRESPONSE>DVBMAXNUM)&(DVBMAXNUM>1)) D  G ASKNUM1
 . Q:DVBMAXNUM'>1
 . I DVBMAXNUM>1 D  Q  ;
 . . W $C(7),"  Enter a number from 1 to "_$FN(DVBMAXNUM,",")_" or '^' to exit."
 . . W !
 . W $C(7),"  Enter a positive integer (1, 2, etc.); or '^' to exit.",!
 ;
 Q DVBRESPONSE ; ASKNUM
 ;
ASKPKG(DVBPROMPT) ; DVBPROMPT for 2-7 character Package NAMESPACE
 ;
 N DVBASCII,DVBPOS
 ;
ASKPKG1  ; Return to this label upon receiving an incorrect DVBRESPONSE
 ;
 S DVBQUIT=0 ; Initialize quit status flag to 0 (or do not quit)
 S DVBPROMPT=$G(DVBPROMPT,"Which 2-7 character Package NAMESPACE: ")
 ;
 W !!,DVBPROMPT
 ; If user times out or enters a '^' to exit, set DVBQUIT=1
 R DVBPKG:DTIME I '$T!("^"[DVBPKG) S DVBQUIT=1 Q
 ;
 F DVBPOS=1:1 Q:DVBPOS>$L(DVBPKG)!DVBQUIT  D  ;
 . I DVBPOS=1,"%ABCDEFGHIJKLMNOPQRSTUVWXYZ"'[$E(DVBPKG) D  Q
 . . S DVBQUIT=1 ; 1st character must be % or alphabetic
 . S DVBASCII=$A($E(DVBPKG,DVBPOS,DVBPOS)) ; DVBASCII character representation
 . I "0123456789"'[$E(DVBPKG,DVBPOS,DVBPOS),DVBASCII>96,DVBASCII<123 D  ;
 . . S DVBQUIT=1 ; Non-alphabetic or numeric char. found
 ;
 I DVBPKG["?"!(DVBPKG="")!($L(DVBPKG)<2)!($L(DVBPKG)>7) D  ;
 . S DVBQUIT=1 ; Namespace must be 2 to 7 characters
 ;
 I DVBQUIT D ERRMSG1,ERRMSG2 G ASKPKG1
 ;
 Q  ; ASKPKG
 ;
ASKYESNO(DVBPROMPT,DVBDEF) ; Extrinsic, DVBPROMPT for YES, NO DVBRESPONSE
 ;
 N @($$DIR^DVBAUDNEW1())
 ; ZEXCEPT: DIR,Y
 ;
 S DVBPROMPT=$G(DVBPROMPT) ; Default DVBRESPONSE to "NO" if not passed
 S DVBDEF=$G(DVBDEF,"NO")
 ;
 S (DIR("?"),DIR("??"))="Enter 'Y' (for YES), 'N' (for NO), or '^' (to exit)"
 S DIR(0)="Y",DIR("A")=DVBPROMPT
 I DVBDEF]"" S DIR("B")=DVBDEF
 ;
 D ^DIR
 ;
 I "^"[Y!(Y["^") Q "^"
 I Y=1 Q "Y"
 I Y=0 Q "N"
 ;
 Q "N" ; ASKYESNO
 ;
ERRMSG1  ; Package NAMESPACE requirements were NOT met.
 ;
 I DVBPKG'["?" W " ??"
 W !!?6,"Enter the first 2 to 7 characters of the Package NAMESPACE, or"
 W !?6,"enter an '^' to exit.",!
 W !?6,"The first character must be an alphabetic or % character, followed by"
 W !?6,"any alphanumeric combination, however, all alphabetic characters"
 W !?6,"must be in uppercase with no lowercase characters allowed."
 ;
 Q  ; ERRMSG1
 ;
ERRMSG2  ; <CAPS LOCK> key if not on.
 ;
 D CENTER^DVBAUDPRT1("Make sure your <CAPS LOCK> key is on.",2,IOM,1)
 ;
 Q  ; ERRMSG2
 ;
GETKEYWD(DVBMINLEN,DVBMAXLEN) ; DVBPROMPT for KEYWORD
 ;
 N DVBPOS,DVBKEYWRD
 ; ZEXCEPT: DTIME,IOM,DVBKEYWRD,DVBQUIT
 ;
 W !
GETKEY1  ; Return to this label upon receiving an incorrect DVBRESPONSE
 ;
 W !,"Select a KEYWORD (from "_DVBMINLEN_" to "_DVBMAXLEN_" characters): "
 S DVBQUIT=0 ; Do not quit when returning to the calling module
 ;
 R DVBKEYWRD:DTIME S:'$T DVBKEYWRD="^"
 I DVBKEYWRD="" S DVBQUIT=1 Q  ; No keyword found
 I DVBKEYWRD["^" S DVBQUIT=1 Q  ;User entered an '^'
 I $L(DVBKEYWRD)<DVBMINLEN!($L(DVBKEYWRD)>DVBMAXLEN) W " ??" G GETKEY1
 F DVBPOS=1:1:$L(DVBKEYWRD) D  I DVBQUIT G GETKEY1
 . ; Verify that the Keyword is in uppercase format.
 . I $A($E(DVBKEYWRD,DVBPOS,DVBPOS))>96,$A($E(DVBKEYWRD,DVBPOS,DVBPOS))<123 D  ;
 . . N DVBMSG
 . . S DVBMSG="Make sure <Caps Lock> key in on and re-enter your keyword"
 . . D CENTER^DVBAUDPRT1(DVBMSG,1,IOM,1)
 . . S DVBQUIT=1 ; Keyword entered is not all uppercase chars.
 ;
 Q  ; GETKEYWD
 ;
GETSORT(DVBRTN,DVBINPUT,DVBDEF) ; Get sorting criteria (generic subroutine call)
 ;
 N DVBCNT,DVBPOS,DVBRESPONSE,DVBSORT
 ;
 I $G(DVBDEF)>0,$D(DVBINPUT(DVBDEF)) S DVBDEF=DVBDEF ;Allows override of ^DISV global
 E  S DVBDEF=$G(^DISV(DUZ,DVBRTN,"DVBSORT"),1)
 S DVBQUIT=0 ; Do not quit when returning to the calling module
 ;
 W !
 W !,"Sort by"
 F DVBCNT=1:1 Q:'$D(DVBINPUT(DVBCNT))  D  ;
 . S DVBPOS=$S($L(DVBCNT)>9:$L(DVBCNT),1:2) ; Horizontal print position
 . W !?DVBPOS,$J(DVBCNT,2),") ",DVBINPUT(DVBCNT)
 S DVBCNT=DVBCNT-1
 ;
 S DVBRESPONSE=$$ASKNUM(DVBCNT,DVBDEF) I DVBRESPONSE="" S DVBRESPONSE=DVBDEF
 I DVBRESPONSE["^" S DVBQUIT=1 Q  ; User entered an '^'
 ;
 ;S DVBRTN=DVBRESPONSE
 S ^DISV(DUZ,DVBRTN,"DVBSORT")=DVBRESPONSE
 ;
 Q  ; GETSORT
 ;
USRLIMIT(DVBRTN) ; Include (active users, inactive users, or both active and
 ;
 N DVBDEF
 ;
 S DVBDEF=$G(^DISV(DUZ,DVBRTN,"DVBULIMIT"),1) ; Default DVBRESPONSE to DVBPROMPT
 ;
 W !
 W !,"Include"
 W !?4,"1) Both active and inactive users"
 W !?4,"2) Only active users"
 W !?4,"3) Only inactive users"
 ;
 S DVBULIMIT=$$ASKNUM(3,DVBDEF)
 I DVBULIMIT="^" SET DVBQUIT=1 Q  ; User entered an '^'
 ;
 S ^DISV(DUZ,DVBRTN,"DVBULIMIT")=DVBULIMIT
 S DVBQUIT=0 ; Do not quit when returning to the calling module
 ;
 Q  ; USRLIMIT
