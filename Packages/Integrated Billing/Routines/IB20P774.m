IB20P774 ;MNTVBB/RD - UPDATE TRICARE RX ADMINISTRATIVE FEE FOR CY 2024 ; 09/01/2023@12:56
 ;;2.0;INTEGRATED BILLING;**774**;21-MAR-94;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update TRICARE pharmacy administrative fee for CY 2024 in Rate Schedule (#363) file
 N IBA,U S U="^"
 D BMSG("IB*2.0*774 Post-Install starts.....")
 D TRXAF
 D BMSG("IB*2.0*774 Post-Install is complete.")
 Q
 ;
TRXAF ; Rate Schedule
 N IBCT,IBI,IBT,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D BMSG("  >>>Effect. JAN 01, 2024 of RX Rate Schedule Adjustment for the Rate Type:")
 S IBADFE="",IBEFFDT="3240101",IBCT=0
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";;",2) Q:IBT="Q"  D
 . S IBRATY=$P(IBT,U)
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,0))
 . I 'IBRSIN D MSG("       "_IBRATY_" not defined in the RATE TYPE (#399.3) file, not added") Q
 . ; latest entry
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,99999),-1)
 . I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) D MSG("       "_IBRATY_" inactivated in the RATE TYPE (#399.3) file, not added") Q
 . I $$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" already exists") Q
 . S IBDISP=$P(IBT,U,2)
 . S IBADJUST=$P(IBT,U,3)
 . ; inactivate rx RS for cy 2023 and add new rx RS for cy 2024
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . ; double check if no active RS
 . I '$$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" not added, no active RX Rate Schedule found") Q
 . S IBCT=IBCT+1 D MSG("       "_IBRATY)
 D BMSG("     Total "_IBCT_$S(IBCT>1:" entries",1:" entry")_" added to the RATE SCHEDULE (#363) file")
 Q
 ;
RSEXIST(IBEFFDT,IBRSIN) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN))  Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,2)=IBRSIN,$P(IBRS0,U,5)=IBEFFDT S IBX=IBRSFN
 Q IBX
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
BMSG(IBA) ;
 D BMES^XPDUTL(IBA)
 Q
 ;
RSF ; 3 Rate types^dispensing fee^adjustment
 ;;TRICARE^13.26^S X=X+13.26
 ;;TRICARE PHARMACY^13.26^S X=X+13.26
 ;;TRICARE REIMB. INS.^13.26^S X=X+13.26
 ;;Q
 ;
