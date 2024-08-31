IBAMTC ;ALB/CPM - MEANS TEST NIGHTLY COMPILATION JOB ; 07 Jun 2021  4:17 PM
 ;;2.0;INTEGRATED BILLING;**34,52,70,93,100,118,115,132,150,153,137,176,215,275,321,312,457,519,549,614,703,706,630,704,760**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
INIT ; Entry point - initialize variables and parameters
 ;
 N X1,X2  ; IB*2.0*760
 ;Set Nightly task flag for Billing Clock query
 N IBNGHTSK
 S IBNGHTSK=1
 D CANCEL($$FMADD^XLFDT(DT,-7),$$NOW^XLFDT(),1) ; cancel copays (covid relief)   IB*2.0*706
 S (IBY,Y)=1 D SITE^IBAUTL I Y<1 S IBY=Y D ERR G CLEAN  ; moved from below  IB*2.0*760
 D CANCCD ; cancel copays (Cleland-Dole)  IB*2.0*760
 ;
 D UPDT^IBARXEPS($$FMADD^XLFDT(DT,-30),DT,1)
 ;
 D NIGHTLY^IBTRKR ; claims tracking nightly update
 ;
 D ^IBCD ; automated biller
 ;
 D RELPR^IBAMTV3 ; auto-release patient charges on hold at least 60 days
 ;
 D EN^IBOHRL ; auto-release patient charges on hold longer than 90 days
 ;
 K IBDT D BJ^IBJDE  ; Automated DM extract monthly background job.
 ;
 ; - transfer pricing background job
 I '+$$SWSTAT^IBBAPI() D ^IBATEI1                           ;IB*2.0*312
 ;
 D NIGHT^IBARXMA ; transmit copay cap info
 ;
 D NOW^%DTC S IBAFY=$$FY^IBOUTL(X),DT=X,U="^"
 S (IBERRN,IBWHER,IBJOB,IBY,Y)=1,IBCNT=0 K ^TMP($J,"IBAMTC")
 D SERV^IBAUTL2 I IBY<1 D ERR G CLEAN
 ;
 ; Compile Means Test copay and per diem charges for all inpatients
 ; Check PFSS Switch                                        ;IB*2.0*312
 ; IB*2.0*549 Remove naked global
 I '+$$SWSTAT^IBBAPI() S (IBWARD,DFN)="" F  S IBWARD=$O(^DPT("CN",IBWARD)) Q:IBWARD=""  F  S DFN=$O(^DPT("CN",IBWARD,DFN)) Q:'DFN  W !,DFN S IBA=^DPT("CN",IBWARD,DFN),IBY=1 D PROC
 ;
 ;send inpatients' CV (CombatVet) expiration e-mail alert
 D CVEXMAIL^IBACV(DT)
 ;
 ;check & start LTC Monthly Job if necessary
 ; This code may need to be expanded, IF we don't          ;IB*2.0*312 
 ; implement on the 1st of the month, for a clean cut over ;IB*2.0*312
 I '+$$SWSTAT^IBBAPI() D NJ^IBAECN1                        ;IB*2.0*312
 ;
 ;Run a nightly process to see if a Patient had the CAT I HRfS flag activated/de-activated during the past two days.
 ; If so generate a bulletin to IB MEANS TEST mailgroup
 D NIGHTLY^IBAMTS3                                                    ;IB*2.0*614
 ;
 D EN^IBCE ; Transmit electronic bills
 ; Clean up expired Means Test billing clocks
CLEAN S %H=+$H-1 D YMD^%DTC S IBDT=X,(IBN,DFN)=0,IBWHER=23
 F  S DFN=$O(^IBE(351,"ACT",DFN)) Q:'DFN  D
 . F  S IBN=$O(^IBE(351,"ACT",DFN,IBN)) Q:'IBN  D
 ..  S IBY=1,X1=IBDT,(X2,IBCLDT)=+$P($G(^IBE(351,+IBN,0)),"^",3) D ^%DTC
 ..  I X>364 S IBCLDA=IBN D CLOCKCL^IBAUTL3,ERR:IBY<1
 ;
 ; Close out incomplete events where the patient has been discharged,
 ; pass the related charges if they appear correct, and send a bulletin
 ; - also, send bulletins on old incomplete charges where there is no
 ; incomplete event
 D MAIN^IBAMTC2
 ;
 ;D ^IBAMTC1
 ;
 ; Send bulletin reporting job completion
 I '+$$SWSTAT^IBBAPI() D BULL^IBAMTC1                     ;IB*2.0*312
 ;
 ; -- purge alerts
 D PURGE^IBAERR3
 ;
 ; purge HPID files -- IB*2.0*519
 ; IB*2.0*549 - PUR^IBCNHUT2 also checks to make sure the HL7 link is still up and
 ;              running properly
 D PUR^IBCNHUT2
 ;
 ; Monitor special inpatient billing cases
 D BGJ^IBAMTI
 ;
 ; Print Pharmacy Copay Exemption Income Test Reminder Letters
 D EN^IBARXEL
 ;
 ; Send HMS extract files to AITC DMI queues
 D SENDEII^IBCNFSND
 ; 
 ; Send info on any Duplicate Transactions that were identified or corrected (IB*2.0*630)
 I $D(^XTMP("IB TRANS")) D XMIT^IBAUTL9
 ;
 ; Kill variables and quit.
 D KILL1
 ;
 I $D(ZTQUEUED),$G(ZTSK) D KILL^%ZTLOAD
 ;
 D UPDTS ; update timestamp  IB*2.0*760
 Q
 ;
 ;
PROC ; Process all currently admitted patients.
 ;
 D IFCVEXP^IBACV(DFN,DT,IBA) ;if CV has expired (see CVEXMAIL^IBACV)
 ;--
 ;1) checks effective date for LTC legislation.
 ;2) determine current treating specialty (TS) for the 
 ;"original" admission.
 ;if TS is LTC: 
 ;  - creates new LTC #350 parent event entry if necessary.
 ;NOTE: It doesn't stop MT billing for LTC. CALC^IBAUTL4 does it.
 I $$ISLTCADM^IBAECN1(DFN,IBA)
 ;--
 D ORIG  ; find "original" admission date
 Q:$$BILST^DGMTUB(DFN)<IBADMDT  ; pat. was last billable before admission
 Q:IBADMDT\1=DT  ; patient was admitted today - process tomorrow
 Q:+$$MVT^DGPMOBS(IBA)  ; admitted for Observation & Examination
 Q:$O(^IBE(351.2,"AC",IBA,0))  ; skip special inpatient admissions
 ;
 ; - if vet is SC, create a Special Inpatient Billing Case
 ;   in file #351.2 (use code 3 for SC, as it is changed to 4 in IBAMTI)
 D ELIG^VADPT I VAEL(3) D ADM^IBAMTI(DFN,IBA,3) Q
 ;
 ; - gather event information
 D EVFIND^IBAUTL3 I 'IBEVDA D BSEC Q:'IBBS  ; wasn't billable yesterday
 S X=IBADMDT D H^%DTC S IBBDT=%H D:'IBEVDA LAST^IBAUTL5
 I IBEVDA,IBEVCAL S X1=IBEVCAL,X2=1 D C^%DTC S IBBDT=%H
 S IBEDT=+$H-1
 ; - gather clock information
 S IBWHER=24 D CLOCK^IBAUTL3 I IBY<1 D ERR G PROCQ
 I IBCLDA S X=IBCLDT D H^%DTC S IBCLCT=IBBDT-%H
 ; - build charges for inpatient days
 D ^IBAUTL4 I IBY<1 D ERR G PROCQ
 ; - pass per diem if over 30 days old, or both per diem and the copay
 ; - if 4 days from patient's statement date; update event, clock
 S IBWHER=22
 I $G(IBCHPDA),$P($G(^IB(+IBCHPDA,0)),"^",6)>30!($$STD^IBAUTL5(DFN)) S IBNOS=IBCHPDA D FILER^IBAUTL5 I IBY<1 D ERR G PROCQ
 I $G(IBCHCDA),$$STD^IBAUTL5(DFN) S IBNOS=IBCHCDA D FILER^IBAUTL5 I IBY<1 D ERR G PROCQ
 I IBEVDA,$D(IBDT) S IBEVCLD=IBDT D EVUPD^IBAUTL3
 I IBCLDA D CLUPD^IBAUTL3
PROCQ D KILL Q
 ;
BSEC ; Determine patient's bed section for the previous day.
 S X1=DT,X2=-1 D C^%DTC
 S VAIP("D")=X_.2359 D IN5^VADPT S IBBS=$$SECT^IBAUTL5(+VAIP(8)) Q
 ;
ERR ; Error processing.  Input:  IBY, IBWHER, IBCNT
 S IBDUZ=DUZ,IBCNT=IBCNT+1 D ^IBAERR1 K IBDUZ Q
 ;S ^TMP($J,"IBAMTC","E",IBERRN)=$P(IBY,"^",2)_"^"_$S($D(DFN):DFN,1:"")_"^"_IBWHER,IBERRN=IBERRN+1 Q
 ;
ORIG ; Find first admission date, considering ASIH movements
 ;  Input:  IBA    Output:  IBADMDT
 N X,Y,Z S Z=IBA
 F  S X=$G(^DGPM(Z,0)),Y=$P(X,"^",21) Q:Y=""  S Z=+$P($G(^DGPM(Y,0)),"^",14)
 S IBADMDT=+X Q
 ;
CANCEL(STRTDT,ENDDT,MSG) ; cancel copays (covid relief)  IB*2.0*703
 ;
 ; STRTDT - starting date (internal)
 ; ENDDT - ending date (internal)
 ; MSG - 0 to skip Mailman bulletin, 1 to send full Mailman bulletin, 2 to send only error report
 ;
 N IBACT,IBCRES,IBDTM,IBECODE,IBEMSG,IBFR,IBIEN,IBN0,IBRES,IBSRVFR,IBSRVTO,IBSTAT,IBTO,IBXA,STATSTR
 ; service dates
 S IBSRVFR=3200406                 ; start date 04/06/20
 S IBSRVTO=$P(^IBE(350.9,1,71),U)  ; end date comes from 350.9/71.01
 S STATSTR="^BILLED^HOLD - RATE^HOLD - REVIEW^INCOMPLETE^ON HOLD^"  ; bill statuses to include  IB*2.0*703
 ;
 I MSG K ^TMP("IBAMTC3",$J)
 S IBDTM=STRTDT F  S IBDTM=$O(^IB("D",IBDTM)) Q:'IBDTM!(IBDTM'<ENDDT)  D
 .S IBIEN=0 F  S IBIEN=$O(^IB("D",IBDTM,IBIEN)) Q:'IBIEN  D
 ..S IBN0=^IB(IBIEN,0)  ; file 350, node 0
 ..S IBSTAT=$$GET1^DIQ(350,IBIEN_",",.05)  ; status from 350/.05 (external)
 ..I STATSTR'[(U_IBSTAT_U) Q  ; only cancel copays with specific status  IB*2.0*703
 ..S IBACT=$G(^IBE(350.1,+$P(IBN0,U,3),0))  ; node 0 in file 350.1 for the action type of this charge
 ..I $P(IBACT,U,5)'=1 Q  ; action type is not "New"
 ..S IBXA=$P(IBACT,U,11)  ; billing group
 ..I IBXA=6!(IBXA=7) Q  ; skip CHAMPVA/TRICARE charges
 ..I IBSTAT="INCOMPLETE",IBXA=4!(IBXA=5) Q
 ..S IBFR=+$P(IBN0,U,14) I IBFR>IBSRVTO Q  ; Bill From date is outside the range
 ..S IBTO=+$P(IBN0,U,15) I IBTO<IBSRVFR Q  ; Bill To date is outside the range
 ..; cancel this copay with "pandemic response" reason
 ..S IBCRES=$O(^IBE(350.3,"B","PANDEMIC RESPONSE",0))
 ..S IBRES=$$CANCEL^IBECEAU6(IBIEN,IBCRES,0,0)
 ..I MSG>0 D
 ...I +IBRES<0 D  Q
 ....S IBECODE=$P(IBRES,U,2),IBEMSG=$S(IBECODE'="":$P($G(^IBE(350.8,+$O(^IBE(350.8,"AC",$P(IBECODE,";"),0)),0)),U,2),1:$P(IBRES,U,3))
 ....S ^TMP("IBAMTC3",$J,0,$P(IBN0,U))=$P(IBN0,U,11)_U_IBEMSG Q
 ....Q
 ...I MSG<2 S ^TMP("IBAMTC3",$J,1,$P(IBN0,U))=$P(IBN0,U,11)
 ..Q
 .Q
 ; send Mailman bulletin
 I MSG D CANCBLTN^IBAMTC3 K ^TMP("IBAMTC3",$J)
 Q
 ;
KILL1 ; Kill all IB variables.
 K VAERR,VAEL,VAIP,IBA,IBADMDT,IBAFY,IBATYP,IBBDT,IBBS,IBCHARG,IBCHG,IBCNT,IBCUR,IBDESC,IBDISDT,IBDT,IBDUZ,IBFAC,IBI,IBIL,IBJOB,IBLC,IBMAX
 K IBN,IBNOS,IBSAVBS,IBSEQNO,IBSERV,IBSITE,IBSL,IBTRAN,IBX,IBY,IBWHER,IBWARD,IBEDT,IBCHCTY,IBCHPDE,IBERRN,IBASIH,IBRTED
KILL ; Kill all IB variables needed to build charges.
 K IBCLCT,IBCLDA,IBCLDT,IBCLDAY,IBCLDOL,IBCHPDA,IBCHCDA,IBCHG,IBCHFR,IBCHTO,IBCHTOTL,IBBS,IBNH
 K IBEVDA,IBEVDT,IBEVCLD,IBEVCAL,IBEVNEW,IBEVOLD,IBMED,IBTOTL,IBDESC,IBIL,IBTRAN,IBATYP,IBDATE
 Q
 ;
UPDTS ; update completion timestamp (350.9/.17)  IB*2.0*760
 N FDA
 S FDA(350.9,"1,",.17)=$$NOW^XLFDT()
 D FILE^DIE("","FDA")
 Q
 ;
CANCCD ; cancel copays (Cleland-Dole)  IB*2.0*760
 N DFN,IBCRES,IBDTM,IBERROR,IBEVDT,IBFREE,IBIEN,IBIEN1,IBN0,IBRTN,IBSTAT,IBVSTIEN,IBVSTAT,STATSTR,Z
 S STATSTR="^BILLED^HOLD - RATE^HOLD - REVIEW^ON HOLD^"  ; bill statuses to include
 S IBDTM=$$GET1^DIQ(350.9,"1,",.17,"I") I IBDTM'>0 S IBDTM=$$FMADD^XLFDT(DT,-1)
 F  S IBDTM=$O(^IB("D",IBDTM)) Q:'IBDTM  D
 .S IBIEN=0 F  S IBIEN=$O(^IB("D",IBDTM,IBIEN)) Q:'IBIEN  D
 ..S IBN0=^IB(IBIEN,0)  ; file 350, node 0
 ..S IBIEN1=$P(IBN0,U,9)  ; parent charge ien
 ..I IBIEN'=IBIEN1 Q  ; not the parent charge
 ..S IBSTAT=$$GET1^DIQ(350,IBIEN_",",.05)  ; status from 350/.05 (external)
 ..I STATSTR'[(U_IBSTAT_U) Q  ; only cancel copays with specific status
 ..S IBACT=$G(^IBE(350.1,+$P(IBN0,U,3),0))  ; node 0 in file 350.1 for the action type of this charge
 ..I $P(IBACT,U,5)'=1 Q  ; action type is not "New"
 ..I $$ISCMPCT(IBIEN) Q  ; COMPACT Act related
 ..I '$$ISCLDL(IBIEN) Q  ; not Cleland-Dole eligible
 ..S DFN=$P(IBN0,U,2),IBEVDT=$P(IBN0,U,17)
 ..S IBCRES=$O(^IBE(350.3,"B","CLELAND-DOLE",0))
 ..S Z=$$FNDMHVST(DFN,IBEVDT),IBVSTIEN=$P(Z,U),IBVSTAT=$P(Z,U,2)  ; find exisiting visit
 ..S IBFREE=$$GETMHFR(DFN,IBEVDT)  ; 1 if there's a free visit on this date
 ..I IBFREE D  Q
 ...S IBRTN=$$CANCEL^IBECEAU6(IBIEN,IBCRES,0,0)  ; cancel this copay with "Cleland-Dole" reason
 ...I IBVSTIEN,IBVSTAT'=1 S IBRTN=$$UPDATE^IBECEAMH(1,IBVSTIEN,4,"",2,1,.IBERROR)  ; update to visit only
 ...Q
 ..; check if there are free visits available
 ..I $$NUMVSTCK^IBECEAMH(DFN,IBEVDT) D  Q
 ...S IBRTN=$$CANCEL^IBECEAU6(IBIEN,IBCRES,0,0)  ; cancel this copay with "Cleland-Dole" reason
 ...I IBVSTIEN,IBVSTAT'=1 S IBRTN=$$UPDATE^IBECEAMH(1,IBVSTIEN,1,"",2,1,.IBERROR) Q  ; update to free visit
 ...; if there's no visit for this date, add a free visit
 ...I 'IBVSTIEN D ADDVST^IBECEAMH(DFN,IBEVDT,"",1,2)
 ...Q
 ..I $O(^IBMH(351.83,"D",IBIEN,"")) Q  ; corresponding MH visit entry already exists
 ..D ADDVST^IBECEAMH(DFN,IBEVDT,IBIEN,2)  ; add "billed" MH visit entry
 ..Q
 .Q
 Q
 ;
UPDCANC(IBIEN) ; update MH visit tracking for cancelled copay
 N IBERROR,IBRTN,IBSTAT,IBVSTIEN
 I 'IBIEN Q
 S IBSTAT=$$GET1^DIQ(350,IBIEN_",",.05)  ; status from 350/.05 (external)
 I IBSTAT="CANCELLED" D
 .; if there's a "billed" visit tracking entry linked to a cancelled copay, change that entry to "visit only" / "duplicate visit" reason
 .S IBVSTIEN=$O(^IBMH(351.83,"D",IBIEN,"")) I 'IBVSTIEN Q
 .I $P(^IBMH(351.83,IBVSTIEN,0),U,4)=2 S IBRTN=$$UPDATE^IBECEAMH(1,IBVSTIEN,4,"",4,1,.IBERROR)
 .Q
 Q
 ;
FNDMHVST(DFN,IBEVDT) ; find existing MH visit on a given date  IB*2.0*760
 ;
 ; DFN - patient's DFN
 ; IBEVDT - date to search for (internal)
 ;
 ; returns "file 351.83 ien ^ visit status (351.83/.04)" if visit was found, 0 otherwise
 ;
 N IBSTAT,IBVSTIEN,RES
 I $G(IBEVDT)'>0!$G(DFN)'>0 Q 0
 S RES=0
 S IBVSTIEN="" F  S IBVSTIEN=$O(^IBMH(351.83,"VD",IBEVDT,IBVSTIEN),-1) Q:'IBVSTIEN!+RES  D
 .I '$D(^IBMH(351.83,"B",DFN,IBVSTIEN)) Q  ; different patient
 .S IBSTAT=$P(^IBMH(351.83,IBVSTIEN,0),U,4) I IBSTAT=3 Q  ; removed visit
 .S RES=IBVSTIEN_U_IBSTAT
 .Q
 Q RES
 ;
GETMHFR(DFN,IBEVDT) ; check if there's an existing free MH visit on a given date  IB*2.0*760
 ;
 ; DFN - patient's DFN
 ; IBEVDT - date to search for (internal)
 ;
 ; returns 1 if free visit was found, 0 otherwise
 ;
 N IBSTAT,IBVSTIEN,RES
 I $G(IBEVDT)'>0!$G(DFN)'>0 Q 0
 S RES=0
 S IBVSTIEN="" F  S IBVSTIEN=$O(^IBMH(351.83,"VD",IBEVDT,IBVSTIEN),-1) Q:'IBVSTIEN!+RES  D
 .I '$D(^IBMH(351.83,"B",DFN,IBVSTIEN)) Q  ; different patient
 .S IBSTAT=$P(^IBMH(351.83,IBVSTIEN,0),U,4) I IBSTAT'=1 Q  ; not a free visit
 .S RES=1
 .Q
 Q RES
 ;
ISCLDL(IBN) ; check if charge is Cleland-Dole eligible  IB*2.0*760
 ;
 ; IBN - file 350 ien
 ;
 ; returns 1 if charge is Cleland-Dole eligible, 0 otherwise
 ;
 N IBATYP,IBATYPN,IBDATA,RES,Z
 S RES=0 I $G(IBN)'>0 Q 0  ; invalid ien
 S IBDATA=$G(^IB(IBN,0))
 S IBATYP=$P(IBDATA,U,3) I 'IBATYP Q 0
 S IBATYPN=$P($G(^IBE(350.1,IBATYP,0)),U) I IBATYPN'["OPT" Q 0  ; not an outpatient charge
 I IBATYPN["CC MH" Q 1
 I $$ISCDCANC^IBECEAMH(IBN) Q 1
 S Z=$P($P(IBDATA,U,4),";") I $P(Z,":")'="409.68" Q 0
 Q $$OECHK^IBECEAMH($P(Z,":",2),$P(IBDATA,U,17))
 ;
ISCMPCT(IBN) ; check if charge is COMPACT Act related  IB*2.0*760
 ;
 ; IBN - file 350 ien
 ;
 ; returns 1 if charge is COMPACT Act related, 0 otherwise
 ;
 N DFN,IBCHTYPE,I,IBCPTARY,IBDATA,IBDXARY,IBDXLIST,IBPCE,IBRF,IBRFFL,RES
 S RES=0 I $G(IBN)'>0 Q RES  ; invalid ien
 S IBDATA=$G(^IB(IBN,0))
 S DFN=$P(IBDATA,U,2) I '$$ISELIG^IBOMHC(DFN) Q RES  ; patient is not eligible
 ; parse "resulting from" field
 S IBRF=$P(IBDATA,U,4) I IBRF'[":" Q RES
 S IBRFFL=$P(IBRF,":")
 ;
 S IBCHTYPE=$P(IBDATA,U,3) I IBCHTYPE="" Q RES
 I $$GET1^DIQ(350.1,IBCHTYPE,.05,"E")'="NEW" Q RES
 ; If RX copay, quit.
 I $$GET1^DIQ(350.1,IBCHTYPE,.11,"I")=5 Q RES
 D GETDX(.IBDXLIST)
 ; If file is 45 (PTF), lookup the primary and Secondary diagnoses
 I IBRFFL=45 D GETPTFDX^IBOMHC($P(IBRF,":",2),.IBDXARY)
 ; If file is 409.68, lookup the diagnoses using OPTDX^IBCSC4D
 I IBRFFL=409.68 S IBPCE=$P(IBRF,":",2) D GETPCEDX^IBOMHC(IBPCE,.IBDXARY),GETPCECP^IBOMHC(IBPCE,.IBCPTARY)
 ; If file is 405, grab the PTF or Diagnoses Text Strings.
 I IBRFFL=405 D GETPMDX^IBOMHC($P(IBRF,":",2),.IBDXARY)
 S I="" F  S I=$O(IBDXARY(I)) Q:I=""  D  Q:RES
 .I $D(IBCPTARY("T2034")) S RES=1 Q  ; If there's T2034 cpt code, copay is eligible
 .I I="R45.851",$D(IBCPTARY("80939")) S RES=1 Q  ; If Dx is R45.851 and CPT code is 80939, copay is eligible
 .I $D(IBDXLIST(I)) S RES=1  ; If Dx is one the list, copay is eligible
 .Q
 Q RES
 ;
GETDX(IBDXLIST) ; Populate the list of Comact Act eligible DX codes  IB*2.0*760
 ;
 ; IBDLIST  - resulting array of Dx codes, passed by reference
 ;
 N I,IBDATA,IBDXD
 ; Retrieve Specific Diagnosis codes
 F I=1:1 S IBDATA=$T(DXSLIST+I) S IBDXD=$P(IBDATA,";",3) Q:IBDXD="EXIT"  S IBDXLIST(IBDXD)=0
 ;
 Q
 ;
DXSLIST ; List of Specific Compact Act Related Diagnosis codes  IB*2.0*760
 ;;T14.91XA
 ;;T14.91XD
 ;;T14.91XS
 ;;EXIT
 Q
