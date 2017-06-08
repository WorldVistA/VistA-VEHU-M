IBYZ20V1 ;ALB/CPM - LOCATE/BILL PRESCRIPTIONS (CON'T) ; 21-MAR-97
 ;;FOR USE ONLY IN THE VHA CHICAGO HEALTHCARE SYSTEM
 ;
DQ ; Queued entry point to begin the job.
 ;
 S (IBCTA,IBCTAS,IBCTBO,IBCTBR,IBCTBER,IBCTSO,IBCTSR,IBCTD)=0
 K ^TMP($J,"IBYZ20V")
 D NOW^%DTC S IBBEXDT=%
 ;
 ; - process all filled prescriptions
 D PROC
 ;
 ; - print detail report if required
 I $G(IBRPT) D ^IBYZ20V3
 ;
 ; - send a confirmation bulletin
 D NOW^%DTC S IBEEXDT=%
 D BULL^IBYZ20V2
 ;
DQQ K IBBEXDT,IBEEXDT,IBBDT,IBEDT,IBMODE,IBSERV,IBCOUNT,IBRPT
 K IBCTA,IBCTAS,IBCTBER,IBCTBO,IBCTBR,IBCTSO,IBCTSR,IBCTD
 K ^TMP($J,"IBYZ20V")
 Q
 ;
 ;
PROC ; Check all filled prescriptions for pharmacy copay billing.
 ;
 S IBPHSTAT=$O(^PS(53,"B","OPT NSC",0))
 S IBDOL=2 ;  we'll assume $2.00 and stay out of the rate tables
 ;
 S IBFDT=$$FMADD^XLFDT(IBBDT,-1)
 F  S IBFDT=$O(^PSRX("AD",IBFDT)) Q:'IBFDT!(IBFDT>IBEDT)  D
 .S IBRX=0 F  S IBRX=$O(^PSRX("AD",IBFDT,IBRX)) Q:'IBRX  D
 ..S IBREF="" F  S IBREF=$O(^PSRX("AD",IBFDT,IBRX,IBREF)) Q:IBREF=""  D
 ...;
 ...S IBCTA=IBCTA+1
 ...;
 ...; - get prescription/refill information
 ...S IBRXD=$G(^PSRX(IBRX,0)),IBRXD2=$G(^(2)),IBRXDB=$G(^("IB"))
 ...Q:$P(IBRXD,"^")=""  ; no rx#
 ...S DFN=+$P(IBRXD,"^",2) Q:'DFN
 ...I IBREF S IBREFD=$G(^PSRX(IBRX,1,IBREF,0)) Q:'IBREFD
 ...;
 ...; - only consider OPT NSC prescriptions
 ...Q:$P(IBRXD,"^",3)'=IBPHSTAT
 ...;
 ...; - ignore supply items/investigational drugs
 ...S IBDEA=$P($G(^PSDRUG(+$P(IBRXD,"^",6),0)),"^",3)
 ...Q:IBDEA["S"!(IBDEA["I")
 ...;
 ...; - conduct up-front checks for original fills
 ...S IBRELD=$S(IBREF:$P(IBREFD,"^",18),1:$P(IBRXD2,"^",13))
 ...I 'IBREF S IBQ=0 D  Q:IBQ
 ....;
 ....; - quit if the rx has been billed
 ....I $P(IBRXDB,"^",2) S IBQ=1 Q
 ....;
 ....; - quit if the rx is 'queued' for billing, but not released
 ....I IBRXDB,'IBRELD S IBQ=1
 ...;
 ...; - conduct up-front checks for refills
 ...I IBREF S IBQ=0 D  Q:IBQ
 ....;
 ....; - quit if the rx has been billed
 ....I $G(^PSRX(IBRX,1,IBREF,"IB")) S IBQ=1 Q
 ....;
 ....; - quit if the original fill was checked here, and it is
 ....;   not billable.
 ....I $D(^TMP($J,"IBYZ20V","CHK ORIG",IBRX)),'^(IBRX) S IBQ=1 Q
 ....;
 ....; - quit if the original fill was not checked here, and it is
 ....;   not flagged as being billable.
 ....I '$D(^TMP($J,"IBYZ20V","CHK ORIG",IBRX)),'IBRXDB S IBQ=1
 ...;
 ...; - have billing conduct its regular checks
 ...S IBBILL=$$IB()
 ...I 'IBREF S ^TMP($J,"IBYZ20V","CHK ORIG",IBRX)=IBBILL
 ...Q:'IBBILL
 ...;
 ...; - prescription is billable...
 ...;
 ...S IBPHDIV=$E($P($G(^PS(59,+$P(IBRXD2,"^",9),0)),"^"),1,20)
 ...S IBCOST=$P(($P(IBRXD,"^",8)+29)/30,".",1)*IBDOL,X=$G(^DPT(DFN,0))
 ...S IBNAM=$E($P(X,"^"),1,20)_"@@"_$E($P(X,"^",9),6,11)_"@@"_DFN
 ...;
 ...; - see if prescription has been released or not
 ...I IBREF D
 ....I IBRELD S IBCTBR=IBCTBR+1,IBCTD=IBCTD+IBCOST D SET("BILL")
 ....E  S IBCTSR=IBCTSR+1 D SET("SET")
 ...;
 ...I 'IBREF D
 ....I IBRELD S IBCTBO=IBCTBO+1,IBCTD=IBCTD+IBCOST D SET("BILL")
 ....E  S IBCTSO=IBCTSO+1 D SET("SET")
 ...;
 ...; - stop here if in scan mode
 ...Q:IBMODE="S"
 ...;
 ...; - set up the prescription for billing if it is not released
 ...I 'IBRELD D SET^IBYZ20V4(IBRX) Q
 ...;
 ...; - bill the prescription
 ...S IBRES=$$BILL^IBYZ20V4(IBRX,IBREF,IBSERV)
 ...I IBRES<0 S IBCTBER=IBCTBER+1
 ;
 K DFN,IBPHSTAT,IBDOL,IBFDT,IBRX,IBREF,IBRXD,IBRXD2,IBRXDB,IBREFD
 K IBDEA,IBQ,IBBILL,IBCOST,IBRELD,IBPHDIV,IBRES
 Q
 ;
 ;
IB() ; Conduct checks performed in IB.
 N IBY,VA,VAERR,VAEL,VAIN,VAINDT
 S IBY=0
 D ELIG^VADPT
 I '$D(VAEL) G IBQ ; couldn't determine eligibility
 I 'VAEL(4) G IBQ ; not a veteran
 ;
 ; - can't evaluate rx's for SC vets; but count those <50%
 I VAEL(3) S:$P(VAEL(3),"^",2)<50 IBCTAS=IBCTAS+1 G IBQ
 ;
 S VAINDT=IBFDT D INP^VADPT
 I $D(VAIN(4)),$D(^DIC(42,+VAIN(4),0)),$P(^(0),"^",3)="D" G IBQ ; dom pt
 ;
 ; - veteran is exempt from copay
 I $$RXST^IBARXEU(DFN,$S(IBRELD:IBRELD,1:IBFDT)) G IBQ
 ;
 S IBY=1
 ;
IBQ Q IBY
 ;
SET(X) ; Set report node for rx's to be billed or set up.
 ;  Input:  X  --  "BILL" for rx's to be billed
 ;                 "SET" for rx's to be set for billing
 Q:'$G(IBRPT)
 S ^TMP($J,"IBYZ20V",X,IBNAM,$P(IBRXD,"^"),IBREF)=IBFDT_"^"_IBPHDIV_"^"_IBCOST
 Q
