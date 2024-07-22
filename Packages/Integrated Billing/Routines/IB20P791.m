IB20P791 ;ALB/AJR - RNB UPDATES FOR 2024 ;01/23/2024
 ;;2.0;INTEGRATED BILLING;**791**;21-MAR-94;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the CLAIMS TRACKING NON-BILLABLE REASONS file (#356.8).
 Q
POST ;
 ; Update RNB for 2024 in file #356.8
 ; Start of Install
 N IBZ,U S U="^"
 D BMSG("    IB*2.0*791 Post-Install starting .....")
 D RNB
 D BMSG("    IB*2.0*791 Post-Install is complete.")
 Q
 ;
RNB ; RNB in fields #.01/piece 1, #.02/piece 2, #.03/piece 3, #.04/piece 4, #.05/piece 5
 N IBA,IBB,IBC,IBCNT,IBCNTA,IBCNTR,IBCNTD,IBCNTM,IBD,IBE,IBF,IBI,IBX,IBY,IBX3,DA,DLAYGO,DIC,DIE,DINUM,DR,X,Y
 S IBCNTA=0
 ;D BMSG(" >> Adding Reason Not Billable (RNB)")
 F IBI=1:1 S IBX=$P($T(NRNB+IBI),";;",2) Q:IBX="Q"  D
 . S IBA=$P(IBX,U),IBB=$P(IBX,U,2),IBC=$P(IBX,U,3),IBD=$P(IBX,U,4)
 . S IBY="    "_IBA_"  "_IBB
 . S IBE=IBB_U_IBC_U_IBD_U_IBA
 . S IBF=+$O(^IBE(356.8,"B",IBB,0))
 . I IBF D  Q:'IBF
 .. S IBX3=$G(^IBE(356.8,IBF,0)),DA=IBF,IBMS="updated"
 .. I $P(IBX3,U,1,4)=IBE S IBF=0 D MSG(IBY_" not re-added") Q
 . I 'IBF D  Q:Y<1
 .. F IBF=100:1 S IBX3=$G(^IBE(356.8,IBF,0)) I IBX3="" S DINUM=IBF Q 
 .. S DLAYGO=356.8,DIC="^IBE(356.8,",DIC(0)="L",X=IBB D FILE^DICN
 .. I Y<1 D MSG(" >> ERROR when adding "_IBY_" to the #356.8 file, log a ticket!") Q
 .. S DA=+Y,IBMS=""
 . S DIE="^IBE(356.8,",DR=".02///"_IBC_";.03///"_IBD_";.04///"_IBA D ^DIE
 . S IBCNTA=IBCNTA+1 D MSG(IBY_$S(IBMS'="":" "_IBMS,1:""))
 ;
 ;D BMSG(" >> Inactivating Reason Not Billable (RNB)")
 S IBCNTD=0
 F IBI=1:1 S IBX=$P($T(IRNB+IBI),";;",2) Q:IBX="Q"  D
 . S IBA=$P(IBX,U),IBB=$P(IBX,U,2)
 . S IBC="    "_IBA_"  "_IBB
 . S IBD=+$O(^IBE(356.8,"B",IBB,0))
 . I 'IBD D MSG(IBC_" not found") Q
 . S IBE=$G(^IBE(356.8,IBD,0)) Q:IBE=""
 . I $P(IBE,U,5) D MSG(IBC_" not re-inactivated") Q
 . S DA=IBD,DIE="^IBE(356.8,",DR=".05///1" D ^DIE
 . S IBCNTD=IBCNTD+1 D MSG(IBC)
 ;
 D BMSG(" >> Reactivating Reason Not Billable (RNB)")
 S IBCNTR=0
 F IBI=1:1 S IBX=$P($T(RARNB+IBI),";;",2) Q:IBX="Q"  D
 . S IBA=$P(IBX,U),IBB=$P(IBX,U,2)
 . S IBC="    "_IBA_"  "_IBB
 . S IBD=+$O(^IBE(356.8,"B",IBB,0))
 . I 'IBD D MSG(IBC_" not found") Q
 . S IBE=$G(^IBE(356.8,IBD,0)) Q:IBE=""
 . I '$P(IBE,U,5) D MSG(IBC_" not reactivated") Q
 . S DA=IBD,DIE="^IBE(356.8,",DR=".05///@" D ^DIE
 . S IBCNTR=IBCNTR+1 D MSG(IBC)
 D BMSG(" >> Changing Reason Not Billable (RNB)")
 S IBCNTM=0
 F IBI=1:1 S IBX=$P($T(MRNB+IBI),";;",2) Q:IBX="Q"  D
 . S IBA=$P(IBX,U),IBB=$P(IBX,U,2),IBC=$P(IBX,U,3),IBD=$P(IBX,U,4)
 . S IBC="    "_IBA_"  "_IBB
 . S IBD=+$O(^IBE(356.8,"B",IBB,0))
 . I 'IBD D MSG(IBC_" not found") Q
 . S IBE=$G(^IBE(356.8,IBD,0)) Q:IBE=""
 . S DA=IBD,DIE="^IBE(356.8,",DR=".02///1;.03///1" D ^DIE
 . S IBCNTM=IBCNTM+1 D MSG(IBC)
 S IBCNT=IBCNTR+IBCNTA+IBCNTD+IBCNTM
 D MSG("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in CLAIMS TRACKING NON-BILLABLE REASONS (#356.8) file")
 Q
 ;
BMSG(IBZ) ;
 D BMES^XPDUTL(IBZ)
 Q
 ;
MSG(IBZ) ;
 D MES^XPDUTL(IBZ)
 Q
 ;
NRNB ; RNB code^name^ecme flag^ecme paper flag (2)
 ;;Q
IRNB ; RNB code^name (2)
 ;;Q
RARNB ; RNB code^name (15)
 ;;999^OTHER
 ;;Q
MRNB ; RNB code^name^ecme flag^ecme paper flag (2)
 ;;B99^RX BILLED PAPER CLAIM^1^1
 ;;Q
