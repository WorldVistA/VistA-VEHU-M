IBYPPD1 ;ALB/ARH - IB*2*175 POST INIT: RESET TORT FEASOR TO REASONABLE CHARGES ; 06/05/03
 ;;2.0;INTEGRATED BILLING;**175**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; 
ADDRSI(EFFDT) ; Inactivate Existing Tort Feasor Rate Schedules
 N IBA,IBCNT,IBENDDT,IBRSFN,IBRS0,IBRSNM,IBRSRT,IBRATET,DD,DO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 S IBENDDT="" I +$G(EFFDT) S IBENDDT=$$FMADD^XLFDT(EFFDT,-1)
 I 'IBENDDT D MSG("**Error: No Date, could not inactivate old RS") G ADDRSIQ
 ;
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN)) Q:'IBRSFN  D
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . ;
 . S IBRSNM=$P(IBRS0,U,1)
 . S IBRSRT=$P(IBRS0,U,2) Q:'IBRSRT  S IBRATET=$P($G(^DGCR(399.3,+IBRSRT,0)),U,1)
 . ;
 . I IBRATET'["TORT FEASOR",$E(IBRSNM,1,3)'="TF-" Q  ; tort feasor only
 . ;
 . I ($P(IBRS0,U,5)'="")!($P(IBRS0,U,6)'="") Q  ; dates already set
 . ;
 . S IBCNT=IBCNT+1,DR=".06////"_IBENDDT,DIE="^IBE(363,",DA=+IBRSFN D ^DIE K DIE,DA,DR,X,Y
 ;
ADDRSIQ S IBA(1)="      >> "_IBCNT_" Tort Feasor Rate Schedules inactivated on "_$$FMTE^XLFDT(IBENDDT,2)_" (363)"
 D MES^XPDUTL(.IBA)
 Q
 ;
 ;
ADDRS(EFFDT) ; add Tort Feasor Rate Schedules (363) for Reasonable Charges, if they don't already exist
 ; (all RC charge sets added here in post init and whenever RC rates are uploaded)
 N IBA,IBCNT,IBI,IBLN,IBFN,IBRT,IBBS,IBJ,IBSTDT,IBRS,IBCNTCS,DINUM,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 S IBSTDT=+$G(EFFDT) I 'IBSTDT D MSG("**Error: No Date, could not link Rate Schedules to Charge Sets") G ADDRSQ
 ;
 I $$RSEXISTS(IBSTDT,"TF-INPT") D MSG("No Change, Rate Schedule linking TF and RC already exists") G ADDRSQ
 ;
 F IBI=1:1 S IBLN=$P($T(RSF+IBI),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . S IBBS=$P(IBLN,U,4) I IBBS'="" S IBBS=$$MCCRUTL(IBBS,13) D  Q:'IBBS
 .. I 'IBBS D MSG("** Error: Billable Service "_$P(IBLN,U,4)_" not defined, RS "_$P(IBLN,U,1)_" not created")
 . ;
 . S IBRT=$P(IBLN,U,2),IBRT=$O(^DGCR(399.3,"B",IBRT,0)) D  Q:'IBRT
 .. I 'IBRT D MSG("** Error: Rate Type "_$P(IBLN,U,2)_" not defined, RS "_$P(IBLN,U,1)_" not created")
 .. I +$P($G(^DGCR(399.3,+IBRT,0)),U,3) S IBRT=0 D MSG("** Warning: Rate Type "_$P(IBLN,U,2)_" not Active, RS "_$P(IBLN,U,1)_" not created")
 . ;
 . F IBJ=1:1 S IBRS=$G(^IBE(363,IBJ,0)) I IBRS="" S DINUM=IBJ Q
 . ;
 . K DD,DO S DLAYGO=363,DIC="^IBE(363,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1,IBCNTCS=0
 . ;
 . S DR=".02////"_IBRT_";.03////"_$P(IBLN,U,3) S:+IBBS DR=DR_";.04////"_IBBS S DR=DR_";.05////"_IBSTDT
 . S DIE="^IBE(363,",DA=+Y D ^DIE K DIE,DA,DR,X,Y
 . ;
 . S IBCNTCS=IBCNTCS+$$RSCS(IBFN) ; add all Reasonable Charges Charge Sets
 . ;
 . I 'IBCNTCS D MSG("** Warning: No Charge Sets added to RS "_$P(IBLN,U,1))
 ;
ADDRSQ S IBA(1)="      >> "_IBCNT_" Tort Feasor Rate Schedules added for RC, active "_$$FMTE^XLFDT(IBSTDT,2)_" (363)"
 D MES^XPDUTL(.IBA)
 Q
 ;
 ;
RSCS(RSFN) ; add existing Reasonable Charges Charge Sets to Rate Schedule, return number added
 ; copy the Charge Sets from the corresponding RI Rate Schedule (RC V2.0)
 N IBCNT,IBRS0,IBBTYPE,IBRSNM,IB2DT,IBCOPY,IBXFN,IBLN,IBCSFN,IBCS0,IBAA S (IBCOPY,IBCNT)=0
 ;
 S IBRS0=$G(^IBE(363,+$G(RSFN),0)),IBRSNM=$P(IBRS0,U,1)
 S IBBTYPE=$P(IBRS0,U,3)
 S IB2DT=$$VERSDT^IBCRU8(2)
 ;
 I IBRSNM["INPT" S IBCOPY=+$$RSEXISTS(IB2DT,"RI-INPT")
 I IBRSNM["SNF" S IBCOPY=+$$RSEXISTS(IB2DT,"RI-SNF")
 I IBRSNM["OPT" S IBCOPY=+$$RSEXISTS(IB2DT,"RI-OPT")
 I IBRSNM["RX" S IBCOPY=+$$RSEXISTS(IB2DT,"RI-RX")
 I 'IBCOPY G RSCSQ
 ;
 I +$P($G(^IBE(363,+IBCOPY,0)),U,3)=IBBTYPE D
 . ;
 . S IBXFN=0 F  S IBXFN=$O(^IBE(363,IBCOPY,11,IBXFN)) Q:'IBXFN  D
 .. ;
 .. S IBLN=$G(^IBE(363,IBCOPY,11,IBXFN,0)),IBCSFN=+IBLN,IBAA=$P(IBLN,U,2),IBCS0=$G(^IBE(363.1,IBCSFN,0))
 .. I +$$RSCSFILE(RSFN,$P(IBCS0,U,1),IBAA) S IBCNT=IBCNT+1
 ;
RSCSQ Q IBCNT
 ;
RSCSFILE(RSFN,CSNM,AA) ; Add Charge Set to a Rate Schedule
 N IBX,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBCSFN S IBX=0
 I $G(^IBE(363,+$G(RSFN),0))="" G RSCSFQ
 I $G(CSNM)="" G RSCSFQ
 S IBCSFN=$O(^IBE(363.1,"B",CSNM,0)) I 'IBCSFN G RSCSFQ
 I $O(^IBE(363,RSFN,11,"B",IBCSFN,0)) G RSCSFQ
 ;
 S DLAYGO=363,DA(1)=+RSFN,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="L",X=CSNM,DIC("DR")=".02////"_$G(AA),DIC("P")="363.0011P" D ^DIC K DIC,DIE S IBX=1
RSCSFQ Q IBX
 ;
 ;
RSEXISTS(EFFDT,NAME) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 I +$G(EFFDT),$G(NAME)'="" S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN)) Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,1)=NAME,$P(IBRS0,U,5)=EFFDT S IBX=IBRSFN
 Q IBX
 ;
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)="         "_$G(X)
 Q
 ;
 ;
 ;
RSF ;  Rate Schedules (363)
 ;; rs name ^ rate type ^ bill type ^ billable service ^ effective date ^^ charge sets
 ;; 
 ;;TF-INPT^TORT FEASOR^1^^
 ;;TF-SNF^TORT FEASOR^1^SKILLED NURSING^
 ;;TF-OPT^TORT FEASOR^3^^
 ;;TF-RX^TORT FEASOR^3^
 ;;
