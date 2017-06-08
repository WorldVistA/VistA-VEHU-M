IBYZ20V4 ;ALB/CPM - LOCATE/BILL PRESCRIPTIONS (BILLER) ; 25-MAR-97
 ;;FOR USE ONLY IN THE VHA CHICAGO HEALTHCARE SYSTEM
 ;
SET(IBRX) ; Set up a prescription for billing.
 ;  Input:   IBRX  --  pointer to the prescription in file #52
 ;
 ;  Note:  The calling routine must be certain that this prescription
 ;         should be set up for billing.  This code will hard-set the
 ;         COPAY TRANSACTION TYPE (#105) field in file #52 to the
 ;         pointer to the value for the IB Action Type PSO NSC RX
 ;         COPAY NEW (the pointer is 1).  Service-connected
 ;         prescriptions will not be set up for billing.
 ;
 Q:'$G(IBRX)
 Q:$P($G(^PSRX(IBRX,0)),"^")=""
 S $P(^PSRX(IBRX,"IB"),"^",1)=1,$P(^("IB"),"^",3)=1
 Q
 ;
 ;
BILL(IBRX,IBREF,IBRXSV) ; Bill an unbilled prescription.
 ;  Input:   IBRX  --  pointer to the prescription in file #52
 ;          IBREF  --  0: Orig Fill  >0: ptr to refill in file #52.1
 ;         IBRXSV  --  pointer to the Pharmacy service in file #49
 ;
 ;  Note:  The calling routine must be certain that this prescription
 ;         should be set up for billing.  This code will perform the
 ;         following steps:
 ;
 ;           (1) Set up the prescription for billing (using the
 ;               call above)
 ;           (2) Set the correct input and call NEW^IBARX
 ;           (3) Evaluate output; track any error
 ;           (4) If billed, set prescription with pointer to
 ;               the billing action in file #350
 ;
 N DFN,IBCP,IBREFD,IBRXD,IBRES,IBSERV,IBUNIT,IBUSER,X,Y
 S IBRES=-1
 ;
 ; - check input
 I '$G(IBRX) G BILLQ
 I '$G(IBRXSV) G BILLQ
 S IBRXD=$G(^PSRX(IBRX,0)) I $P(IBRXD,"^")="" G BILLQ
 S DFN=+$P(IBRXD,"^",2) I 'DFN G BILLQ
 ;
 I $G(IBREF)="" G BILLQ
 I IBREF S IBREFD=$G(^PSRX(IBRX,1,IBREF,0)) I 'IBREFD G BILLQ
 ;
 ; - set up the prescription for billing
 D SET(IBRX)
 S IBCP=+$G(^PSRX(IBRX,"IB")) I 'IBCP S IBRES=-2 G BILLQ
 ;
 ; - required input:   x = service^dfn^actiontype^user duz
 S IBUSER=$S($P(IBRXD,"^",16):$P(IBRXD,"^",16),1:DUZ)
 S X=IBRXSV_"^"_DFN_"^"_IBCP_"^"_IBUSER
 I IBREF S:$P(IBREFD,"^",7) $P(X,"^",4)=$P(IBREFD,"^",7) ; refill user
 ;
 ; - softlinks:        x(n) = softlink^units
 S IBUNIT=$P(($P(IBRXD,"^",8)+29)/30,".",1)
 S X(1)="52:"_IBRX
 S:IBREF>0 X(1)=X(1)_";1:"_IBREF
 S X(1)=X(1)_"^"_IBUNIT
 ;
 ; - make call to bill the prescription
 D NEW
 ;
 ; - the following output is returned from the billing call:
 ;        y = 1^total charges for this group or Y=-1^error code
 ;     y(n) = IB number^charge for this Rx^AR bill #
 ;
 I Y<0 S IBRES=-3 G BILLQ
 ;
 ; - update the Pharmacy "IB" node in file #52
 I IBREF S ^PSRX(IBRX,1,IBREF,"IB")=+Y(1) ; refill node
 E  S $P(^PSRX(IBRX,"IB"),"^",2)=+Y(1) ;    original fill (zero node)
 ;
 S IBRES=1
 ;
BILLQ Q IBRES
 ;
 ;
NEW ; Bill new/renew/refill.  See IBARXDOC for i/o documentation.
 N I,IBSAVX,J,X1,X2,DA,DFN K Y
 S IBWHER=1,IBSAVX=X,Y=1,IBTAG=2 D CHKX^IBAUTL I +Y<1 G NEWQ
 I $D(X)<11 S Y="-1^IB010" G NEWQ
 S J="" F  S J=$O(X(J)) Q:J=""  S IBSAVX(J)=X(J)
 D ARPARM^IBAUTL I +Y<1 G NEWQ
 ;
 ; - establish the receivable
 S IBTOTL=0
 D BILLNO^IBAUTL I +Y<1 G NEWQ
 ;
 ; - build the charge and drop it into the IB filer
 S IBTOTL=0,IBJ="",IBSEQNO=$P(^IBE(350.1,IBATYP,0),"^",5) I 'IBSEQNO S Y="-1^IB023" G NEWQ
 F  S IBJ=$O(IBSAVX(IBJ)) Q:IBJ=""  S IBX=IBSAVX(IBJ) D RX^IBARX1
 I +Y<1 G NEWQ
 D ^IBAFIL
 S IBJ="" F  S IBJ=$O(IBSAVY(IBJ)) Q:IBJ=""  S Y(IBJ)=IBSAVY(IBJ)
 S:+Y>0 Y="1^"_IBTOTL S X=IBSAVX
 ;
NEWQ D:+Y<1 ^IBAERR
 K %,%H,%I,K,X1,X2,X3,IBSERV,IBATYP,IBAFY,IBDUZ,IBNOW,IBSAVX,IBTOTL,IBX,IBT,IBCHRG,IBDESC,IBFAC,IBIL,IBN,IBNOS,IBSEQNO,IBSITE,IBTAG,IBTRAN,IBCRES,IBJ,IBLAST,IBND,IBY,IBPARNT,IBUNIT,IBJ,IBARTYP,IBI,IBSAVY,IBWHER
 Q
 ;
 ;
 ;
ORIG ; Test billing of an original fill.
 I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must also be defined to run this routine.",! Q
 ;
 W !,"Please use this option to bill the original fill of a prescription"
 W !,"which was not billed.  You should select an unbilled prescription"
 W !,"from the detail report generated in 'scan' mode."
 ;
 ; - capture the Pharmacy service
 W !!,"First, please enter any appropriate Pharmacy Division from your system:"
 S PSOREO=1 D OREO^PSOLSET I '$D(PSOSITE) G ORIGQ
 S IBSERV=+$P($G(^PS(59,+PSOSITE,"IB")),"^")
 I '$D(^IBE(350.1,"ANEW",IBSERV,1,1))!'$D(^DIC(49,IBSERV,0)) D  G ORIGQ
 .W !!,*7,"The Pharmacy SERVICE/SECTION value is incorrect in the Pharmacy Site File.",!!
 ;
 ; - main processing loop
 S IBQQ=0 F  D ORIGP Q:IBQQ
 ;
ORIGQ K IBQQ,IBSERV
 K POP,PSOREO,PSOSITE,PSOBAR1,PSOBARS,PSOCLC,PSOCNT,PSODIV,PSODTCUT
 K PSOINST,PSOPAR,PSOPAR7,PSOPRPAS,PSOREO,PSOSITE,PSOSYS
 Q
 ;
ORIGP ; Prompt for prescription; bill it if eligible.
 S DIC="^PSRX(",DIC(0)="QEAMZ" W ! D ^DIC K DIC S IBRX=+Y
 I Y<0 S IBQQ=1 G ORIGPQ
 ;
 S IBRXD=Y(0),IBRXD2=$G(^PSRX(IBRX,2)),IBRXDB=$G(^("IB"))
 S DFN=+$P(IBRXD,"^",2),IBRELD=$P(IBRXD2,"^",13)
 I 'DFN W !!,"There is no patient associated with this prescription!" G ORIGPQ
 S IBDFN=$G(^DPT(DFN,0))
 ;
 ; - display patient information
 W !!,"Patient: ",$P(IBDFN,"^"),"    SSN: ",$$SSN($P(IBDFN,"^",9))
 ;
 ; - be sure prescription is billable
 I '$D(^PS(53,"B","OPT NSC",+$P(IBRXD,"^",3))) W !!,"This prescription does not have the Rx Patient Status 'OPT NSC'." G ORIGPQ
 S IBDEA=$P($G(^PSDRUG(+$P(IBRXD,"^",6),0)),"^",3)
 I IBDEA["S" W !!,"This prescription is for a supply item!" G ORIGPQ
 I IBDEA["I" W !!,"This prescription is for an investigational drug!" G ORIGPQ
 I 'IBRELD W !!,"This prescription has not yet been released!" G ORIGPQ
 I $P(IBRXDB,"^",2) W !!,"This prescription has already been billed!" G ORIGPQ
 I $$RXST^IBARXEU(DFN,IBRELD) W !!,"This patient was exempt from Rx Copay on the prescription release date!" G ORIGPQ
 ;
 ; - okay to bill?
 S DIR(0)="Y",DIR("A")="Is it okay to bill this prescription"
 W ! D ^DIR K DIR I $D(DIRUT)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) S IBQQ=1 G ORIGPQ
 I 'Y G ORIGPQ
 ;
 ; - create the copay charge
 S IBRES=$$BILL(IBRX,0,IBSERV)
 ;
 ; - display results
 I IBRES<0 W !!,"Billing was not performed.  "
 I IBRES=-1 W "The required input could not be verified." G ORIGPQ
 I IBRES=-2 W "The prescription could not be set up for billing." G ORIGPQ
 I IBRES=-3 W "The billing engine identified a problem." G ORIGPQ
 ;
 W !!,"The copay charge was created.  Please check the patient's account."
 ;
ORIGPQ K IBRXD,IBRXD2,IBRXDB,DFN,IBRELD,IBDEA,IBDFN,IBRES
 K DIR,DIRUT,DIROUT,DUOUT,DTOUT
 Q
 ;
SSN(X) ; Format the SSN.
 Q $S($G(X)="":"",1:$E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,11))
