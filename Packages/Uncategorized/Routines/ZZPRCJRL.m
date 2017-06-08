ZZPRCJRL ;JAH,DGL/WCIOFO- ROUTINE CHECKSUM/PATCH LIST 1/14/99
 ;-Utility by Randy Luce based on another by John Heiges.
 ;==================================================================
MAIN ;This is the Main entry point for this Utility.
 N DIR,Y,CHOICE,X,RTNCNT,PRNTCNT
 K ^UTILITY($J)
 D MSSG
 D GETNAME
 D CHKPKG
 D CLEANUP
 W !!,?22,"Total number of routines:  ",RTNCNT
 W !!,"--------",!," Completed: " D ^%D W " " D ^%T
 W !
 Q
 ;===================================================================
 ;
GETNAME ;
 S UV=""
 F  R !!,"Please enter an identifying name for this UCI: ",UV Q:(UV]"")
 Q
 ;===================================================================
 ;
CHKPKG ;
 W !!
 K ^UTILITY($J)
 S XEC="ZL @X S Y=0 F %=1:1 S %1=$T(+%),%3=$F(%1,"" "")"
 S XEC=XEC_" Q:'%3  S %3=$L(%1) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y"
 S R="PRC" 
 I $D(^ROUTINE) F  S R=$O(^ROUTINE(R)) Q:'(R["PRC")  D SAVEROU
 I '$D(^ROUTINE) F  S R=$O(^$R(R)) Q:'(R["PRC")  D SAVEROU
 I $O(^UTILITY($J,0))']"" W !!,"NO SELECTED ROUTINES" Q
 D CHK2(.RTNCNT,.PRNTCNT)
 Q
SAVEROU I ($E(R,4)'="A"),($E(R,4)'="N") S ^UTILITY($J,R)=""
 Q
 ;===================================================================
 ;
CHK2(RCOUNT,PCOUNT) ;
 N UCI1,UCI2,SUM1,SUM2,PCH1,PCH2,TL
 S RCOUNT=0,PCOUNT=0
 ; Get and validate UCI and VOL for pre patch checksums.
PRE S X=" " F XU1=0:0 S X=$O(^UTILITY($J,X)) Q:X']""  D
 . I '$D(^$R(X)) Q
 . X XEC S SUM1=Y,PCH1=$$PATCHES(X) X ^%ZOSF("RSUM") S SUM2=Y
 . S RCOUNT=RCOUNT+1
 . W !,UV,"|",$J(X,8),"|",$J(SUM1,9),"|",$J(SUM2,9),"|",PCH1
 Q
 ;===================================================================
 ;
HEADER W !!!,"             REPORT OF ROUTINE COMPARISON"
 W !!,"     Routine name    "_UCI1_" Checksum",?40,"Patch List"
 W !,"                     "_UCI2_" Checksum",?40,"Patch List"
 W !,"     ---------------------------------------------------"
 Q
 ;===================================================================
 ;
ASKPRE(UCI) ; ASK FOR PRE PATCH UCI AND VOLUME SET.
 ;
 S UCI=0
 N PROMPT,DIR,UCIVOL
 S UCIVOL=""
 W !,"Enter Pre-patch UCI and Volume Set. "
 F PROMPT="UCI","VOL" Q:$D(DIRUT)  D
 .S DIR(0)="F^3:3"
 .S DIR("A")=PROMPT
 .D ^DIR
 .S UCIVOL=UCIVOL_Y
 .K DIR
 I '$D(DIRUT) S UCI=$E(UCIVOL,1,3)_","_$E(UCIVOL,4,6) Q 1
 Q 0
 ;===================================================================
CHKUCI(UCI) ;check whether UCI exisits
 ;
 I $G(UCI)="" Q 0
 I UCI["," S VOL=$P(UCI,",",2),UCI=$P(UCI,",")
 I $G(VOL)="" Q 0
 N X,$ETRAP S $ETRAP="G CHKUCIX^ZZPRSDGL"
 S X=$ZUCI(UCI,VOL)
 Q 1
 ;===================================================================
CHKUCIX ; error handler for CHKUCI
 S $ECODE=""
 Q 0
 ;===================================================================
RTNUCI() ; function returns current routine UCI
 N X1,X2
 S X1=$&ZLIB.%UCI()
 S X2=$P(X1,",",6)
 S X2=X2_","_$P(X1,",",7)
 Q X2
 ;===================================================================
PRECHK(RTN,UV,PRESUM,PRELST) ; GET PRE PATCH ROUTINE INTERNAL ENTRY NUMBER
 ;
 N X,Y,CURUCI
 ;
 ;Save current UCI,VOL
 ;
 S CURUCI=$$RTNUCI()
 ;
 I UV["," S VOL=$P(UV,",",2),UCI=$P(UV,",")
 E  S VOL=$G(UV)
 I $&ZLIB.%SETUCI(UCI,VOL,"R") D
 .  S X=RTN
 .  I '$D(^$R(X)) S PRESUM="New" Q
 .  X ^%ZOSF("RSUM") S PRESUM=Y
 .  S PRELST=$$PATCHES(X)
 ;
 ;Return to original UCI,VOL
 I CURUCI["," S VOL=$P(CURUCI,",",2),UCI=$P(CURUCI,",")
 E  S VOL=$G(CURUCI)
 Q:$&ZLIB.%SETUCI(UCI,VOL,"R")
 Q
 ;===================================================================
ASK(HOLD) ;ask user 2 continue function
 ;return true (1) if user want's 2 stop, false (0) 2 continue.
 ;If HOLD defined, use prompt 2 hold display until user hits return.
 ;If not terminal then, do nothing, return FALSE.
 ;
 S STOP=0
 I $E(IOST,1,2)="C-" D
 .;
 .N RESP,DIR S RESP=0
 .I $G(HOLD) S DIR(0)="EA",DIR("A")="Enter return to continue. "
 .E  S DIR(0)="E"
 .D ^DIR I Y="" S STOP=0
 .I $D(DIRUT) S STOP=1
 Q STOP
 ;=====================================================================
 ;
PATCHES(ROUTINE) ;
 ;GENERATE PATCH LIST
 ;
 S PATCHES=$T(@ROUTINE+1^@ROUTINE)
 S PATCHES=$P(PATCHES,";",5),PATCHES=$P(PATCHES,"**",2)
 Q PATCHES
CLEANUP ;
 K ^UTILITY($J),DIC,DIR,XCN,XTRNAME,XTRNCNT,XU1,XTSIZE,XTDT,DIE,XTRNEXT,XT,X,Y
 Q
SAMEUCI(UV) ;FUNCTION RETURNS TRUE IF PASSED UCI IS SAME AS CURRENT UCI.
 Q $$RTNUCI()=UV
MSSG ;display functionality info to user.
 F I=1:1 S X=$T(MSSGTXT+I) Q:'(X[";;")  W !,$P(X,";;",2)
 Q
 ;
MSSGTXT ;
 ;;This Utility finds and displays the routine name, comment,second line,
 ;;checksum, and patch list for all IFCAP routines in the current UCI 
reports discrepancies between 2 UCIs.
 ;;
 ;; The current UCI is used for current checksums and patch list.
 ;; You select the UCI to be compared.
 ;;
 Q
 ;
