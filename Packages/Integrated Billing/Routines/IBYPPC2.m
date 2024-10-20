IBYPPC2 ;ALB/ARH - IB*2*52 POST INIT:  CM UPDATE FILES 355.1 ; 16-MAY-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TOP ; Add/edit Type of Plans (355.1)
 N DLAYGO,IBA
 S DLAYGO=355.1 D ATOP,ETOP,NTOP K DLAYGO
 S IBA(1)="" D MES^XPDUTL(.IBA)
 Q
 ;
ATOP ; Add new Type of Plans (355.1)
 N IBA,IBCNT,IBI,IBJ,IBLN,IBFN,IBMC,IBLABEL,IBARR,IBX,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(TPAF+IBI^IBYPPC8),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . S IBX=$P(IBLN,U,1)
 . I $D(^IBE(355.1,"B",$E(IBX,1,30))) Q
 . ;
 . K DD,DO S DLAYGO=355.1,DIC="^IBE(355.1,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S IBMC=$$MCAT($P(IBLN,U,3))
 . ;
 . S DR=".02////"_$P(IBLN,U,2)_";.03////"_IBMC
 . S DIE="^IBE(355.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 . ;
 . S IBLABEL=$P(IBLN,U,4) K IBARR
 . F IBJ=1:1 S IBLN=$P($T(@IBLABEL+IBJ^IBYPPC8),";;",2) Q:+IBLN!(IBLN="")  S IBARR(IBJ)=IBLN
 . ;
 . I $O(IBARR(0)) S IBFN=IBFN_"," D WP^DIE(355.1,IBFN,10,"","IBARR")
 ;
ATOPQ S IBA(1)="      >> "_IBCNT_" Types of Plans added (355.1)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
ETOP ; Edit Type of Plans (355.1)
 N IBA,IBCNT,IBI,IBJ,IBLN,IBFN,IBLABEL,IBARR,IBX,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(TPEF+IBI^IBYPPC8),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . S IBX=$P(IBLN,U,1)
 . S IBFN=$O(^IBE(355.1,"B",$E(IBX,1,30),0)) Q:'IBFN
 . ;
 . S IBLABEL=$P(IBLN,U,4) K IBARR
 . F IBJ=1:1 S IBLN=$P($T(@IBLABEL+IBJ^IBYPPC8),";;",2) Q:+IBLN!(IBLN="")  S IBARR(IBJ)=IBLN
 . ;
 . I $O(IBARR(0)) S IBFN=IBFN_"," D WP^DIE(355.1,IBFN,10,"","IBARR") S IBCNT=IBCNT+1
 ;
ETOPQ ;
 Q
 ;
NTOP ; Change Names of Type of Plans (355.1)
 N IBA,IBCNT,IBI,IBJ,IBLN,IBFN,IBMC,IBLABEL,IBARR,IBX,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(TPNF+IBI^IBYPPC8),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D
 . ;
 . S IBX=$P(IBLN,U,1)
 . S IBFN=$O(^IBE(355.1,"B",$E(IBX,1,30),0)) Q:'IBFN
 . ;
 . S DR=".01///"_$P(IBLN,U,2) I $P(IBLN,U,3)'="" S DR=DR_";.02////"_$P(IBLN,U,3)
 . S DIE="^IBE(355.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y S IBCNT=IBCNT+1
 ;
NTOPQ S IBA(1)="      >> Types of Plans Updated (355.1)..."
 D MES^XPDUTL(.IBA)
 Q
 ;
MCAT(NAME) ; find internal major category
 N IBX,IBY,IBI,IBZ S IBY=""
 S IBX=$P($G(^DD(355.1,.03,0)),U,3)
 F IBI=1:1 S IBZ=$P(IBX,";",IBI) Q:IBZ=""  I $P(IBZ,":",2)=NAME S IBY=$P(IBZ,":",1) Q
 Q IBY
