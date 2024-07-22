IBCNOR4 ;AITC/DTG - IBCN DUP GROUP TO INS USAGE ;12/14/23
 ;;2.0;INTEGRATED BILLING;**778**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point
 ;
 N DIR,IBAR,IBCK,IBCNT,IBI,IBID,IBOK,IBONE,IBOUT,IBSTOP,IBTYP,IBXSAV,POP,X,Y
 K ^TMP("IBCNOR4",$J) S ^TMP("IBCNOR4",$J,0)=""
 W:$G(IOF)'="" @IOF W:$G(IOF)="" !
 W !,"This report can help identify potential duplicate group plans by group"
 W !,"number in one or more insurance companies. Search through the entire"
 W !,"database for duplicate groups or narrow down the search by a specific"
 W !,"group number."
 ; get group numbers
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
ENTYP ; get type equal or contain or all
 ;
 W ! S IBTYP=""
 K DIR S DIR(0)="S^1:ALL Duplicate Groups;2:Specific Group Number"
 S DIR("A")="SELECT 1 or 2"
 S DIR("?",1)="All Duplicate Groups will search the entire database and if exact"
 S DIR("?",2)="duplicates are found (by group number), all duplicate group results"
 S DIR("?",3)="from all insurance companies will display on the report."
 S DIR("?",4)=" "
 S DIR("?",5)="Specific Group Number requires the user to enter a specific group"
 S DIR("?",6)="number and will return all results of the searched group from all"
 S DIR("?",7)="insurance companies (regardless of number of instances)."
 S DIR("?")="Enter '^' to quit, OR"
 D ^DIR
 I Y="" S Y=1
 I $E(Y)=U!$D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S Y="^"
 I $E(Y)=U G EXIT
 S IBTYP=+Y I 'Y G EXIT
 I IBTYP=1 G CON  ; if looking for all skip the group number question
 ;
ENRK ; come here if continue from ^ response
 K ^TMP("IBCNOR4",$J) S ^TMP("IBCNOR4",$J,0)=""
ENR ; ask question return point. 
 W !
 K DIR S DIR(0)="F^1:30"
 S DIR("A")="Enter a Group Number"
 S DIR("?")="Enter a specific Group/Plan Number or '^' to quit"
 S IBOK=0
ENAQ ;
 D ^DIR
 ;
 I $E(Y,1)=" " S IBOK=0 D  I 'IBOK S Y="" W !,"This is a required response. Enter '^' to exit" G ENAQ
 . F IBI=1:1:$L(Y) I $E(Y,IBI)'=" " S IBOK=1 Q
 I $E(Y)=U!$D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S Y=U
 D ISET
 I $E(Y)=U G EXIT
 G RE
 ;
CON ; continue if all
 I IBTYP'=1 G RE
 W !!!,"WARNING: You have selected to run this report for all duplicate groups."
 W !,"In doing so, this report will take a long time to run.",!
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S DIR(0)="Y"
 S DIR("A")="Do you want to continue"
 S DIR("B")="NO"
 S DIR("?",1)=" Enter YES to continue."
 S DIR("?")=" Enter NO or '^' to exit."
 D ^DIR K DIR
 I 'Y G EXIT  ; do not wish to continue
 ;
RE ; report or excel
 S IBSTOP=0 D OUT I IBSTOP G EXIT
 ;
 D DEVICE
 ;
EXIT ; quit point
 ;
 K ^TMP("IBCNOR4",$J)
 Q
 ;
 ;
ISET ; if item save and set flag
 ;
 N IBA,IBC,IBD,IBE,IBFND
 I Y=""!($E(Y)=U) Q  ; leave IBOK 0 in order to stop
 S ^TMP("IBCNOR4",$J,1,Y)=1,^TMP("IBCNOR4",$J,0)=1,^TMP("IBCNOR4",$J,"U",($$UP^XLFSTR(Y)))=1
 Q
 ;
OUT ; Prompt to allow users to select output format
 ; Returns: E - Output to excel
 ;          R - Output to report
 ;   IBSTOP=1 - No Selection made
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
DEVICE ;
 N IBB,POP,ZTDESC,ZTRTN,ZTSAVE
 I IBOUT="R" W !!,"***This report is 132 characters wide.***",!
 I IBOUT="E" D
 . W !!,"For CSV output, turn logging or capture on now.",!
 . W "To avoid undesired wrapping of the data, please"
 . W !," enter '0;256;99999'.",!
 K IBXSAV M IBXSAV=^TMP("IBCNOR4",$J)
 S ZTRTN="COMPILE^IBCNOR4"
 S ZTDESC="LD - LIST DUPLICATE GROUP PLANS BY INS CO"
 F IBB="IBOUT","IBTYP","IBXSAV(" S ZTSAVE(IBB)=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"Q")   ; ICR # 1519
 ;
 Q
 ;
 ;
COMPILE ; build output of payers
 ;
 N %,IB3553,IB36,IBA,IBADDR,IBARY,IBB,IBC,IBCTL,IBCHK,IBCNT,IBCRT,IBDASHES,IBDOT,IBEORMSG,IBFILTER
 N IBGCT,IBGNAM,IBGON,IBHDR
 N IBHDRDATE,IBHDRNAME,IBINDX,IBINS,IBITM,IBL,IBLOOK,IBLNC,IBLS,IBMAXCNT,IBNM,IBNONEMSG
 N IBPGC,IBS,IBS3553,IBSPACES,IBST,IBSTAB,IBSTOP,IBSI,IBSTOP,IBUN,IBW,IBXTFEED,IBZIP
 ;
 S IBOUT=$G(IBOUT)
 S IBCHK=0
 S IBMAXCNT=IOSL-3,IBXTFEED=21,IBCRT=1,IBLNC=0
 I IOST'["C-" S IBMAXCNT=IOSL-6,IBXTFEED=50,IBCRT=0
 S IBEORMSG="*** End of Report ***"
 S IBNONEMSG="* * * N o   D a t a   F o u n d * * *"
 S IBHDRNAME="List Duplicate Group Plans by Insurance Company"
 D NOW^%DTC
 S IBHDRDATE=$$DAT2^IBOUTL($E(%,1,12))
 S $P(IBDASHES,"-",132)=""
 S $P(IBSPACES," ",80)=""
 S IBHDR="HDR"_$S(IBOUT="E":"E",1:"R")
 K ^TMP($J,"IBCNOR4")
 K ^TMP($J,"IBCNOR4-1")
 K IBFND
 M ^TMP($J,"IBCNOR4")=IBXSAV
 S IBDOT=2000 I IBTYP=1 S IBDOT=100000  ; reduce dots for subscribers when all are selected
 ;
 ;compile
 ; walk the indexes
 ;
 I IBCRT W !,"Checking for Duplicate Group Number(s)",!
 S IBFILTER="" I IBTYP=2 S IBFILTER="Selected: "
 D RUN
 ; if all collect all group numbers
 I IBTYP=1 S IBFILTER="All Group Numbers"
 I IBTYP=2 S IBLOOK="",IBCNT=0 F  S IBLOOK=$O(^TMP($J,"IBCNOR4",1,IBLOOK)) Q:IBLOOK=""  D
 . S IBB=$G(^TMP($J,"IBCNOR4",1,IBLOOK)) I IBB=1 S IBFILTER=IBFILTER_($S('+IBCHK:"",1:", "))_IBLOOK S IBCHK=IBCHK+1
 ;
 D WALK ; get subscriber counts
 ;
 ; uses ^TMP($J,"IBCNOR4-1") to print
 ;
PRINT ; out put the compile in insurance co name order
 ;
 N IBA,IBGLIN
 K IBW,IBARY
 S IBSTOP=0,IBPGC=0,IBGCT=0,IBGON=""
 I '+$G(^TMP($J,"IBCNOR4-1",2)) D NOD G EXITC
 D:IBOUT="E" HDRE D:IBOUT="R" HDRR
 I IBOUT="E" D
 . S IBNM="" F  S IBNM=$O(^TMP($J,"IBCNOR4-1",6,IBNM)) Q:IBNM=""  D
 .. S IBGLIN=$G(^TMP($J,"IBCNOR4-1",2,IBNM))
 .. I IBTYP=1&(IBGLIN<2) Q  ; if doing all do not print group if only one insurance associated
 .. S IBGNAM="" F  S IBGNAM=$O(^TMP($J,"IBCNOR4-1",6,IBNM,IBGNAM)) Q:IBGNAM=""  D
 ... S IBINS="" F  S IBINS=$O(^TMP($J,"IBCNOR4-1",6,IBNM,IBGNAM,IBINS)) Q:IBINS=""  D
 .... S IBADDR="" F  S IBADDR=$O(^TMP($J,"IBCNOR4-1",6,IBNM,IBGNAM,IBINS,IBADDR)) Q:IBADDR=""  D
 ..... S IB3553="" F  S IB3553=$O(^TMP($J,"IBCNOR4-1",6,IBNM,IBGNAM,IBINS,IBADDR,IB3553)) Q:IB3553=""  D
 ...... S IBA=$G(^TMP($J,"IBCNOR4-1",6,IBNM,IBGNAM,IBINS,IBADDR,IB3553))
 ...... W !,$P(IBA,U,4),U,IBNM,U,IBGNAM,U,IBINS,U,IBADDR,U,$P(IBA,U,2),U,$P(IBA,U,3)
 ;
 I IBOUT="R" D
 . S IBNM="" F  S IBNM=$O(^TMP($J,"IBCNOR4-1",1,IBNM)) Q:IBNM=""  D  Q:IBSTOP
 .. S IBGLIN=$G(^TMP($J,"IBCNOR4-1",2,IBNM))
 .. I IBTYP=1&(IBGLIN<2) Q  ; if doing all do not print group if only one insurance associated
 .. ; make sure to print at least one INS for the group on same page
 .. I IBLNC+2>IBMAXCNT D QLINE Q:IBSTOP  D:IBOUT="E" HDRE D:IBOUT="R" HDRR
 .. W !,IBNM  S IBLNC=IBLNC+1,IBGCT=0  ; print group number first
 .. S IBINS="" F  S IBINS=$O(^TMP($J,"IBCNOR4-1",1,IBNM,IBINS)) Q:IBINS=""  D  Q:IBSTOP
 ... S IBADDR="" F  S IBADDR=$O(^TMP($J,"IBCNOR4-1",1,IBNM,IBINS,IBADDR)) Q:IBADDR=""  D  Q:IBSTOP
 .... S IB3553="" F  S IB3553=$O(^TMP($J,"IBCNOR4-1",1,IBNM,IBINS,IBADDR,IB3553)) Q:IB3553=""  D  Q:IBSTOP
 ..... S IBGCT=IBGCT+1,IBA=$G(^TMP($J,"IBCNOR4-1",1,IBNM,IBINS,IBADDR,IB3553))
 ..... S IBW=$S(IBOUT="E":$P(IBA,U,5),1:$P(IBA,U,4))_U_$P(IBA,U,3)_U_$P(IBA,U,2)
 ..... W !,?2,$P(IBA,U,6),?6,IBINS,?38,IBADDR,?74,$P(IBW,U,1),?83,$P(IBW,U,2),?107,$E($P(IBW,U,3),1,24)
 ..... S IBLNC=IBLNC+1
 ..... I (IBPGC>0),(IBLNC+1>IBMAXCNT) D
 ...... D QLINE Q:IBSTOP
 ...... D:IBOUT="E" HDRE D:IBOUT="R" HDRR
 ...... I IBGCT<IBGLIN W !,IBNM,"   (continued)"
 I IBSTOP G EXITC
 W !,IBEORMSG
 D QLINE
 ;
 ;
EXITC ; compile section exit
 ;
 K ^TMP($J,"IBCNOR4-1")
 K ^TMP($J,"IBCNOR4")
 Q
 ;
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
 ;
WALK(IBINDX,IBLS) ; get subscribers
 ;
 N IB3553,IB36,IBA,IBARY,IBB,IBC,IBD,IBDTA,IBINAL1,IBINM,IBGNUM,IBSUBCT,IBPTDFN,IBPTINS
 I IBCRT W !,"Gathering Subscriber Counts: ",!,"."
 S IB36=0,IBCNT=0 F  S IB36=$O(^TMP($J,"IBCNOR4",5,IB36)) Q:'IB36  D
 . ;check pt file #2.312
 . S IBPTDFN=0 F  S IBPTDFN=$O(^DPT("AB",IB36,IBPTDFN)) Q:'IBPTDFN  S IBPTINS=0 D
 .. F  S IBPTINS=$O(^DPT("AB",IB36,IBPTDFN,IBPTINS)) Q:'IBPTINS  D
 ... S IBCNT=IBCNT+1 I IBCRT&(IBCNT#IBDOT=0) W "."
 ... S IBA=$$GET1^DIQ(2.312,IBPTINS_","_IBPTDFN_",",.18,"I")
 ... I 'IBA Q  ; no group associated
 ... I '$D(^TMP($J,"IBCNOR4",5,IB36,IBA)) Q  ; ins/group combo not selected
 ... S ^TMP($J,"IBCNOR4",5,IB36,IBA)=$G(^TMP($J,"IBCNOR4",5,IB36,IBA))+1
 I IBCRT W !,"Placing Subscriber Totals: ",!,"."
 ; ^TMP(39151,"IBCNOR4",4, group number , insurance co name , ins co address line 1 , 355.3 IEN) =
 ;     file 36 IEN ^ type of plan ^ group name with + or * as needed ^ subscriber count ^ sub ct no spaces ^ ins A or I
 S (IBCHK,IBCNT)=0,IBGNUM="" F  S IBGNUM=$O(^TMP($J,"IBCNOR4",4,IBGNUM)) Q:IBGNUM=""  S IBINM="" D
 . F  S IBINM=$O(^TMP($J,"IBCNOR4",4,IBGNUM,IBINM)) Q:IBINM=""  S IBINAL1="" D
 .. F  S IBINAL1=$O(^TMP($J,"IBCNOR4",4,IBGNUM,IBINM,IBINAL1)) Q:IBINAL1=""  S IB3553=0 D
 ... F  S IB3553=$O(^TMP($J,"IBCNOR4",4,IBGNUM,IBINM,IBINAL1,IB3553)) Q:'IB3553  D
 .... I IBCRT&(IBCNT#30000=0) W "."
 .... S IBDTA=$G(^TMP($J,"IBCNOR4",4,IBGNUM,IBINM,IBINAL1,IB3553))
 .... S IB36=$P(IBDTA,U,1)
 .... ; place total subscribers for each item
 .... S IBSUBCT=$G(^TMP($J,"IBCNOR4",5,IB36,IB3553)),IBCNT=IBCNT+1
 .... ;
 .... S IBB=$FN(IBSUBCT,",",0)
 .... S IBC=$E(IBSPACES,1,(7-$L(IBB)))_IBB,$P(IBDTA,U,4)=IBC,$P(IBDTA,U,5)=IBB
 .... S ^TMP($J,"IBCNOR4-1",1,IBGNUM,IBINM,IBINAL1,IB3553)=IBDTA
 .... S ^TMP($J,"IBCNOR4-1",2,IBGNUM)=$G(^TMP($J,"IBCNOR4-1",2,IBGNUM))+1  ; how many lines for the group number
 .... S ^TMP($J,"IBCNOR4-1",2)=$G(^TMP($J,"IBCNOR4-1",2))+1
 .... ; this is for the excel output since it is different for the report output
 .... ; ins AorI , gp num , gp nam , ins nm , ins add l1 , 355.33 ien = ins ien ^ typ pln ^ tot sums
 .... S ^TMP($J,"IBCNOR4-1",6,IBGNUM,$P(IBDTA,U,3),IBINM,IBINAL1,IB3553)=$P(IBDTA,U,1)_U_$P(IBDTA,U,2)_U_$P(IBDTA,U,5)_U_$P(IBDTA,U,6)
 ;
 Q
 ;
RUN ; go through 355.3
 ;
 N IB3553GNA,IB3553TY,IB36A1,IB36N,IB5,IBAR5,IBINA
 S IBS3553="",IBCNT=0,IBCTL=0 F  S IBS3553=$O(^IBA(355.3,IBS3553)) Q:IBS3553=""  D
 . S IBCNT=IBCNT+1 I IBCRT&(IBCNT#4000=0) W "."
 . S IB36=$$GET1^DIQ(355.3,IBS3553_",",.01,"I") I 'IB36 Q  ; if there is no insurance get next
 . I '$D(^DIC(36,IB36,0)) Q  ; if the pointer is invalid go back
 . ; (#.01) INSURANCE COMPANY [1P:36]
 . ; (#.02) IS THIS A GROUP POLICY?  '1' FOR YES; '0' FOR NO
 . ; (#.03) *GROUP NAME
 . ; (#.04) *GROUP NUMBER
 . ; (#.09) TYPE OF PLAN [9P:355.1]
 . ; (#.11) INACTIVE '0' FOR NO; '1' FOR YES
 . ; (#2.01) GROUP NAME
 . ; (#2.02) GROUP NUMBER
 . K IBAR5 D GETS^DIQ(355.3,IBS3553_",",".01;.02;.03;.04;.09;.11;2.01;2.02","IE","IBAR5")
 . K IB5 M IB5=IBAR5(355.3,IBS3553_",")
 . ; get group number
 . S IBSI=$G(IB5(2.02,"I"))  ; get group number from 'approved' group number field
 . I IBSI="" S IBSI=$G(IB5(.04,"I"))  ; get group number from 'old' field if 'approved' is null
 . I IBSI="" Q  ; no group number go back
 . ; gety group name
 . S IB3553GNA=$G(IB5(2.01,"I"))  ; get group name from 'approved' group name field
 . I IB3553GNA="" S IB3553GNA=$G(IB5(.03,"I"))  ; get group name from 'old' field if approved is null
 . I IB3553GNA="" S IB3553GNA="<NO GROUP NAME>"  ; if no group name associated
 . ; get type of plan
 . S IB3553TY=$G(IB5(.09,"E"))
 . I $L(IB3553TY)>25 S:IBOUT="R" IB3553TY=$E(IB3553TY,1,25) I $G(IB5(.09,"I"))'="" D
 .. S:IBOUT="R" IB3553TY=$$GET1^DIQ(355.1,$G(IB5(.09,"I"))_",",.02) ; Abbreviation
 . ; check if individual and if inactive
 . S IBA="" S:'$G(IB5(.02,"I")) IBA="+" S:$G(IB5(.11,"I")) IBA=IBA_"*"
 . S IB3553GNA=IBA_IB3553GNA
 . ; file 36 info
 . ; (#.01)  INSURANCE COMPANY NAME
 . ; (#.05)  INACTIVE  '0' FOR NO; '1' FOR YES
 . ; (#.111) STREET ADDRESS [LINE 1]
 . ; (#.13)  TYPE OF COVERAGE [13P:355.2]
 . K IBARY D GETS^DIQ(36,IB36_",",".01;.05;.111;.13","IE","IBARY")
 . K IBW M IBW=IBARY(36,IB36_",")
 . S IB36N=$G(IBW(.01,"E"))
 . S IB36A1=$G(IBW(.111,"E")) S:IB36A1="" IB36A1=" " S IB36A1=$E(IB36A1,1,34)
 . S IB36N=IB36N
 . S IBA=$G(IBW(.05,"I")),IBINA=$S('IBA:"A",1:"I")
 . I IBTYP=2 D  Q
 .. I $D(^TMP($J,"IBCNOR4","U",($$UP^XLFSTR(IBSI)))) D RSET
 . D RSET
 Q
 ;
RSET ; update TMP to prep for subscriber check
 ;
 I '$D(^TMP($J,"IBCNOR4",1,IBSI)) S ^TMP($J,"IBCNOR4",1,IBSI)=2
 S IBUN=$$UP^XLFSTR(IBSI),^TMP($J,"IBCNOR4",2,IBUN)=1
 ;                     G Nu in nm in addr 355 ien 38 ien  typ pln    g nm
 S ^TMP($J,"IBCNOR4",4,IBSI,IB36N,IB36A1,IBS3553)=IB36_U_IB3553TY_U_IB3553GNA_U_U_U_IBINA
 I IB36&(IBS3553) S ^TMP($J,"IBCNOR4",5,IB36,IBS3553)=0
 I IBTYP=1 D
 . S IBCTL=IBCTL+1,^TMP($J,"IBCNOR4",0)=IBCTL
 Q
 ;
HDRE ; excel header
 ;
 W !,IBHDRNAME,U,IBHDRDATE
 W !,IBFILTER
 W ", + Indicates individual group plan * Indicates inactive group plan"
 W !,"A/I^GROUP NUMBER^GROUP NAME^INSURANCE COMPANY^ADDRESS^TYPE OF PLAN^TOTAL SUBSCRIBERS"
 ;
 Q
 ;
HDRR ; report header
 ;
 N IBA,IBF,IBG
 S IBPGC=IBPGC+1,IBLNC=0 I IBCRT W:$G(IOF)'="" @IOF W:$G(IOF)="" ! S IBLNC=7
 I 'IBCRT W !
 S IBA=$E(IBSPACES,1,(6-$L(IBPGC)))_IBPGC
 W IBHDRNAME,?92,IBHDRDATE,?119,"Page: ",IBA,!
 S:IBLNC=0 IBLNC=6
 W IBFILTER,?57,"+ Indicates individual group plan",?99,"* Indicates inactive group plan",!!
 W "GROUP NUMBER",!
 W ?2,"A/I",?6,"INSURANCE COMPANY",?38,"ADDRESS",?72,"TOTAL SUB",?83,"GROUP NAME",?107,"TYPE OF PLAN"
 W !,$E(IBDASHES,1,132)
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
