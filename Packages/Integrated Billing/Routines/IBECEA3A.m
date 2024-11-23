IBECEA3A ;EDE/YMG - Cancel/Edit/Add... Add a Charge (cont.); 04/03/2024
 ;;2.0;INTEGRATED BILLING;**729**;21-MAR-94;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CHKLTC(DFN,IBFR) ; check the LTC billing clock
 ;
 ; DFN - patient's DFN
 ; IBFR - "bill from" date (internal)
 ;
 ; returns "1 ^ LTC clock ien" on success, 0 on error
 ;
 N IBCLDA,IBCLDY,IBCLEDT,IBCLSTDT,IBCLZ,IBDT,IBNOCL,IBRES
 S IBRES=1,IBNOCL=0
 ; get the latest LTC clock
 S (IBCLSTDT,IBCLEDT)=0,IBCLDA=$$FNDOPEN^IBAECU4(DFN)
 I IBCLDA S IBCLZ=^IBA(351.81,IBCLDA,0),IBCLSTDT=$P(IBCLZ,U,3),IBCLEDT=$P(IBCLZ,U,4),IBCLDY=+$P(IBCLZ,U,6)
 ; is IBFR within date range of the LTC clock?
 I IBFR<IBCLSTDT D
 .S IBDT=+$O(^IBA(351.81,"AE",DFN,IBFR),-1) I IBDT>0 D  Q  ; found a previous LTC clock, try to use this one
 ..S IBCLDA=+$O(^IBA(351.81,"AE",DFN,IBDT,""),-1) I 'IBCLDA S IBRES=0,IBNOCL=1 Q
 ..S IBCLDY=+$P(^IBA(351.81,IBCLDA,0),U,6)
 ..W !!,"This charge will be applied to the following closed LTC clock:"
 ..W !,"Start Date: ",$$FMTE^XLFDT(IBDT),"  Free Days Remaining: ",IBCLDY
 ..I IBCLDY D LTCFDAYS(IBCLDA) S IBRES=0
 ..Q
 I IBFR>IBCLEDT D
 .; date of service if past exp.date of the clock - ask user if they want to open a new LTC clock
 .I $$ASKLTC() D  Q
 ..S IBCLDA=$$OPTB^IBAECC(DFN,IBCLDA,IBCLEDT,IBFR)
 ..S:'IBCLDA IBRES=0,IBNOCL=1
 ..I IBRES,+$P(^IBA(351.81,IBCLDA,0),U,6) D LTCFDAYS(IBCLDA) S IBRES=0
 ..Q
 .; user didn't want to open a new clock
 .W !!,"The Open LTC Billing Clock detected for the patient has expired."
 .W !,"Please Open a New Clock and apply any available Free Days before"
 .W !,"continuing to charge this copayment.",!
 .D ASKCONT^IBAECC W !
 .S IBRES=0
 .Q
 I IBFR'<IBCLSTDT,IBFR'>IBCLEDT D
 .; use the current LTC clock
 .W !!,"This charge will be applied to the following open LTC clock:"
 .W !,"Start Date: ",$$FMTE^XLFDT(IBCLSTDT),"  Free Days Remaining: ",IBCLDY
 .I IBCLDY D LTCFDAYS(IBCLDA) S IBRES=0
 .Q
 I 'IBRES,IBNOCL W !!,"The patient has no LTC clock active for this date.",!
 Q $S(IBRES>0:IBRES_U_IBCLDA,1:IBRES)
 ;
ASKLTC() ; LTC clock confirmation prompt
 ;
 ; returns 1 for "yes", or 0 otherwise
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 W !
 S DIR("A",1)="The Date of Service entered is beyond the end of the current clock."
 S DIR("A")="Do you wish to close this LTC clock and start a new LTC clock? (Y/N): "
 S DIR(0)="YAO"
 D ^DIR
 Q $S(+Y=1:1,1:0)
 ; 
LTCFDAYS(IBLTCX) ; edit LTC free days
 ;
 ; IBLTCX - file 351.81 ien, used in FREE^IBAECC
 ;
 N Z
 N IBLTCZ  ; used in FREE^IBAECC
 S Z=$$ASKLTCFR()
 I Z S IBLTCZ=^IBA(351.81,IBLTCX,0) D  Q
 .I '$D(VADM(1)) D DEM^VADPT  ; make sure that VADM(1) is available for FREE^IBAECC
 .D FREE^IBAECC
 .Q
 W !!,"Unable to continue billing this charge. LTC Free days are still available.",!
 Q
 ;
ASKLTCFR() ; LTC clock free days confirmation prompt
 ;
 ; returns 1 for "yes", or 0 otherwise
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 W !
 S DIR("A",1)="The patient must use his free days first."
 S DIR("A")="Would you like to enter the patient's Free LTC Days? (Y/N): "
 S DIR(0)="YAO"
 D ^DIR
 Q $S(+Y=1:1,1:0)
 ;
DUP(DFN,IBFR,IBCHG) ; check for duplicate copays
 ;
 ; DFN - patient's DFN
 ; IBFR - "bill from" date (internal)
 ; IBCHG - charge amount
 ;
 ; returns 1 if we should continue adding the charge, 0 otherwise
 ;
 N IBDPAMT,IBDPDATA,IBDPXA,IBDUPIEN
 S IBDUPIEN=$$BFCHK^IBECEAU(DFN,IBFR) I 'IBDUPIEN Q 1
 S IBDPDATA=$$DUPINFO(IBDUPIEN),IBDPXA=$P(IBDPDATA,U,2),IBDPAMT=$P(IBDPDATA,U)
 D PRTWRN
 I IBDPXA'=4,IBDPXA'=8 Q 0  ; If an inpatient Med, warn user and prevent further billing
 I 'IBCHG!(IBCHG>IBDPAMT) Q $$CANDUP(IBDUPIEN)  ; The new Outpatient charge is greater than existing charge.
 Q 0
 ;
DUPINFO(IBIEN) ;Retrieve the needed information from the duplicate bill 
 ;Input - IEN of the Bill already charged on that date
 ;Output - Amount ^ Billing Group
 N IBDATA0,IBDPIEN,IBDPXA
 S IBDATA0=$G(^IB(IBIEN,0))
 S IBDPIEN=$P(IBDATA0,U,3)
 S IBDPXA=$$GET1^DIQ(350.1,IBDPIEN_",",.11,"I")
 Q $P(IBDATA0,U,7)_U_IBDPXA
 ;
PRTWRN ; Print warning message about medical copayment already applied 
 ;
 W !!!,"This patient has already been billed a medical copayment for this date."
 W !,"Please review the associated dates and charges for this patient.",!
 Q
 ;
CANDUP(IBN) ;Cancel the duplicate copay if the user wishes to.
 ;
 ;INPUT -   IBN - IEN for the Copay to be cancelled (File 350)
 ;OUTPUT -  0   - Didn't Cancel the copay
 ;          1   - Cancelled the Copay
 ;
 ;Display Duplicate Copay
 ;Get the info
 N IBFRDT,IBTODT,IBACTY,IBSTCD,IBBLNM,IBSTAT,IBCHRG,IBI
 N DIR,DIRUT,DUOUT,X,Y,IBY
 S IBFRDT=$$GET1^DIQ(350,IBN_",",.14,"I")
 S IBFRDT=$$FMTE^XLFDT(IBFRDT,"2Z")
 S IBTODT=$$GET1^DIQ(350,IBN_",",.15,"I")
 S IBTODT=$$FMTE^XLFDT(IBTODT,"2Z")
 S IBACTY=$$GET1^DIQ(350,IBN_",",.03,"E")
 S IBSTCD=$$GET1^DIQ(350,IBN_",",.2,"E")
 S IBSTAT=$$GET1^DIQ(350,IBN_",",.05,"E")
 S IBBLNM=$$GET1^DIQ(350,IBN_",",.11,"E")
 S IBCHRG=$$GET1^DIQ(350,IBN_",",.07,"E")
 W !,"BILL",?10,"BILL",?40,"STOP",?45,"BILL",!
 W "FROM",?10," TO",?21,"CHARGE TYPE",?40,"CODE",?45,"NUMBER",?60,"STATUS",?70,"CHARGE",!
 F IBI=1:1:80 W "-"
 W !,IBFRDT,?10,IBTODT,?21,$E(IBACTY,1,17),?40,IBSTCD,?45,IBBLNM,?60,IBSTAT,?70,IBCHRG,!
 ;
 W !     ;force a line feed between the messages
 S IBY=-1   ; Default exit value
 S DIR(0)="YA"
 S DIR("A",1)="Do you wish to cancel this existing copayment and continue billing the current",DIR("A")="copayment?  : "
 D ^DIR
 S IBY=+Y
 W !     ;force a line feed between the messages
 ;
 ;Quit if user does not answer yes.
 I +IBY<1 W !,"The existing copayment was not cancelled. " Q 0
 ; Cancel the copay.
 I +$$CANCAPI^IBECEA4(IBN)<0 W !!,"The copayment was not cancelled." Q 0
 W !!,"The copayment was cancelled.  Please continue adding the new copay."
 ;
 R !!,?10,"Press any key to continue.    ",IBX:DTIME
 ;
 Q 1
