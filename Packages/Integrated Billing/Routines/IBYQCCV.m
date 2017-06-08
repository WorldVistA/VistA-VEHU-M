IBYQCCV ;ALB/ARH - CONVERSION FOR 399: CONDITION CODES AND BILL PAYER ; 5/1/97
 ;;2.0;INTEGRATED BILLING;**80**;21-MAR-94
 ;
CV ; convert Condition Codes in 399 and add Bill Payer to bills
 ;
 N IBA,IBI,IBX,IBCNT,IBQUIT,IBIFN,IBFN2,IBCCODE,IBCCFN,IBCCAR,IBMESS,IBINS S (IBCNT,IBQUIT)=0,IBMESS=""
 ;
 D MES^XPDUTL("      *  Begin Conversion of Condition Codes and Bill Payer in Bill/Claims file.")
 ;
 S IBI=0 F  S IBI=$O(^DGCR(399.1,IBI)) Q:'IBI  D
 . S IBX=$G(^DGCR(399.1,IBI,0)) I '$P(IBX,U,15) Q
 . S IBX=$P(IBX,U,2) I IBX'="" S IBCCAR(IBX)=IBI
 ;
 F IBI="02","03","05","06","17","18" I '$D(IBCCAR(IBI)) S IBQUIT=1
 I +IBQUIT D ERROR2 G EXIT
 ;
 S IBIFN=0 F  S IBIFN=$O(^DGCR(399,IBIFN))  Q:'IBIFN  D  S IBCNT=IBCNT+1
 . ;
 . ; condition codes changed to pointers
 . S IBFN2=0 F  S IBFN2=$O(^DGCR(399,IBIFN,"CC",IBFN2)) Q:'IBFN2  D
 .. S IBCCODE=$G(^DGCR(399,IBIFN,"CC",IBFN2,0)) I IBCCODE=""!(IBCCODE>79) Q
 .. S IBCCFN=$G(IBCCAR(IBCCODE)) I 'IBCCFN D ERROR Q
 .. S ^DGCR(399,IBIFN,"CC",IBFN2,0)=+IBCCFN
 . ;
 . ; add bill payer nodes (do not execute cross references on old bills)
 . I '$G(^DGCR(399,IBIFN,"MP")),$P($G(^DGCR(399,IBIFN,0)),U,11)="i" D
 .. S IBINS=$G(^DGCR(399,IBIFN,"M"))
 .. I +IBINS S ^DGCR(399,IBIFN,"MP")=+IBINS_U_$P(IBINS,U,12)
 ;
 S IBMESS="" I 'IBIFN S IBMESS="  Conversion Complete."
 ;
EXIT D MSG("         "_IBCNT_" Bills checked/converted."_IBMESS)
 D MES^XPDUTL(.IBA)
 Q
 ;
ERROR ;
 D MSG("             >>>   Error on bill "_$P($G(^DGCR(399,IBIFN,0)),U,1)_": invalid condition code "_IBCCODE)
 Q
ERROR2 ;
 D MSG(""),MSG("             >>>   The conversion did not run.")
 D MSG("                   Not all required Conditions Codes are defined."),MSG("")
 Q
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
