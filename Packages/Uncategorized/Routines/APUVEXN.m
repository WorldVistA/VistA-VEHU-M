APUVEXN ; 648/BFD RENEWAL ROUTINE CALLED IF I OR N PARAMETER ; 1-12-04
 ;;5.0; PORTLAND,OR APPLICATION
 ;
 ; VA Utilities for MAudio Care (renewals) 
 ;  INCLUDES CHANGES TO MAKE NEW VEXRX (BAY PINES) WORK
 ;
 ;Site chose Info Alert 
 ;  There are two 'types' of information alerts
 ;    1.  Site chose Info Alerts instead of Unsigned Notification (IALERT)
 ;    2.  Site chose to send an Info Alert if drug is marked with a W or a 2 (NALERT)
 ;  
 ; 7-22-06:  Originally APUVEX was one routine but when tried to packman to
 ; Beta sites, found it was over the SACC limit.  Now split into APUVEX1 (one called
 ; from VEXRX) and APUVEX2 (one called from APUVEX1
 ;
 ; 1-16-07:  Change APUVEX2 to APUVEXI.  This is for Info Alerts (not 2 or W)
 ; 3-26-07:  Remove the sections of code no longer called so that rtn meets size stds for export
 ; 4-11-07:  Add the code for 'N' since it is an alert, not need separate routine
 ;  Change routine from APUVEXI to APUVEXN so not confuse with APUVEX1 (number one at the end)
 ;
IALERT ; 3-26-07:  Called by APUVEX1 (PDX no longer use MHPCP so will remove from rtn at later date)
 ; 
 S PROV=0
 I PROVP="A" S PROV=$P(^PSRX(PRESC,0),"^",4) G ONAL
 I +PCP,$$CH S PROV=+PCP G:PROV>0 ONAL   ; PCP
 I +PMHCP,$$CH1 S PROV=+PMHCP G:PROV>0 ONAL    ; MHPCP
 I PROV'>0 S RESULT1=0 D BLD     ; Not by PCP or MHPCP
 Q
 ;
ONAL ; Called from within APUVEXN
 N NAME
 D PROVCHK I FMSG=2 D BLD Q
 S VRX=$P(^PSRX(PRESC,0),"^",6),VRX=$P(^PSDRUG(VRX,0),"^",1)
 S XQA(PROV)=""
 ;S XQA(DUZ)=""  ; This sent to me for testing but if sites want to prov wrote Rx, can use get prov DUZ from 52 & chg variable
 S XQAID="MAUDIO;"
 S NAME=$P(^DPT(DFN,0),"^",1,9)
 S XQAMSG=$E($P(NAME,"^"),1,9)_" ("_$E(NAME)_$E($P(NAME,"^",9),6,9)_"): Rx Renewal Request for "_VRX
 D SETUP^XQALERT
 S RESULT1=1,INFPKTR=INFPKTR+1,PCONT=1
 Q
 ;
NALERT ; 3-26-07:  Called by APUVEXN (PDX no longer use MHPCP so will remove from rtn at later date)
 S PROV=0
 I PROVP="A" S PROV=$P(^PSRX(PRESC,0),"^",4) G NNAL
 I +PCP,$$CH S PROV=+PCP G:PROV>0 NNAL   ; PCP
 I +PMHCP,$$CH1 S PROV=+PMHCP G:PROV>0 NNAL    ; MHPCP
 I PROV'>0 S RESULT1=0 D BLD     ; Not by PCP or MHPCP
 Q
 ;
NNAL ; Called from within APUVEXN
 N NAME
 D PROVCHK I FMSG=2 D BLD Q
 S VRX=$P(^PSRX(PRESC,0),"^",6),VRX=$P(^PSDRUG(VRX,0),"^",1)
 S XQA(PROV)=""
 ;S XQA(DUZ)=""  ; This sent to me for testing but if sites want to prov wrote Rx, can use get prov DUZ from 52 & chg variable
 S XQAID="MAUDIO;"
 S NAME=$P(^DPT(DFN,0),"^",1,9)
 S XQAMSG=$E($P(NAME,"^"),1,9)_" ("_$E(NAME)_$E($P(NAME,"^",9),6,9)_"): Rx Renewal Request for "_VRX_" ** DRUG NOT ALLOW AUTO RENEWAL **"
 D SETUP^XQALERT
 S RESULT1=1,INFPDNKT=INFPDNKT+1,PCONT=1
 Q
 ;
BLD ; 3-26-07:  Called from within APUVEXN 
 ;Add request to mail message 
 ;
 ;W !!,"Came to BLD"
 ;W !,"FMSG is "_FMSG_" and Result passing back is "_RESULT1
 S DRGN=$P(^PSRX(PRESC,0),"^",6),DRGNM=$E($P(^PSDRUG(DRGN,0),"^",1),1,15)
 ; For 'U' or 'N':  Set provider duz and provider name in ROB
 I TYPE="I" S PROVN=$P(^PSRX(PRESC,0),"^",4),PROVNM=$E($P(^VA(200,PROVN,0),"^",1),1,15)
 S PTNM=$P(^DPT(DFN,0),"^",1),PTNM=$E(PTNM,1,10),LST4=$E($P(^DPT(DFN,0),"^",9),6,9)
 I FMSG=2 D FM2^APUVEXE  ; Provider disabled in vista
 I FMSG=1 D FM1^APUVEXE  ; Patient is in Fee Basis file
 I FMSG=0 D FM0^APUVEXE  ; Parameter set for only PCP/MHPCP & Rx not from either
 I FMSG=4 D FM4^APUVEXE      ; Problem w/previous order so can't create new one using it as template - human needed
 I FMSG=3 D FM3^APUVEXE  ; Human intervention since vet called so not communicate w/provider
 I FMSG=5 D FM5^APUVEXE  ; Patient not have PCP/MHPCP and 'P' parameter is set
 I FMSG=6 D FM6^APUVEXE  ; Drug is inactive - send msg to group so can 'handle'
 I FMSG=7 D FM7^APUVEXE  ; The 'placer order' is no longer in 100 so must put on mail msg
 S CNT=CNT+1
 S MAFBFD(CNT)="  "
 S CNT=CNT+1
 ;W !,"At bottom of BLD and CNT is "_CNT
 Q
 ;
PROVCHK ; 3-26-07:  Called from within APUVEXN 
 ; I FMSG=2 then provider that wrote is terminated
 S TERMD=$G(^VA(200,PROV,0)) S TERMD=$P(TERMD,"^",11) I TERMD'="" S RESULT1=0,FMSG=2 Q
 S DISD=$G(^VA(200,PROV,0)) S DISD=$P(DISD,"^",7) I DISD=1!(DISD["Y")!(DISD["y") S RESULT1=0,FMSG=2 Q
 Q
 ;
 ;
CH() ;Check for PCP match in prescription (jeb code)
 ;;PCP=PRESCRIPTION PROVIDER: 1
 ;;ELSE                     : 0
 ;
 Q $S(+PCP=$P($G(^PSRX(PRESC,0)),"^",4):1,1:0)
 ;
CH1() ;Check for MHPCP match in prescription (jeb code)
 ;;PCP=PRESCRIPTION PROVIDER: 1
 ;;ELSE                     : 0
 ;
 Q $S(+PMHCP=$P($G(^PSRX(PRESC,0)),"^",4):1,1:0)
