DG1112P ;BIR/JFW - DG*5.3*1112 Post-Init ; 10/11/23 3:18pm
 ;;5.3;Registration;**1112**;Aug 13, 1993;Build 1
 ;
 ;BMES^XPDUTL and MES^XPDUTL - DBIA #10141 Supported
 ;
 ;STORY VAMPI-21549 (jfw) - Update 3 Name Values in File #47.77
 ;
POST ;
 D BMES^XPDUTL("Post-Install: Starting")
 D BMES^XPDUTL("  Updating Sexual Orientations in File #47.77"),MES^XPDUTL("")
 D UPSONMES("SOLST1","SOLST2")  ;Update SO Names in File #47.77
 D BMES^XPDUTL("Post-Install: Finished")
 Q
 ;
 ;Input:
 ; DGLSTB - List of Before Values in 47.77 to update
 ; DGLSTA - List of After Values in 47.77 to update with
UPSONMES(DGLSTB,DGLSTA) ;Update SO Names in File #47.77 as identified in lists
 N DGI,DGENTRY,DGIEN,DGFDA,DGERR
 F DGI=1:1 S DGENTRY=$P($T(@DGLSTB+DGI),";;",2) Q:(DGENTRY="")  D
 .S DGIEN=$$FIND1^DIC(47.77,"","B",DGENTRY,"","","")
 .I (DGIEN=0) D MES^XPDUTL("  ERROR: Could not find '"_DGENTRY_"'") Q
 .S DGFDA(47.77,DGIEN_",",.01)=$P($T(@DGLSTA+DGI),";;",2)
 .D FILE^DIE("EK","DGFDA","DGERR")
 .I $D(DGERR) D BMES^XPDUTL("  ERROR: '"_DGENTRY_"' was NOT updated."),MES^XPDUTL("       [#"_$G(DGERR("DIERR",1))_": "_$G(DGERR("DIERR",1,"TEXT",1))_"]") Q
 .D MES^XPDUTL("  '"_DGENTRY_"' TO '"_$P($T(@DGLSTA+DGI),";;",2)_"'")
 Q
 ;
SOLST1 ;List of Sexual Orientation Types (Current)
 ;;Lesbian, Gay or Homosexual
 ;;Another Option, please describe
 ;;Choose not to disclose
 ;;
SOLST2 ;List of Sexual Orientation Types (To Be)
 ;;Lesbian or Gay
 ;;A sexual orientation not listed here
 ;;Prefer not to answer
 ;;
