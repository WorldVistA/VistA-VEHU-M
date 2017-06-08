ICD186R ;DLS/DEK- ICDPre-Init Driver; 3/3/03 3:03pm
 ;;18.0;DRG Grouper;**6**;Oct 20, 2000
 ;
 ;- This routine will delete the data in the ICD global files (#80, and 80.1).
 ;  These files MUST be reloaded upon completion of the patch istallation.
 ;  The associated file saves (from %GTO) are ICD18_6.GBL (file 80)
 ;      and ICD18_6A.GBL (file 80.1)
 ;
PREINIT ;- Pre-Init leaves header node to preserve global placement
 N I,ICDX,XPDIDTOT,XPDIDVT
 D BMES^XPDUTL("Deleting the ICD DIAGNOSIS file (#80)...")
 S I=0,XPDIDTOT=14000,XPDIDVT=1
 F ICDX=1:1 S I=$O(^ICD9(I)) Q:I=""  K ^(I) I '(ICDX#500) D
 . I $D(XPDNM) D UPDATE^XPDID(ICDX) Q
 . W !,"DELETED ",ICDX," OF ",XPDIDTOT," CODES"
 S I=0,XPDIDTOT=4200
 D BMES^XPDUTL("Deleting the ICD OPERATION/PROCEDURE file (#80.1)...")
 F ICDX=1:1 S I=$O(^ICD0(I)) Q:I=""  K ^(I) I '(ICDX#200) D
 . I $D(XPDNM) D UPDATE^XPDID(ICDX) Q
 . W !,"DELETED ",ICDX," OF ",XPDIDTOT," CODES"
 D BMES^XPDUTL(">>> File deletions complete!  Please use the appropriate global loader")
 D MES^XPDUTL("   to restore the ICD global files from ICD18_6.GBL (ICD DIAGNOSIS file, #80)")
 D MES^XPDUTL("   and ICD18_6A.GBL (ICD OPERATION/PROCEDURE file, #80.1)  IMMEDIATELY after")
 D MES^XPDUTL("   installing this patch. >>>")
 Q
