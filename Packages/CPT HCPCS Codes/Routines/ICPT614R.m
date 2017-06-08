ICPT614R ;DLS/DEK- ICPT Pre-Init Driver; 3/3/03 3:03pm
 ;;6.0;CPT/HCPCS;**14**;May 19,  1997
 ;
 ;- This routine will delete the data in the CPT global files (#81, and 81.3).
 ;  These files MUST be reloaded upon completion of the patch istallation.
 ;  The associated file saves (from %GTO) are ICPT6_14.GBL (file 81)
 ;      and ICPT6_14A.GBL (file 81.3)
 ;
PREINIT ;- Pre-Init leaves header node to preserve global placement
 N I,ICPTX,XPDIDTOT
 D BMES^XPDUTL("Deleting the CPT MODIFIER file (#81.3)...")
 S I=0,XPDIDTOT=17500 F  S I=$O(^DIC(81.3,I)) Q:I=""  K ^(I)
 D BMES^XPDUTL("Deleting the CPT file (#81)...")
 F ICPTX=1:1 S I=$O(^ICPT(I)) Q:I=""  K ^(I) I '(ICPTX#500) D
 . I $D(XPDNM) D UPDATE^XPDID(ICPTX) Q
 . W !,"DELETED ",ICPTX," OF ",XPDIDTOT," CODES"
 D BMES^XPDUTL(">>> File deletions complete!  Please use the appropriate global loader")
 D MES^XPDUTL("   to restore the CPT global files from ICPT6_14.GBL (CPT file, #81) and")
 D MES^XPDUTL("   ICPT6_14A.GBL (CPT MODIFIER file, #81.3)  IMMEDIATELY after installing")
 D MES^XPDUTL("   this patch. >>>")
 Q
