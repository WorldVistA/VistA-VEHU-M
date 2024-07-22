IBCNOR3 ;AITC/DTG - IBCN EDI PAYER ID REPT ;10/18/23
 ;;2.0;INTEGRATED BILLING;**778**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to EN^XUTMDEVQ in ICR #1519
 ;
 Q
 ;
EN ; entry point
 ;
 N DIR,IBAR,IBCK,IBCNT,IBI,IBID,IBOK,IBOUT,IBSTOP,IBXSAV,POP,X,Y
 K ^TMP("IBCNOR3",$J) S ^TMP("IBCNOR3",$J,0)=""
 W:$G(IOF)'="" @IOF W:$G(IOF)="" !
 W !,"This report allows the user to identify Insurance Companies with a specific",!,"EDI Payer ID."
 ; get edi number
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
ENRK ; come here if continue from ^ response
 K ^TMP("IBCNOR3",$J) S ^TMP("IBCNOR3",$J,0)=""
ENR ; ask question return point. 
 W !
 S IBCNT=0
 S DIR(0)="F^1:30"
 S DIR("A")="Please Enter an EDI Payer ID"
 S DIR("?",1)="Enter an EDI Payer ID (Includes: PROFESSIONAL, INSTITUTIONAL, and/or"
 S DIR("?")="DENTAL Number) from 1 to 30 characters or '^' to quit."
 S IBOK=0
ENAQ ;
 D ^DIR
 I $E(Y,1)=" " S IBOK=0 D  I 'IBOK S Y="" W !,"This is a required response. Enter '^' to exit" G ENAQ
 . F IBI=1:1:$L(Y) I $E(Y,IBI)'=" " S IBOK=1 Q
 I $E(Y)=U!$D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S Y="^"
 D ISET
 I $E(Y)=U G EXIT
 ;
 S IBSTOP=0 D OUT I IBSTOP G:$$STOP EXIT G ENRK
 ;
 D DEVICE
 G EXIT
 ;
ISET ; if item save and set flag
 ;
 N IBA,IBC,IBD,IBE
 I Y=""!($E(Y)=U) Q  ; leave IBOK 0 in order to stop
 S IBOK=1,IBFND=0
 S IBA=$G(^TMP("IBCNOR3",$J,1,Y))
 I IBA W *7,"    EDI Payer ID already selected" Q
 S ^TMP("IBCNOR3",$J,1,Y)=1,IBCNT=IBCNT+1,^TMP("IBCNOR3",$J,0)=IBCNT
 Q
 ;
 ;
OUT ; Prompt to allow users to select output format
 ; Returns: E - Output to excel
 ;          R - Output to report
 ;     IBSTOP=1 - No Selection made
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 S DIR("?",1)="Select 'E' to create CSV output for import into Excel."
 S DIR("?")="Select 'R' to create a standard report."
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S IBSTOP=1 G OUTQ
 S IBOUT=Y
 Q
OUTQ ;
 ;
 Q
 ;
EXIT ; quit point
 ;
 K ^TMP("IBCNOR3",$J)
 Q
 ;
DEVICE ;
 N DIR,IBB,IBC,IBJOB,POP,ZTDESC,ZTRTN,ZTSAVE
 I IBOUT="R" W !!,"You will need a 132 column printer for this report.",!
 I IBOUT="E" D
 . W !!,"For CSV output, turn logging or capture on now.",!
 . W "To avoid undesired wrapping of the data, please"
 . W !," enter '0;256;99999'.",!
 K IBXSAV M IBXSAV=^TMP("IBCNOR3",$J)
 S ZTRTN="COMPILE^IBCNOR3"
 S ZTDESC="EP - EDI Payer ID Report"
 F IBB="IBOUT","IBC","IBXSAV(" S ZTSAVE(IBB)=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"Q")   ; ICR # 1519
 ;
 Q
 ;
 ;
COMPILE ; build output of payers
 ;
 N %,IB36,IBADDR,IBARY,IBCHK,IBCTY,IBCRT,IBDASHES,IBEORMSG,IBFILTER,IBHDR
 N IBHDRDATE,IBHDRNAME,IBINDX,IBITM,IBL,IBLOOK,IBLNC,IBMAXCNT,IBNM,IBNONEMSG
 N IBPGC,IBSPACES,IBST,IBSTAB,IBSTOP,IBSTREET,IBUN,IBW,IBXTFEED,IBZIP
 ;
 S IBOUT=$G(IBOUT),IBC=$G(IBC)
 S IBCHK=0
 S IBMAXCNT=IOSL-3,IBXTFEED=21,IBCRT=1,IBLNC=0
 I IOST'["C-" S IBMAXCNT=IOSL-6,IBXTFEED=50,IBCRT=0
 S IBEORMSG="*** End of Report ***"
 S IBNONEMSG="* * * N o   D a t a   F o u n d * * *"
 S IBHDRNAME="EDI PAYER ID REPORT"
 D NOW^%DTC
 S IBHDRDATE=$$DAT2^IBOUTL($E(%,1,12))
 S $P(IBDASHES,"-",132)=""
 S $P(IBSPACES," ",80)=""
 S IBHDR="HDR"_$S(IBOUT="E":"E",1:"R")
 K ^TMP($J,"IBCNOR3")
 K ^TMP($J,"IBCNOR3-1")
 K IBFND
 M ^TMP($J,"IBCNOR3")=IBXSAV
 ;
 ;compile
 ;
 I IBCRT W !,"Checking Insurance Companies for the EDI Payer number(s)",!
 S IBFILTER="SELECTED: "
 S IBLOOK="",IBCHK=0
 ; get ID add to display and make uppercase
 F  S IBLOOK=$O(^TMP($J,"IBCNOR3",1,IBLOOK)) Q:IBLOOK=""  D  S IBCHK=IBCHK+1
 . S IBFILTER=IBFILTER_($S('+IBCHK:"",1:", "))_IBLOOK,IBUN=$$UP^XLFSTR(IBLOOK),^TMP($J,"IBCNOR3",2,IBUN)=1
 D WALK
 ;
PRINT ; out put the compile in insurance co name order
 ;
 N IBFIL
 S IBFIL="," S:$G(IBOUT)="R" IBFIL=IBFIL_" "
 K IBW,IBARY
 S IBPGC=0
 I '+$G(^TMP($J,"IBCNOR3-1",2)) D NOD G EXITC
 D:IBOUT="E" HDRE D:IBOUT="R" HDRR
 S IBSTOP=0,IBNM="" F  S IBNM=$O(^TMP($J,"IBCNOR3-1",1,IBNM)) Q:IBNM=""  D  Q:IBSTOP
 . S IBSTREET="" F  S IBSTREET=$O(^TMP($J,"IBCNOR3-1",1,IBNM,IBSTREET)) Q:IBSTREET=""  D  Q:IBSTOP
 .. S IBCTY="" F  S IBCTY=$O(^TMP($J,"IBCNOR3-1",1,IBNM,IBSTREET,IBCTY)) Q:IBCTY=""  D  Q:IBSTOP
 ... S IBSTAB="" F  S IBSTAB=$O(^TMP($J,"IBCNOR3-1",1,IBNM,IBSTREET,IBCTY,IBSTAB)) Q:IBSTAB=""  D  Q:IBSTOP
 .... S IBZIP="" F  S IBZIP=$O(^TMP($J,"IBCNOR3-1",1,IBNM,IBSTREET,IBCTY,IBSTAB,IBZIP)) Q:IBZIP=""  D  Q:IBSTOP
 ..... S IB36="" F  S IB36=$O(^TMP($J,"IBCNOR3-1",1,IBNM,IBSTREET,IBCTY,IBSTAB,IBZIP,IB36)) Q:'IB36  D  Q:IBSTOP
 ...... S IBW=$G(^TMP($J,"IBCNOR3-1",1,IBNM,IBSTREET,IBCTY,IBSTAB,IBZIP,IB36))
 ...... S IBADDR=$S(IBSTREET'=" ":IBSTREET,1:"")_IBFIL_$S(IBCTY'=" ":IBCTY,1:"")_IBFIL
 ...... S IBADDR=IBADDR_$S(IBSTAB'=" ":IBSTAB,1:"")_IBFIL_$S(IBZIP'=" ":IBZIP,1:"")
 ...... I IBOUT="E" D  Q
 ....... W !,IBNM,U,IBADDR,U,IBW
 ...... I IBOUT="R" D
 ....... W !,IBNM,?32,$P(IBW,U,1),?64,$P(IBW,U,2),?96,$P(IBW,U,3),?128,$P(IBW,U,4)
 ....... W !,"   ",IBADDR
 ....... S IBLNC=IBLNC+2 I (IBPGC>0),(IBLNC+2>IBMAXCNT) D
 ........ D QLINE Q:IBSTOP
 ........ D:IBOUT="E" HDRE D:IBOUT="R" HDRR
 I IBSTOP G EXITC
 W !,IBEORMSG
 D QLINE
 G EXITC
 ;
NOD ; no info to print
 ;
 D:IBOUT="E" HDRE D:IBOUT="R" HDRR
 W !,IBNONEMSG,!,IBEORMSG
 D QLINE
 Q
 ;
QLINE ; cr to continue
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIN
 W !
 I 'IBCRT Q
 S DIR(0)="E" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S IBSTOP=1
 Q
 ;
WALK ; walk the indexes
 ;
 N IB36,IBARY,IBCHK,IBCK,IBCKA,IBCTY,IBI,IBNM,IBS,IBST,IBSTAB,IIBSTREET,IBW,IBZIP
 S IB36=0,IBCHK=0 F  S IB36=$O(^DIC(36,IB36)) Q:'IB36  D
 . S IBCHK=IBCHK+1 I IBCRT&(IBCHK#500=0) W "."
 . I '$D(^DIC(36,IB36,0)) Q  ; zero record not found
 . I $D(^TMP($J,"IBCNOR3-1",0,IB36)) Q  ; already picked up. the same edi number can be used multiple times
 . K IBARY D GETS^DIQ(36,IB36_",",".01;.05;.111;.114;.115;.116;3.02;3.04;3.15","IE","IBARY")
 . K IBW M IBW=IBARY(36,IB36_",")
 . ; check if in array
 . S IBCKA=0
 . F IBI=$G(IBW(3.02,"I")),$G(IBW(3.04,"I")),$G(IBW(3.15,"I")) D  Q:IBCKA
 .. I IBI=""!(IBI=" ") Q
 .. S IBCK=$$UP^XLFSTR(IBI)
 .. I '$D(^TMP($J,"IBCNOR3",2,IBCK)) Q
 .. S ^TMP($J,"IBCNOR3-1",0,IB36)=1
 .. S IBNM=$G(IBW(.01,"E")),IBSTREET=$G(IBW(.111,"E")),IBCTY=$G(IBW(.114,"E"))
 .. S IBST=$G(IBW(.115,"I")),IBZIP=$G(IBW(.116,"E"))
 .. S IBSTAB="" I IBST S IBSTAB=$$GET1^DIQ(5,IBST_",","1","I")
 .. S:IBNM="" IBNM=" " S:IBSTREET="" IBSTREET=" "
 .. S:IBCTY="" IBCTY=" " S:IBSTAB="" IBSTAB=" " S:IBZIP="" IBZIP=" "
 .. S IBS=$G(IBW(3.02,"I"))_U_$G(IBW(3.04,"I"))_U_$G(IBW(3.15,"I"))_U_$S('$G(IBW(.05,"I")):"A",1:"I")
 .. S ^TMP($J,"IBCNOR3-1",1,IBNM,IBSTREET,IBCTY,IBSTAB,IBZIP,IB36)=IBS
 .. S ^TMP($J,"IBCNOR3-1",2)=$G(^TMP($J,"IBCNOR3-1",2))+1
 .. S IBCKA=1
 Q
 ;
HDRE ; excel header
 ;
 W !,IBHDRNAME,U,IBHDRDATE
 W !,IBFILTER
 W !,"INSURANCE COMPANY"_U_"ADDRESS"_U_"PROFESSIONAL ID"_U_"INSTITUTIONAL ID"_U_"DENTAL ID"_U_"A/I"
 ;
 Q
 ;
HDRR ; report header
 ;
 N IBA,IBF,IBG
 S IBPGC=$G(IBPGC)+1 I IBCRT W:$G(IOF)'="" @IOF W:$G(IOF)="" !
 I 'IBCRT W !
 S IBA=$E(IBSPACES,1,(6-$L(IBPGC)))_IBPGC,IBLNC=6
 W IBHDRNAME,?90,IBHDRDATE,?119,"Page: ",IBA,!
 S IBLNC=5 W IBFILTER,!!
 W "INSURANCE COMPANY",?32,"PROFESSIONAL ID",?64,"INSTITUTIONAL ID",?96,"DENTAL ID",?128,"A/I"
 W !,$E(IBDASHES,1,132)
 Q
 ;
EXITC ; compile section exit
 ;
 K ^TMP($J,"IBCNOR3-1")
 K ^TMP($J,"IBCNOR3")
 Q
 ;
STOP() ; Determine if user wants to exit out of the whole option
 ; Initialize Variables
 N DIR,DIRUT,X,Y
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)=" Enter YES to immediately exit out of this option."
 S DIR("?")=" Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT) S (IBSTOP,Y)=1 G STOPX
 I 'Y S IBSTOP=0
STOPX ; STOP Exit Point
 Q Y
 ;
