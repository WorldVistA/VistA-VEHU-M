ECX3P189 ;MNTVBB/DTA - NATIONAL CLINIC (#728.441) File Update; FEB 1, 2024@16:44
 ;;3.0;DSS EXTRACTS;**189**;Dec 22, 1997;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the NATIONAL CLINIC (#728.441) file for FY24 Mid-Year.
 ;
 ; Reference(s) to $$FIND1^DIC supported by ICR# 2051
 ; Reference(s) to FILE^DIE supported by ICR# 2053
 ; Reference(s) to UPDATE^DIE supported by ICR# 2053
 ; Reference(s) to BMES^XPDUTL supported by ICR# 10141
 ; Reference(s) to MES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
POST ;routine entry point
 ;
 ; Start of Install
 D BMES^XPDUTL("Update NATIONAL CLINIC (#728.441) file starts.")
 D ADD    ;add new code
 D UPDATE ;change short description of existing clinic codes
 D BMES^XPDUTL("Update complete.")
 D MES^XPDUTL("")
 ;
 Q
 ;
ADD ; Add new code
 ;
 N ECXI,ECXREC,ECXNM,ECXCODE,ECXIEN,ECXERR
 D BMES^XPDUTL(">>> Adding new CHAR4 code(s) to the NATIONAL CLINIC file (#728.441)...")
 ;
 F ECXI=1:1 S ECXREC=$P($T(ADDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
 . S ECXNM=$P(ECXREC,U)     ;Name
 . S ECXCODE=$P(ECXREC,U,2) ;Code
 . ; check if new code already exists in file 728.441
 . S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ECXERR")
 . ; quit if error
 . I $D(ECXERR) D  Q
 . . D BMES^XPDUTL("       >> ... Unable to add CHAR4 code "_ECXCODE_" - "_ECXNM_" to file.")
 . . D MES^XPDUTL("        >> ... "_$G(ECXERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("        >> ... Please contact support for assistance...")
 . . K ECXERR
 . ; if code already exists, quit
 . I ECXIEN D  Q
 . . D BMES^XPDUTL("    >> CHAR4 code "_ECXCODE_" - "_ECXNM_" already exists.")
 . ; if code does not exist, add new entry
 . ; set field values of new entry
 . K ECXFDA
 . S ECXFDA(728.441,"+1,",.01)=ECXCODE
 . S ECXFDA(728.441,"+1,",1)=ECXNM
 . ; add new entry
 . D UPDATE^DIE("E","ECXFDA","","ECXERR")
 . ; check if error
 . I '$D(ECXERR) D
 . . D BMES^XPDUTL("    >> CHAR4 Code "_ECXCODE_" - "_ECXNM_" added to file.")
 . I $D(ECXERR) D
 . . D BMES^XPDUTL("    >> ... Unable to add CHAR4 code "_ECXCODE_" "_ECXNM_" to file.")
 . . D MES^XPDUTL("    >> ... "_$G(ECXERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . . ; clean out error array b4 processing next code
 . . K ECXERR
 ;
 D BMES^XPDUTL(">>> Add new CHAR4 code(s) complete.")
 D MES^XPDUTL("")
 Q
 ;
UPDATE ;changing short description of existing entries
 ;ECXREC is in format: code^short description
 ;
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,ECXI,ECXREC,ECXERR
 ;
 D BMES^XPDUTL(">>> Updating entries in the NATIONAL CLINIC (728.441) file...")
 ;
 F ECXI=1:1 S ECXREC=$P($T(UPDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
  .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
  .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ECXERR")
  .I 'ECXIEN D  Q
  ..D BMES^XPDUTL(">>>....Unable to find code: "_ECXCODE_".")
  ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
  .K FDA
  .S FDA(728.441,ECXIEN_",",1)=ECXDESC
  .D FILE^DIE(,"FDA","ECXERR")
  .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_" - "_$P(ECXREC,U,2)_" updated")
  .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to update code "_ECXCODE_".") D
  ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
 ;
 Q
 ;
ADDCLIN ;Add new code
 ;;National Tele-Rheumatology Program (NTRP)^NTRP^^
 ;;QUIT
 ;
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;CGNC^CRH Whole Health (WH)
 ;;CNSF^Surgical Pause/Frailty Evaluation Clinics
 ;;HDLC^Home Based Primary Care Home Health Aide (Pilot)
 ;;HTBC^NEXCSS Phone
 ;;MPAZ^National Mind Brain Program (MBP)
 ;;NASN^Suicide Prevention Coordinator-Team Clinics
 ;;NASR^National Tele-Palliative Care Program
 ;;WCLC^Anatomical-Clinical Pathology
 ;;WCMC^Molecular Pathology
 ;;WCTC^Transfusion Pathology
 ;;QUIT
