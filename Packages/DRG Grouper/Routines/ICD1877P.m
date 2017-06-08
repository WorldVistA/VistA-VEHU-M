ICD1877P ;ALB/JDG - YEARLY DRG UPDATE;8/9/2010
 ;;18.0;DRG Grouper;**77**;Oct 20, 2000;Build 2
 ;
 ;This routine will kick off routines needed for 
 ;FY 2015 updates to the DRG Grouper.
 ;Depending on the year and type of updates needed, not
 ;all of the routines will be needed.
 ;
 Q
 ;
EN ; start update
 D DRG^ICD1877A ;changes for DRGS
 ; ********************************************************************************
 ; *****routines ICD1877F-K contain the DRG info needed for the Grouper update*****
 ; ********************************************************************************
 ;
 ; ******************************************************************************** 
 ; INACTIVATE DRG's (FY 2015 Grouper update)
 ; ********************************************************************************
 D INACTDRG^ICD1877O ;inactivates existing DRGs (490 & 491)
 ; ********************************************************************************
 ;
 ; ********************************************************************************
 ; UPDATES FOR EXISTING DIAGNOSIS CODES (no new Dx CODES for FY2015)
 D ICDUPDDX^ICD1877L ;update the UNACCEPTABLE AS PRINCIPAL DX (#1.3) field
 ; ********************************************************************************
 ;
 ; ********************************************************************************
 ; UPDATES FOR EXISTING OPERATION/PROCEDURE CODES (no new Px CODES for FY2015)
 D UPDTADRG^ICD1877L ;update associated DRGs
 ; ********************************************************************************
 Q
