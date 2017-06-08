IBYPPC ;ALB/ARH - IB*2*52 POST INIT:  CM UPDATE FILES ; 16-MAY-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
START ; duplicates are not allowed
 N IBA
 S IBA(1)="",IBA(2)=">>> Charge Master Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D DELBASC ; delete data from BASC files (350.4,350.41)
 D DELMENU ; delete options from menus (moved to another menu)
 ;
 D ADDRT ; add new rate types for CHAMPUS (399.3)
 ;
 D ADDBS^IBYPPC1 ; add Billable Service  (399.1, .2)
 D ADDBE^IBYPPC1 ; add Billable Events   (399.1,  .21)
 D ADDBR^IBYPPC1 ; add Billing Rates     (363.3)
 D ADDCS^IBYPPC1 ; add Charge Sets       (363.1)
 D ADDCI^IBYPPC1 ; add Charge Items      (363.2)
 D ADDRS^IBYPPC1 ; add Rate Schedules    (363)
 ;
 D DRXRV ; replace Rx Charge Set Rev Codes (363.1,.05) with site Default Rx Rec Code (350.9,1.28)
 ;
 S IBA(1)="",IBA(2)=">>> Charge Master Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D TOP^IBYPPC2 ; update/new Types of Plans (355.1)
 ;
 Q
 ;
DELBASC ; delete data in the two BASC files (350.4,350.41)
 N IBA,IBFILE
 S IBFILE=$P($G(^IBE(350.4,0)),U,1,2) K ^IBE(350.4) S ^IBE(350.4,0)=IBFILE_U
 S IBFILE=$P($G(^IBE(350.41,0)),U,1,2) K ^IBE(350.41) S ^IBE(350.41,0)=IBFILE_U
 S IBA(1)="      >> Data deleted from BASC files (350.4 and 350.41)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
DELMENU ; Delete 2 options from 'IB SYSTEM DEFINITION MENU' - they are moved to the Charge Master Menu
 N IBA,IBCNT,Y,X,DA,DIK S IBCNT=0
 S Y=$O(^DIC(19,"B","IB SYSTEM DEFINITION MENU",0)) Q:Y=""
 S X=$O(^DIC(19,"B","IB ACTIVATE REVENUE CODES",0)) Q:X=""
 S X=$O(^DIC(19,+Y,10,"B",X,0))
 I +X S DA(1)=+Y,DA=+X,DIK="^DIC(19,"_+Y_",10," D ^DIK K DA,DIK S IBCNT=IBCNT+1
 ;
 S Y=$O(^DIC(19,"B","IB SYSTEM DEFINITION MENU",0)) Q:Y=""
 S X=$O(^DIC(19,"B","IB FAST ENTER BILLING RATES",0)) Q:X=""
 S X=$O(^DIC(19,+Y,10,"B",X,0))
 I +X S DA(1)=+Y,DA=+X,DIK="^DIC(19,"_+Y_",10," D ^DIK K DA,DIK S IBCNT=IBCNT+1
 S IBA(1)="      >> "_IBCNT_" deleted options from IB SYSTEM DEFINITION MENU...",IBA(2)=" "
 D MES^XPDUTL(.IBA)
 Q
 ;
ADDRT ; Add Rate Types for CHAMPUS (399.3)
 N IBA,IBCNT,IBI,IBLN,IBFN,IBAR,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 I $O(^DGCR(399.3,"B","CHAMPURZ"))["CHAMPUS" D  G RTQ
 . D MSG("         **** A CHAMPUS Rate Type already exists, new ones not added.")
 ;
 F IBI=1:1 S IBLN=$P($T(RTF+IBI^IBYPPC5),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I $O(^DGCR(399.3,"B",$P(IBLN,U,1),0)) Q
 . S IBAR=$P(IBLN,U,6),IBAR=$O(^PRCA(430.2,"B",IBAR,0)) I 'IBAR D  Q
 .. D MSG("         **** AR Category "_$P(IBLN,U,6)_" does not exist, RT not added.")
 . ;
 . K DD,DO S DLAYGO=399.3,DIC="^DGCR(399.3,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02////"_$P(IBLN,U,2)_";.04////"_$P(IBLN,U,4)_";.05////"_$P(IBLN,U,5)_";.06////"_IBAR_";.08////"_$P(IBLN,U,8)_";.09////"_$P(IBLN,U,9)
 . S DIE="^DGCR(399.3,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
RTQ S IBA(1)="      >> "_IBCNT_" CHAMPUS Rate Types added (399.3)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
 ;
DRXRV ; add the site Default Rx Rev Code (350.9,1.28) to all RX Billable Event Charge Sets (363.1)
 ;
 N IBA,IBMSG,IBDRVCD,IBI,IBBE,DIC,DIE,DA,DR,X,Y S IBMSG="      >> No Rx Charge Sets Rev Code replaced..."
 ;
 S IBDRVCD=$P($G(^IBE(350.9,1,1)),U,28),IBDRVCD=$$RVCD(IBDRVCD) I 'IBDRVCD D  G DRXRVQ
 . S IBMSG="      >> No site Default Rx Rev Code: no Rx Charge Sets Rev Code replaced..."
 ;
 S IBI=0 F  S IBI=$O(^IBE(363.1,IBI)) Q:'IBI  D
 . S IBBE=$P($G(^IBE(363.1,IBI,0)),U,3) Q:'IBBE
 . I $P($G(^DGCR(399.1,+IBBE,0)),U,1)'="PRESCRIPTION FILL" Q
 . S DA=IBI,DIE="^IBE(363.1,",DR=".05////"_IBDRVCD D ^DIE
 . S IBMSG="      >> Site Default Rx Rev Code added to Rx Charge Sets..."
 ;
DRXRVQ S IBA(1)=" ",IBA(2)=IBMSG
 D MES^XPDUTL(.IBA)
 Q
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
RVCD(RVCD) ; returns IFN if revenue code is valid and active
 N IBX,IBY S IBY=""
 I +$G(RVCD) S IBX=$G(^DGCR(399.2,+RVCD,0)) I +$P(IBX,U,3) S IBY=RVCD
 Q IBY
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
