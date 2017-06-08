IBYPPR1 ;ALB/ARH - IB*2.0*106 PRE/POST INIT:  REASONABLE CHARGES CONT; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 Q
 ;
ADDBS ; Add Bedsection (399.1, .12=1)
 N IBA,IBCNT,IBI,IBLN,IBFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(BSF+IBI),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I +$$MCCRUTL($P(IBLN,U,1),5) Q
 . ;
 . K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".03////"_$P(IBLN,U,2)_";.12////"_1
 . S DIE="^DGCR(399.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
BSQ S IBA(1)="      >> "_IBCNT_" Bedsection added (399.1)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
ADDBE ; Add Billable Events (399.1, .21=1)
 N IBA,IBCNT,IBI,IBLN,IBFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(BEF+IBI),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I +$$MCCRUTL($P(IBLN,U,1),14) Q
 . ;
 . K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".03////"_$P(IBLN,U,2)_";.21////"_1
 . S DIE="^DGCR(399.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
BEQ S IBA(1)="      >> "_IBCNT_" Billable Events added (399.1)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
ADDBI ; Add Billing Items (363.21)
 N IBA,IBCNT,IBI,IBLN,IBFN,IBX,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(BIF+IBI),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . S IBX=$O(^IBA(363.21,"B",$P(IBLN,U,1),0)) I +IBX,$P($G(^IBA(363.21,IBX,0)),U,2)=$P(IBLN,U,2) Q
 . ;
 . S DIC("DR")=".02////"_$P(IBLN,U,2)
 . K DD,DO S DLAYGO=363.21,DIC="^IBA(363.21,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC,DLAYGO I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 ;
BIQ S IBA(1)="      >> "_IBCNT_" Billing Items added (363.21)..."
 D MES^XPDUTL(.IBA)
 Q
ADDBR ; Add Billing Rates (363.3)
 N IBA,IBCNT,IBI,IBJ,IBBR,IBLN,IBFN,DD,DO,DINUM,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(BRF+IBI),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . I $O(^IBE(363.3,"B",$P(IBLN,U,1),0)) Q
 . ;
 . F IBJ=1:1 S IBBR=$G(^IBE(363.3,IBJ,0)) I IBBR="" S DINUM=IBJ Q
 . ;
 . K DD,DO S DLAYGO=363.3,DIC="^IBE(363.3,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02////"_$P(IBLN,U,2)_";.03////"_$P(IBLN,U,3)_";.04////"_$P(IBLN,U,4)_";.05////"_$P(IBLN,U,5)
 . S DIE="^IBE(363.3,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
BRQ S IBA(1)="      >> "_IBCNT_" Billing Rates added (363.3)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
ADDRS ; add Rate Schedules (363) for Reasonable Charges, if this is the first time the patch is installed
 ; (charge sets will be added when rates are uploaded)
 N IBA,IBCNT,IBI,IBLN,IBFN,IBRT,IBBS,IBJ,IBLNCS,IBCS,IBCSFN,IBSTDT,IBRS,DINUM,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBSTDT="",IBCNT=0
 ;
 I $O(^IBE(363.3,"B","RC INPATIENT FACILITY",0)) G RSQ
 ;
 S IBSTDT=2990901 I '$$PROD^IBCORC S IBSTDT=2981001
 ;
 F IBI=1:1 S IBLN=$P($T(RSF+IBI),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . S IBBS=$P(IBLN,U,4) I IBBS'="" S IBBS=$$MCCRUTL(IBBS,13) D  Q:'IBBS
 .. I 'IBBS D MSG("         **** Billable Service "_$P(IBLN,U,4)_" not defined, RS "_$P(IBLN,U,1)_" not created")
 . ;
 . S IBRT=$P(IBLN,U,2),IBRT=$O(^DGCR(399.3,"B",IBRT,0)) D  Q:'IBRT
 .. I 'IBRT D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not defined, RS "_$P(IBLN,U,1)_" not created")
 .. I +$P($G(^DGCR(399.3,+IBRT,0)),U,3) S IBRT=0 D MSG("         **** Rate Type "_$P(IBLN,U,2)_" not Active, RS "_$P(IBLN,U,1)_" not created")
 . ;
 . F IBJ=1:1 S IBRS=$G(^IBE(363,IBJ,0)) I IBRS="" S DINUM=IBJ Q
 . ;
 . K DD,DO S DLAYGO=363,DIC="^IBE(363,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02////"_IBRT_";.03////"_$P(IBLN,U,3) S:+IBBS DR=DR_";.04////"_IBBS S DR=DR_";.05////"_IBSTDT
 . S DIE="^IBE(363,",DA=+Y D ^DIE K DIE,DA,DR,X,Y
 . ;
 . ; charge sets (multiple)
 . S IBLNCS=$P(IBLN,":",2,999) I IBLNCS'="" F IBJ=1:1 S IBCS=$P(IBLNCS,":",IBJ) Q:IBCS=""  D
 .. S IBCSFN=$O(^IBE(363.1,"B",IBCS,0)) Q:'IBCSFN
 .. ;
 .. S DLAYGO=363,DA(1)=+IBFN,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="L",X=IBCS,DIC("DR")=".02////"_1,DIC("P")="363.0011P" D ^DIC K DIC,DIE
 ;
RSQ S IBA(1)="      >> "_IBCNT_" Rate Schedules added, active on "_$E(IBSTDT,4,5)_"/"_$E(IBSTDT,6,7)_"/"_$E(IBSTDT,2,3)_" (363)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
 ;
BSF ;  Bedsections (399.1,.12)
 ;; name ^ abbreviation
 ;;    
 ;;SKILLED NURSING/SUB-ACUTE CARE^SN/SA
 ;;OBSERVATION CARE^OBSERVATION
 ;;
 ;
BEF ;  Billable Events (399.1,.21)
 ;; name ^ abbreviation
 ;;  
 ;;INPATIENT DRG^DRG
 ;;UNASSOCIATED^UA
 ;;
BIF ;  Billing Items (363.21)
 ;; name ^ type
 ;;  
 ;;SKILLED NURSING CARE^9
 ;;SUB-ACUTE CARE^9
 ;;
BRF ;  Billing Rates File (363.3)
 ;; name ^ abbreviation ^ distribution ^ billable item ^ charge method
 ;; 
 ;;RC INPATIENT FACILITY^RC INPT^1^4^1
 ;;RC SKILLED NURSING/SUB-ACUTE^RC SN/SA^1^9^1
 ;;RC OUTPATIENT FACILITY^RC OPT^1^2^1
 ;;RC PHYSICIAN^RC PHYS^1^2^1
 ;;
RSF ;  Rate Schedules (363)
 ;; rs name ^ rate type ^ bill type ^ billable service ^ effective date ^^ charge sets
 ;; 
 ;;RI-INPT^REIMBURSABLE INS.^1^^
 ;;RI-OPT^REIMBURSABLE INS.^3^^
 ;;RI-RX^REIMBURSABLE INS.^3^^^^:TL-RX FILL
 ;; 
 ;;NF-INPT^NO FAULT INS.^1^^
 ;;NF-OPT^NO FAULT INS.^3^^
 ;;NF-RX^NO FAULT INS.^3^^^^:TL-RX FILL
 ;; 
 ;;WC-INPT^WORKERS' COMP.^1^^
 ;;WC-OPT^WORKERS' COMP.^3^^
 ;;WC-RX^WORKERS' COMP.^3^^^^:TL-RX FILL
 ;;
