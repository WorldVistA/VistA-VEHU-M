IBZ20A1 ;ALB/CPM - FIND REFILLS IN CLAIMS TRACKING (CON'T.) ; 24-FEB-95
 ;;NOT for General Distribution.
 ;
 ;  This routine is a continuation of IBZ20A.
 ;
DQ ; Tasked entry point
 ;  Required variable input:
 ;    IBBDT  --  Beginning of refill date range
 ;    IBEDT  --  End of refill date range
 ;    IBDEL  --  0 -> just list the applicable refills in a report
 ;               1 -> list the refills and delete the RNB
 ;     IBV6  --  Outpatient Pharmacy v6.0 installation date
 ;  IBRMARK  --  Pointer to the RNB of 'OTHER' in file #356.8
 ;   IBETYP  --  Pointer to the CT Type 'PRES. REFILL' in file #356.6
 ;
 K ^TMP("IBRX",$J)
 S (IBQ,IBPAG)=0
 D NOW^%DTC S IBHDT=$$DAT2^IBOUTL(%)
 ;
 ; - find the CT entries
 S IBD=$$FMADD^XLFDT(IBBDT,-1)_.9 F  S IBD=$O(^IBT(356,"D",IBD)) Q:'IBD!($E(IBD,1,7)>IBEDT)  D
 .S IBTRN=0 F  S IBTRN=$O(^IBT(356,"D",IBD,IBTRN)) Q:'IBTRN  D
 ..S IBTRND=$G(^IBT(356,IBTRN,0))
 ..Q:'IBTRND  ; mr. bogus
 ..Q:$P(IBTRND,"^",18)'=IBETYP  ;    not rx refill
 ..Q:$P(IBTRND,"^",19)'=IBRMARK  ;   RNB is not OTHER
 ..S DFN=$P(IBTRND,"^",2) Q:'DFN  ;  no patient
 ..;
 ..S IBRXN=$P(IBTRND,"^",8),IBFILL=$P(IBTRND,"^",10)
 ..I IBFILL<1!(IBRXN<1) Q  ;         can't be a refill
 ..S IBFILLD=$G(^PSRX(+IBRXN,1,+IBFILL,0))
 ..Q:'IBFILLD  ;                     not a valid refill
 ..Q:$P(IBFILLD,"^",18)  ;           refill shouldn't be released!
 ..;
 ..S IBNAM=$$PT^IBEFUNC(DFN)
 ..S ^TMP("IBRX",$J,$P(IBNAM,"^",1,2)_"@@"_DFN,IBTRN)=$P($G(^PSRX(+IBRXN,0)),"^")_"^"_IBD
 ;
 ; - print them and delete the RNB if necessary
 D HDR I '$D(^TMP("IBRX",$J)) W !!,"No applicable Refills within this date range." G NONE
 ;
 S IBNAM="" F  S IBNAM=$O(^TMP("IBRX",$J,IBNAM)) Q:IBNAM=""  D  Q:IBQ
 .I $Y>(IOSL-4) D PAUSE Q:IBQ  D HDR
 .W !,$E($P(IBNAM,"^"),1,25),?27,$P($P(IBNAM,"@@"),"^",2) S IBS=0
 .S IBTRN=0 F  S IBTRN=$O(^TMP("IBRX",$J,IBNAM,IBTRN)) Q:'IBTRN  S IBTRND=$G(^(IBTRN)) D  Q:IBQ
 ..I $Y>(IOSL-4) D PAUSE Q:IBQ  D HDR W !,$E($P(IBNAM,"^"),1,25),?27,$P($P(IBNAM,"@@"),"^",2) S IBS=0
 ..W:IBS ! W ?40,$P(IBTRND,"^"),?51,$$DAT1^IBOUTL($P(IBTRND,"^",2))
 ..I IBDEL S DA=IBTRN,DIE="^IBT(356,",DR=".19////@" D ^DIE K DA,DIE,DR
 ..S IBTRND0=$G(^IBT(356,IBTRN,0))
 ..S X=$$EXPAND^IBTRE(356,.19,$P(IBTRND0,"^",19))
 ..W ?61,$S(X]"":X,1:"<deleted>")
 ..S X=$P(IBTRND0,"^",17)
 ..W ?72,$S(X:$$DAT1^IBOUTL(X),1:"<none>")
 ..S IBS=1
 ;
NONE I 'IBQ D PAUSE
 ;
 K ^TMP("IBRX",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 K IBQ,IBHDT,IBPAG,IBD,IBTRN,IBTRND,IBTRND0,DFN,IBRXN,IBFILL,IBFILLD,IBNAM,X
 Q
 ;
 ;
PAUSE ; Pause for screen output
 Q:$E(IOST,1,2)'="C-"
 N IBI,DIR,DIRUT,DIROUT,DUOUT,DTOUT
 F IBI=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
HDR ; Display a header
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"Run Date/Time: ",IBHDT,?71,"Page: ",IBPAG
 W !!?10,"List of Claims Tracking Refills Which Need to be Auto-billed"
 W !?10,"Refills within the Date Range ",$$DAT1^IBOUTL(IBBDT)," through ",$$DAT1^IBOUTL(IBEDT)
 W !!?10,"** The Reason Not Billable ",$S(IBDEL:"--IS--",1:"is NOT")," being deleted on this run."
 W !!,"PATIENT                    PT ID        RX#        REF DATE   RNB         EABD"
 W !,$TR($J("",80)," ","-"),!
 Q
