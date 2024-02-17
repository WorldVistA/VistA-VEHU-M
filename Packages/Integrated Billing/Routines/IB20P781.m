IB20P781 ;MNTVBB/RXD - UPDATE RX ADMINISTRATIVE FEE FOR CY 2024 ; 11/22/2023
 ;;2.0;INTEGRATED BILLING;**781**;21-MAR-94;Build 1
 ;;Per VA Directive 6402, this routine should not be modified.
 ; Reference to MES^XPDUTL in ICR #10141
 Q
POST ; Update pharmacy administrative fee for CY 2024 in Rate Schedule file 363
 N IBA,U S U="^"
 D MSG("IB*2.0*781 Post-Install starts.....")
 D RXUPD
 D MSG("IB*2.0*781 Post-Install is complete.")
 Q
 ;
RXUPD ; Rate Schedule
 N IBCT,IBI,IBT,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MSG("")
 D MSG("  >>>Effect. JAN 01, 2024 of RX Rate Schedule Adjustment for the Rate Type:"),MSG("")
 S IBADFE="",IBEFFDT="3240101",IBCT=0
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";;",2) Q:IBT="Q"  D
 . S IBRATY=$P(IBT,U)
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,0))
 . I 'IBRSIN D MSG("       "_IBRATY_" not defined in the Rate Type file (#399.3), not added") Q
 . ; latest entry
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,99999),-1)
 . I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) D MSG("       "_IBRATY_" inactivated in the Rate Type file (#399.3), not added") Q
 . I $$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" already exists") Q
 . S IBDISP=$P(IBT,U,2)
 . S IBADJUST=$P(IBT,U,3)
 . ; inactivate rx entry for cy 2023 and add new rx entry for cy 2024
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . ; double check if no active RS
 . I '$$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBRATY_" not added, no active RX Rate Schedule found") Q
 . S IBCT=IBCT+1 D MSG("       "_IBRATY)
 D MSG("")
 D MSG("     Total "_IBCT_$S(IBCT>1:" entries",1:" entry")_" added to the Rate Schedule file (#363)")
 D MSG("")
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
 ;
RSF ; 23 Rate types^dispensing fee^adjustment
 ;;CC MTF REIMB INS^17.01^S X=X+17.01
 ;;CC NO-FAULT AUTO^17.01^S X=X+17.01
 ;;CC REIMB INS^17.01^S X=X+17.01
 ;;CC TORT FEASOR^17.01^S X=X+17.01
 ;;CC WORKERS' COMP^17.01^S X=X+17.01
 ;;CCN NO-FAULT AUTO^17.01^S X=X+17.01
 ;;CCN REIMB INS^17.01^S X=X+17.01
 ;;CCN TORT FEASOR^17.01^S X=X+17.01
 ;;CCN WORKERS' COMP^17.01^S X=X+17.01
 ;;CHOICE NO-FAULT AUTO^17.01^S X=X+17.01
 ;;CHOICE REIMB INS^17.01^S X=X+17.01
 ;;CHOICE TORT FEASOR^17.01^S X=X+17.01
 ;;CHOICE WORKERS' COMP^17.01^S X=X+17.01
 ;;DENTAL REIMB. INS.^17.01^S X=X+17.01
 ;;HUMANITARIAN^17.01^S X=X+17.01
 ;;HUMANITARIAN REIMB. INS.^17.01^S X=X+17.01
 ;;INELIGIBLE^17.01^S X=X+17.01
 ;;INTERAGENCY^17.01^S X=X+17.01
 ;;INELIGIBLE REIMB. INS.^17.01^S X=X+17.01
 ;;NO FAULT INS.^17.01^S X=X+17.01
 ;;REIMBURSABLE INS.^17.01^S X=X+17.01
 ;;TORT FEASOR^17.01^S X=X+17.01
 ;;WORKERS' COMP.^17.01^S X=X+17.01
 ;;Q
 ;
