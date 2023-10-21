IBOTR2 ;ALB/CPM - INSURANCE PAYMENT TREND REPORT - COMPILATION ;5-JUN-91
 ;;2.0;INTEGRATED BILLING;**21,42,52,80,100,118,128,451,447,529,752**;21-MAR-94;Build 20
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCROTR2
 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOTR-2" D T0^%ZOSV ;start rt clock
 ;
 I $G(IBXTRACT) D E^IBJDE(8,1) ; Change extract status.
 ;
 K ^TMP($J) S IBQUIT=0
 S IBDA="" F  S IBDA=$O(^DGCR(399,"AD",IBRT,IBDA)) Q:'IBDA  D  Q:IBQUIT
 .D COMP I IBDA#100=0 S IBQUIT=$$STOP^IBOUTL("Trend Report")
 ;
 ; - Write the output report.
 I 'IBQUIT D
 .I 'IBSDIV D:"OP"[IBSORT SORT D EN^IBOTR3(0) Q
 .S IBDIV=0 F  S IBDIV=$S('VAUTD:$O(VAUTD(IBDIV)),1:$O(^DG(40.8,IBDIV))) Q:'IBDIV  D:"OP"[IBSORT SORT D EN^IBOTR3(IBDIV) Q:IBQUIT
 ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOTR2" D T1^%ZOSV ;stop rt clock
ENQ I $D(ZTQUEUED) S ZTREQ="@" Q
 K IB,IBAO,IBAP,IBCNT,IBDA,DFN,IBBC,DIC,DA,DR,DIQ,IBDP,IBDBC,IBSCF,IBSCT
 K IBCFL,IBDIV,IBQUIT,IBEVT,IBPTIN,IBPFLAG,^TMP($J) D ^%ZISC
 Q
 ;
COMP ; - Compile Bill-Accounts Receivable records for report.
 ; IB*752/DTG - new var for insurance company range check
 N IBINCKN S IBINCKN=""
 ;
 S IBD=$G(^DGCR(399,IBDA,0)) I IBD="" Q
 ;
 ; - Get division, if necessary.
 I 'IBSDIV S IBDIV=0
 E  S IBDIV=$$DIV^IBJDF2(IBDA) I 'IBDIV S IBDIV=+$$PRIM^VASITE()
 I IBSDIV,'VAUTD,'$D(VAUTD(IBDIV)) Q  ;  Not a selected division.
 ;
 ; - Exclude receivables referred to Regional Counsel, if necessary.
 I 'IBINRC,$P($G(^PRCA(430,IBDA,6)),U,4) Q
 ;
 ; IB*2.0*451 - get EEOB indicator '%' for bill
 S IBPFLAG=$$EEOB^IBOA31(IBDA) ; get 1st/3rd party payment when applicable
 ;
 S IBBN=$P(IBD,U),DFN=+$P(IBD,U,2),IBEVT=+$P(IBD,U,3),IBBC=$P(IBD,U,5)
 S:IBBN="" IBBN="NULL" Q:IBBRT="O"&("12"[IBBC)  Q:IBBRT="I"&("34"[IBBC)
 S IBDBC=$$CLO^PRCAFN(IBDA) Q:IBARST="O"&(IBDBC>-2)!(IBARST="C"&(IBDBC<-1))
 I IBDBC>0 S IBBN=$G(IBPFLAG)_IBBN_"*" ; add EEOB indicator
 E  S IBD=$P($$STA^PRCAFN(IBDA),U,2),IBDBC=$S($L(IBD)>8:$E(IBD,1,8),1:IBD)
 I $D(IBBRN),IBBRN="S" S IBBRTY=$S("12"[IBBC:"I",1:"O")
 ;
 ; - Perform edits for insurance company.
 S IBD=$P($G(^DGCR(399,IBDA,"MP")),U),IBINS=$P($G(^DIC(36,+IBD,0)),U)
 I $G(IBICPT) Q:'$D(IBICPT(+IBD))  G CANC
 I IBICF'="@",IBD="" Q
 I $D(IBIC) Q:IBIC="ALL"&(IBD="")  Q:IBIC="NULL"&(IBD]"")
 I IBINS="" S IBINS="UNKNOWN" G CANC
 I $G(IBIC)="ALL" G CANC
 I IBICF="@",IBICL="zzzzz" G CANC
 ; IB*752/DTG - new var for insurance company range check
 S IBINCKN=$$UP^XLFSTR(IBINS)
 ;I IBICF]IBINS!(IBINS]IBICL) Q
 I IBICFU]$E(IBINCKN,1,$L(IBICFU))!($E(IBINCKN,1,$L(IBICLU))]IBICLU) Q
 ;
CANC ; - Keep cancelled bills if CANCEL BILL? field was selected or answer
 ;   to 'Do you want to include cancelled receivables?' prompt was YES.
 S IBCFL=0
 ;
 ;IB*2.0*529 - add Payer TIN to Insurance name for report output
 S IBPTIN=$$PTIN(IBDA)  ; Retrieve Payer TIN
 S:IBPTIN="" IBPTIN="UNKNOWN"
 S IBINS=IBINS_"~~"_IBPTIN_"@@"_IBD
 ;
 Q:'$D(^DGCR(399,IBDA,"S"))  S IBD=^("S")
 S IBCNC=0 I "^26^39^"[(U_$P($G(^PRCA(430,IBDA,0)),U,8)_U) S IBCNC=1
 I $G(IBCANC),($P(IBD,U,16)!(IBCNC)) S IBCFL=1 G PTDE ; Add canc. bill.
 I $G(IBAF)'=16 Q:$P(IBD,U,16)!(IBCNC)  ;      Bill has been cancelled.
 ;
PTDE ; - Perform Printed/Treatment date edits.
 S IBDP=$P(IBD,U,12)
 I IBDF=1 Q:IBDP<IBBDT!(IBDP>IBEDT)  ;   Date printed is out of range.
 S IBD=$G(^DGCR(399,IBDA,"U")),IBSCF=$P(IBD,U),IBSCT=$P(IBD,U,2)
 I IBDF=2 Q:IBSCT<IBBDT!(IBSCF>IBEDT)  ; Treatment dates out of range.
 I '$D(IBAF) G BUILD
 ;
 ; - Find the selected field value and compare to selection parameters.
 K IB S DIC=399,DA=IBDA,DR=IBAF,DIQ="IB" S:IBAFD DIQ(0)="I"
 D EN^DIQ1 K DIQ S:IBAFD IB(399,IBDA,IBAF)=IB(399,IBDA,IBAF,"I")
 S IB=$G(IB(399,IBDA,IBAF)) I IB="",IBAFF'="@" Q
 I $D(IBAFZ) Q:IBAFZ="ALL"&(IB="")  Q:IBAFZ="NULL"&(IB]"")
 I IB=""!($G(IBAFZ)="ALL") G BUILD
 I IBAFF="@",IBAFL="" G BUILD
 ; IB*752/DTG if name (#.02) make IB upper case before check
 I ($G(IBAF)=".02"&('IB)) S IB=$$UP^XLFSTR(IB)
 I +IBAFF=IBAFF,+IBAFL=IBAFL Q:IB<IBAFF!(IB>IBAFL)
 ;E  Q:IBAFF]IB!(IB]IBAFL)
 I '((+IBAFF=IBAFF)&(+IBAFL=IBAFL)) Q:IBAFFO]$E(IB,1,$L(IBAFFO))!($E(IB,1,$L(IBAFLO))]IBAFLO)
 ;
BUILD ; - Retrieve A/R data and build sort global.
 N IBGRP
 S IBAO=$$ORI^PRCAFN(IBDA) S:IBAO<0 IBAO=0
 S IBAP=$$TPR^PRCAFN(IBDA) S:IBAP<0 IBAP=0
 ;
 ; Add group number to report P447
 S IBGRP=$$POLICY^IBCEF(IBDA,18) S:IBGRP="" IBGRP=0
 ;S ^TMP($J,"IBOTR",IBDIV,IBBRTY,IBINS,$$NAMAGE(DFN,IBEVT)_"@@"_IBBN)=U_IBSCF_U_IBSCT_U_IBDP_U_IBDBC_U_IBAO_U_IBAP_U_IBCFL
 S ^TMP($J,"IBOTR",IBDIV,IBBRTY,IBINS,IBGRP,$$NAMAGE(DFN,IBEVT)_"@@"_IBBN)=U_IBSCF_U_IBSCT_U_IBDP_U_IBDBC_U_IBAO_U_IBAP_U_IBCFL
 I "OP"[IBSORT D
 .;S ^TMP($J,"IBOTR",IBDIV,IBBRTY,IBINS)=$G(^TMP($J,"IBOTR",IBDIV,IBBRTY,IBINS))+$S(IBSORT="O":(IBAO-IBAP),1:IBAP)
 .S ^TMP($J,"IBOTR",IBDIV,IBBRTY,IBINS,IBGRP)=$G(^TMP($J,"IBOTR",IBDIV,IBBRTY,IBINS))+$S(IBSORT="O":(IBAO-IBAP),1:IBAP)
 Q
 ;
SORT ; - Create sort global based on amount owed/amount paid, if necessary.  Add Group# w/ p447
 N IBGRP
 ;
 I 'IBSDIV S IBDIV=0
 S IBX="" F  S IBX=$O(^TMP($J,"IBOTR",IBDIV,IBX)) Q:IBX=""  D
 .S IBINS="" F  S IBINS=$O(^TMP($J,"IBOTR",IBDIV,IBX,IBINS)) Q:IBINS=""  D
 ..S IBGRP="" F  S IBGRP=$O(^TMP($J,"IBOTR",IBDIV,IBX,IBINS,IBGRP)) Q:IBGRP=""  D
 ...;S IBXX=^(IBGRP),^TMP($J,"IBOTRS",IBDIV,IBX,-IBXX,IBINS,IBGRP)=""
 ...S IBXX=$G(^TMP($J,"IBOTR",IBDIV,IBX,IBINS,IBGRP)),^TMP($J,"IBOTRS",IBDIV,IBX,-IBXX,IBINS,IBGRP)=""
 K IBX,IBXX
 Q
 ;
NAMAGE(DFN,EVT) ; - Return patient name and age.
 ;  Input: DFN = Pointer to patient in file #2
 ;         EVT = Event Date of claim
 ; Output: Patient name (1st 18 chars.)_"("_Age_")"
 ; Output after patch 447: Patient name (1st 16 chars.)_"("_Age_")"
 N DPT0,X,X1,X2
 S DPT0=$G(^DPT(DFN,0)),X2=$P(DPT0,U,3)
 I 'X2 S X="UNK"
 E  S X1=EVT S:'X1 X1=DT D ^%DTC S X=X\365.25
 ;Q $E($P(DPT0,U),1,18)_" ("_X_")"
 Q $E($P(DPT0,U),1,16)_" ("_X_")"
 ;
PTIN(IBDA) ; Retrieve Payer TIN for insurance company
 ;
 ; IBDA is the IEN of the bill # in file #399 and must be valid
 N IBTIN,IBVAL,Z
 S IBTIN="",Z=""
 I '$G(IBDA) Q IBTIN
 S Z=$O(^IBM(361.1,"B",IBDA,Z))
 Q:'Z IBTIN
 S IBVAL=$G(^IBM(361.1,Z,0))
 S IBTIN=$P(IBVAL,"^",3)
 Q IBTIN  ; Quit with Payer TIN, if it was sent with the ERA
